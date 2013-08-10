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
#import "LTSDebugDrawLayer.h"

#define DRAW_COLLISION_INFO 0

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

- (LTSShip *)findAvailableShipFrom:(NSArray *)shipArray;

- (void)chooseNextRedShipSpawnTime;
- (LTSSpawnWarningBlip *)findAvailableRedShipSpawnWarningBlip;

- (CGPoint)choosePlayerShipSpawnPoint;

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
		
		NSMutableArray *prepShipExplosions = [NSMutableArray arrayWithCapacity:SHIP_EXPLOSION_POOL_SIZE];
		for (int i = 0; i < SHIP_EXPLOSION_POOL_SIZE; i++) {
			
			[prepShipExplosions addObject:[LTSExplosion createShipExplosionWithBatchNode:batchNode]];
		}
		_shipExplosions = prepShipExplosions;
		
		NSAssert( (_shipExplosions.count == _ships.count), @"The following loop expects a one-to-one matching for ships and ship explosions." );
		for (int i = 0; i < _ships.count; i++) {
			
			LTSShip *ship = [_ships objectAtIndex:i];
			LTSExplosion *explosion = [_shipExplosions objectAtIndex:i];
			ship.explosion = explosion;
		}
		
		NSMutableArray *prepRedShipSpawnWarningBlips = [NSMutableArray arrayWithCapacity:RED_SHIP_SPAWN_WARNING_BLIP_POOL_SIZE];
		for (int i = 0; i < RED_SHIP_SPAWN_WARNING_BLIP_POOL_SIZE; i++) {
			
			[prepRedShipSpawnWarningBlips addObject:[LTSSpawnWarningBlip createRedShipSpawnWarningBlip:batchNode]];
		}
		_redShipWarningBlips = prepRedShipSpawnWarningBlips;
		
		_level = [LTSLevel createLevel1WithBatchNode:batchNode];
		
		[self chooseNextRedShipSpawnTime];
		
		// Start with a single spawned player ship. This might change in the future based on design decisions.
		_playerController = [LTSShipController createShipController];
		LTSShip *playerShip = [self findAvailableShipFrom:_blueShips];
		CGPoint spawnPosition = [self choosePlayerShipSpawnPoint];
		[playerShip spawnWithSpeed:0.0f atSpawnPosition:spawnPosition];
		[playerShip setLanded];
		[_playerController SetControlledShip:playerShip];
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

- (void)onScreenTouchStart:(CGPoint)location {
	
	[self.playerController onScreenTouchStart:location];
}

- (void)onScreenTouchEnd:(CGPoint)location {
	
	[self.playerController onScreenTouchEnd:location];
}

- (void)updateSpawning:(ccTime)dt {
	
	// When the spawn interval elapses, reserve a red ship and display a warning blip where it will spawn.
	
	_timeUntilNextRedShipSpawn -= dt;
	
	if (_timeUntilNextRedShipSpawn <= 0.0f ) {
		
		LTSShip *availableRedShip = [self findAvailableShipFrom:self.redShips];
		LTSSpawnWarningBlip *availableRedShipSpawnWarningBlip = [self findAvailableRedShipSpawnWarningBlip];
		
		// If every red ship or red ship spawn warning blip is in use, do nothing until another spawn interval elapses.
		if ( (availableRedShip != NULL) && (availableRedShipSpawnWarningBlip != NULL /*&& !self.level.redShipSpawnZoneOccupied*/) ) {
		
			CGPoint spawnPosition = [LTSRandom randomPointInRect:self.level.redShipSpawnZone];

			CGSize winSize = [CCDirector sharedDirector].winSize;
			
			spawnPosition.x = winSize.width + (availableRedShip.sprite.contentSize.width *  2.0f);
			
			[availableRedShip reserveAtSpawnPosition:spawnPosition];
			
			[availableRedShipSpawnWarningBlip spawnAtPosition:ccp(winSize.width, spawnPosition.y) forShip:availableRedShip];
		}
		
		[self chooseNextRedShipSpawnTime];
	}
	
	// When a warning blip's time elapsed, start its corresponding ship.
	
	for (LTSSpawnWarningBlip *redShipWarningBlip in self.redShipWarningBlips ) {
		
		if (redShipWarningBlip.isCountdownFinished) {
			
			CGFloat redShipSpeed = [LTSRandom randomFloatFrom:_level.redShipSpeedMin to:_level.redShipSpeedMax];
			
			[redShipWarningBlip setAvailableForUse];
			[redShipWarningBlip.correspondingRedShip spawnWithSpeed:redShipSpeed];
			
			// Only spawn once per frame.
			break;
		}
	}
}

