//
//  LTSGameWorld.m
//  LastLander
//
//  Created by Aaron Cox on 2013-06-17.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSGameWorld.h"
#import "LTSConstants.h"
#import "LTSPlatform.h"
#import "LTSRandom.h"

@interface LTSGameWorld ()
{
	NSArray *_ships;
	
	CGFloat _timeUntilNextRedShipSpawn;
}

- (void)updateSpawning:(ccTime)dt;
- (void)updateEntities:(ccTime)dt;
- (void)prepareCollisionData;
- (void)testCollisions;
- (void)respondToCollisions;

- (bool)testCollision:(NSArray *)polygon1 with:(NSArray *)polygon2;

- (void)chooseNextRedShipSpawnTime;
- (LTSShip *)findAvailableRedShip;
- (LTSSpawnWarningBlip *)findAvailableRedShipSpawnWarningBlip;

@end

@implementation LTSGameWorld

- (id)initWithBatchNode:(CCSpriteBatchNode *)batchNode {
	
	self = [super init];
	
	if (self) {
		
		NSMutableArray *prepBlueShips = [NSMutableArray arrayWithCapacity:BLUE_SHIP_POOL_SIZE];

		for (int i = 0; i < BLUE_SHIP_POOL_SIZE; i++) {

			[prepBlueShips addObject:[LTSShip createBlueShipWithBatchNode:batchNode]];
		}		
		
		_blueShips = prepBlueShips;

		NSMutableArray *prepRedShips = [NSMutableArray arrayWithCapacity:RED_SHIP_POOL_SIZE];
		
		for (int i = 0; i < RED_SHIP_POOL_SIZE; i++) {
			
			[prepRedShips addObject:[LTSShip createRedShipWithBatchNode:batchNode]];
		}
		
		_redShips = prepRedShips;
		
		_ships = [_blueShips arrayByAddingObjectsFromArray:_redShips];
		
		NSMutableArray *prepRedShipSpawnWarningBlips = [NSMutableArray arrayWithCapacity:RED_SHIP_SPAWN_WARNING_BLIP_POOL_SIZE];
		
		for (int i = 0; i < RED_SHIP_SPAWN_WARNING_BLIP_POOL_SIZE; i++) {
			
			[prepRedShipSpawnWarningBlips addObject:[LTSSpawnWarningBlip createRedShipSpawnWarningBlip:batchNode]];
		}
		
		_redShipWarningBlips = prepRedShipSpawnWarningBlips;
		
		_level = [LTSLevel createLevel1WithBatchNode:batchNode];
		
		[self chooseNextRedShipSpawnTime];
	}
	
	return self;
}

- (void)update:(ccTime)dt {
	
	[self updateSpawning:dt];
	[self updateEntities:dt];
	[self prepareCollisionData];
	[self testCollisions];
	[self respondToCollisions];
}

- (void)updateSpawning:(ccTime)dt {
	
	// When the spawn interval elapses, reserve a red ship and display a warning blip where it will spawn.
	
	_timeUntilNextRedShipSpawn -= dt;
	
	if (_timeUntilNextRedShipSpawn <= 0.0f ) {
		
		LTSShip *availableRedShip = [self findAvailableRedShip];
		LTSSpawnWarningBlip *availableRedShipSpawnWarningBlip = [self findAvailableRedShipSpawnWarningBlip];
		
		// If every red ship or red ship spawn warning blip is in use, do nothing until another spawn interval elapses.
		if ( (availableRedShip != NULL) && (availableRedShipSpawnWarningBlip != NULL) ) {
		
			CGPoint spawnPosition = [LTSRandom randomPointInRect:self.level.redShipSpawnZone];
			
			[availableRedShip reserveAtSpawnPosition:spawnPosition];
			
			CGSize winSize = [CCDirector sharedDirector].winSize;
			
			[availableRedShipSpawnWarningBlip spawnAtPosition:ccp(winSize.width, spawnPosition.y) forShip:availableRedShip];
		}
		
		[self chooseNextRedShipSpawnTime];
	}
	
	// When a warning blip's time elapsed, start its corresponding ship.
	
	for (LTSSpawnWarningBlip *redShipWarningBlip in self.redShipWarningBlips ) {
		
		if (redShipWarningBlip.isCountdownFinished && !self.level.redShipSpawnZoneOccupied) {
			
			[redShipWarningBlip setAvailableForUse];
			[redShipWarningBlip.correspondingRedShip spawn];
			
			// Only spawn once per frame.
			break;
		}
	}
}

