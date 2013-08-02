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

- (id)initWithPlatforms:(NSArray *)platforms redShipSpawnZone:(CGRect)redShipSpawnZone blueShipSpawnZone:(CGRect)blueShipSpawnZone redShipSpawnIntervalMin:(float)redShipSpawnIntervalMin redShipSpawnIntervalMax:(float)redShipSpawnIntervalMax;

@end

@implementation LTSLevel

+ (LTSLevel *)createLevel1WithBatchNode:(CCSpriteBatchNode *)batchNode {
	
	LTSPlatform *platform1 = [LTSPlatform createPlatform1WithBatchNode:batchNode position:ccp(100.0f, 170.0f)];
	LTSPlatform *platform2 = [LTSPlatform createPlatform2WithBatchNode:batchNode position:ccp(320.0f, 240.0f)];
	
	NSArray *platforms = [NSArray arrayWithObjects:platform1, platform2, nil];
	
	CGRect redShipSpawnZone = CGRectMake(450.0f, 0.0f, 450.0f, 150.0f);
	CGRect blueShipSpawnZone = CGRectMake(15.0f, 50.0f, 50.0f, 70.0f);
	
	float redShipSpawnIntervalMin = RED_SHIP_SPAWN_INTERVAL_MIN;
	float redShipSpawnIntervalMax = RED_SHIP_SPAWN_INTERVAL_MAX;
	
	return [[self alloc] initWithPlatforms:platforms redShipSpawnZone:redShipSpawnZone blueShipSpawnZone:blueShipSpawnZone redShipSpawnIntervalMin:redShipSpawnIntervalMin redShipSpawnIntervalMax:redShipSpawnIntervalMax];
}

- (id)initWithPlatforms:(NSArray *)platforms redShipSpawnZone:(CGRect)redShipSpawnZone blueShipSpawnZone:(CGRect)blueShipSpawnZone redShipSpawnIntervalMin:(float)redShipSpawnIntervalMin redShipSpawnIntervalMax:(float)redShipSpawnIntervalMax {
	
	self = [super init];
	
	if (self) {
		
		_platforms = platforms;
		_redShipSpawnZone = redShipSpawnZone;
		_redShipSpawnZoneOccupied = NO;
		_blueShipSpawnZone = blueShipSpawnZone;
		_redShipSpawnIntervalMin = redShipSpawnIntervalMin;
		_redShipSpawnIntervalMax = redShipSpawnIntervalMax;
	}
	
	return self;
}


@end
