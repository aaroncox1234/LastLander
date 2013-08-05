//
//  LTSLevel.m
//  LastLander
//
//  Created by Aaron Cox on 2013-06-23.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSLevel.h"
#import "LTSPlatform.h"
#import "LTSConstants.h"

@interface LTSLevel ()

- (id)initWithBackground:(CCSprite *)background platforms:(NSArray *)platforms redShipSpawnZone:(CGRect)redShipSpawnZone playerShipSpawnPoints:(NSArray *)playerShipSpawnPoints;

@end

@implementation LTSLevel

+ (LTSLevel *)createLevel1WithBatchNode:(CCSpriteBatchNode *)batchNode {
	
	CGSize winSize = [CCDirector sharedDirector].winSize;
	CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"LTS_bg_03.png"];
	background.position = ccp(winSize.width/2, winSize.height/2);
	[batchNode addChild:background];
	
	LTSPlatform *platform1 = [LTSPlatform createPlatform1WithBatchNode:batchNode position:ccp(100.0f, 170.0f)];
	LTSPlatform *platform2 = [LTSPlatform createPlatform2WithBatchNode:batchNode position:ccp(320.0f, 240.0f)];
	
	NSArray *platforms = [NSArray arrayWithObjects:platform1, platform2, nil];
	
	CGRect redShipSpawnZone = CGRectMake(450.0f, 0.0f, 450.0f, 150.0f);
	
	NSArray *playerShipSpawnPoints = [NSArray arrayWithObjects:
									  [NSValue valueWithCGPoint:CGPointMake(100.0f, 170.0f)],
									  [NSValue valueWithCGPoint:CGPointMake(320.0f, 240.0f)],
									  nil];
	
	return [[self alloc] initWithBackground:background platforms:platforms redShipSpawnZone:redShipSpawnZone playerShipSpawnPoints:playerShipSpawnPoints];
}

- (id)initWithBackground:(CCSprite *)background platforms:(NSArray *)platforms redShipSpawnZone:(CGRect)redShipSpawnZone playerShipSpawnPoints:(NSArray *)playerShipSpawnPoints {
	
	self = [super init];
	
	if (self) {
		
		_background = background;
		_platforms = platforms;
		_redShipSpawnZone = redShipSpawnZone;
		_redShipSpawnZoneOccupied = NO;
		_playerShipSpawnPoints = playerShipSpawnPoints;
		_redShipSpawnIntervalMin = RED_SHIP_SPAWN_INTERVAL_MIN;
		_redShipSpawnIntervalMax = RED_SHIP_SPAWN_INTERVAL_MAX;
		_redShipSpeedMin = RED_SHIP_SPEED_MIN;
		_redShipSpeedMax = RED_SHIP_SPEED_MAX;
	}
	
	return self;
}


@end