- (void)updateEntities:(ccTime)dt {
	
	for (LTSShip *ship in _ships) {
		
		[ship update];
	}
	
	for (LTSSpawnWarningBlip *redShipSpawnWarningBlip in _redShipWarningBlips) {
		
		[redShipSpawnWarningBlip update:dt];
	}
}

- (void)prepareCollisionData {
	
	for (LTSShip *ship in _ships) {
		
		[ship prepareCollisionData];
	}
}

- (void)respondToCollisions {
	
	for (LTSShip *ship in _ships) {
		
		[ship respondToCollisions];
	}
}

- (void)testCollisions {
	
	self.level.redShipSpawnZoneOccupied = NO;
	
	for (int shipIndex = 0; shipIndex < [_ships count]; shipIndex++) {
		
		LTSShip *ship = [_ships objectAtIndex:shipIndex];
		
		for (int otherShipIndex = shipIndex + 1; otherShipIndex < [_ships count]; otherShipIndex++) {
		
			LTSShip *otherShip = [_ships objectAtIndex:otherShipIndex];
			
			if ([self testCollision:ship.worldPolygon with:otherShip.worldPolygon]) {
				
				ship.isHitOtherShip = YES;
				otherShip.isHitOtherShip = YES;
			}
		}
		
		for (int platformIndex = 0; platformIndex < [self.level.platforms count]; platformIndex++) {
			
			LTSPlatform *platform = [self.level.platforms objectAtIndex:platformIndex];
			
			if ([self testCollision:ship.worldPolygon with:platform.worldPolygon]) {
				
				ship.isHitPlatform = YES;
			}
		}
		
		if (CGRectIntersectsRect(ship.sprite.boundingBox, self.level.redShipSpawnZone))
		{
			self.level.redShipSpawnZoneOccupied = YES;
		}
	}
}

- (bool)testCollision:(NSArray *)polygon1 with:(NSArray *)polygon2 {
	
	int polygon1Count = [polygon1 count];
	int polygon2Count = [polygon2 count];
	
	for (int polygon1StartIndex = 0; polygon1StartIndex < polygon1Count - 1; polygon1StartIndex++) {
		
		int polygon1EndIndex = polygon1StartIndex + 1;
		
		CGPoint polygon1StartPoint = [[polygon1 objectAtIndex:polygon1StartIndex] CGPointValue];
		CGPoint polygon1EndPoint = [[polygon1 objectAtIndex:polygon1EndIndex] CGPointValue];
		
		for (int polygon2StartIndex = 0; polygon2StartIndex < polygon2Count; polygon2StartIndex++) {
			
			int polygon2EndIndex = polygon2StartIndex + 1;
			
			CGPoint polygon2StartPoint = [[polygon2 objectAtIndex:polygon2StartIndex] CGPointValue];
			CGPoint polygon2EndPoint = [[polygon2 objectAtIndex:polygon2EndIndex] CGPointValue];
			
			if (ccpSegmentIntersect(polygon1StartPoint, polygon1EndPoint, polygon2StartPoint, polygon2EndPoint)) {
				
				return YES;
			}
		}
	}
	
	return NO;
}

- (void)chooseNextRedShipSpawnTime {
	
	_timeUntilNextRedShipSpawn = [LTSRandom randomFloatFrom:_level.redShipSpawnIntervalMin to:_level.redShipSpawnIntervalMax];
}

- (LTSShip *)findAvailableRedShip {
	
	for (LTSShip *redShip in self.redShips) {
		
		if ([redShip isAvailableForUse]) {
			
			return redShip;
		}
	}
	
	return NULL;
}

- (LTSSpawnWarningBlip *)findAvailableRedShipSpawnWarningBlip {

	for (LTSSpawnWarningBlip *redShipSpawnWarningBlip in self.redShipWarningBlips) {
		
		if ([redShipSpawnWarningBlip isAvailableForUse]) {
			
			return redShipSpawnWarningBlip;
		}
	}
	
	return NULL;
}

@end