- (void)updateEntities:(ccTime)dt {
	
	[self.playerController update:dt];
	
	for (LTSShip *ship in _ships) {
		
		[ship update:dt];
	}
	
	for (LTSSpawnWarningBlip *redShipSpawnWarningBlip in _redShipWarningBlips) {
		
		[redShipSpawnWarningBlip update:dt];
	}
	
	for (LTSExplosion *shipExplosion in _shipExplosions) {
		
		[shipExplosion update:dt];
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
		
		ship.isHitOtherShip = NO;
		ship.isHitPlatform = NO;
		ship.isHitLandingZone = NO;
	}
	
	for (int shipIndex = 0; shipIndex < [_ships count]; shipIndex++) {
		
		LTSShip *ship = [_ships objectAtIndex:shipIndex];
		
#if DRAW_COLLISION_INFO
		[[LTSDebugDrawLayer getSharedInstance] drawPolygon:ship.worldPolygon];
#endif
		
		for (int otherShipIndex = shipIndex + 1; otherShipIndex < [_ships count]; otherShipIndex++) {
		
			LTSShip *otherShip = [_ships objectAtIndex:otherShipIndex];
			
			if ([self testCollision:ship.worldPolygon with:otherShip.worldPolygon]) {
				
				ship.isHitOtherShip = YES;
				otherShip.isHitOtherShip = YES;
			}
		}
		
		for (int platformIndex = 0; platformIndex < [self.level.platforms count]; platformIndex++) {
			
			LTSPlatform *platform = [self.level.platforms objectAtIndex:platformIndex];

#if DRAW_COLLISION_INFO
			[[LTSDebugDrawLayer getSharedInstance] drawPolygon:platform.worldPolygon];
			[[LTSDebugDrawLayer getSharedInstance] drawRectangle:platform.landingZone];
#endif
			
			if ([self testCollision:ship.worldPolygon with:platform.worldPolygon]) {
				
				ship.isHitPlatform = YES;
			}
			
			if (CGRectIntersectsRect(ship.sprite.boundingBox, platform.landingZone)) {
			
				ship.isHitLandingZone = YES;
			}
		}
		
#if DRAW_COLLISION_INFO
		[[LTSDebugDrawLayer getSharedInstance] drawRectangle:self.level.redShipSpawnZone];
#endif
		if (CGRectIntersectsRect(ship.sprite.boundingBox, self.level.redShipSpawnZone)) {

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
		
		for (int polygon2StartIndex = 0; polygon2StartIndex < polygon2Count - 1; polygon2StartIndex++) {
			
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

- (LTSShip *)findAvailableShipFrom:(NSArray *)shipArray {

	for (LTSShip *ship in shipArray) {
		
		if ([ship isAvailableForUse]) {
			
			return ship;
		}
	}
	
	return NULL;
}

- (void)chooseNextRedShipSpawnTime {
	
	_timeUntilNextRedShipSpawn = [LTSRandom randomFloatFrom:_level.redShipSpawnIntervalMin to:_level.redShipSpawnIntervalMax];
}

- (LTSSpawnWarningBlip *)findAvailableRedShipSpawnWarningBlip {

	for (LTSSpawnWarningBlip *redShipSpawnWarningBlip in self.redShipWarningBlips) {
		
		if ([redShipSpawnWarningBlip isAvailableForUse]) {
			
			return redShipSpawnWarningBlip;
		}
	}
	
	return NULL;
}

- (CGPoint)choosePlayerShipSpawnPoint {
	
	int index = [LTSRandom randomIntFrom:0 to:self.level.playerShipSpawnPoints.count];
	
	return [[self.level.playerShipSpawnPoints objectAtIndex:index] CGPointValue];
}

- (BOOL)isFailed {
	
	return ( (self.playerController != NULL) && (self.playerController.ship != NULL) && self.playerController.ship.isCrashed );
}

@end
