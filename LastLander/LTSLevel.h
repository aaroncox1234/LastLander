//
//  LTSLevel.h
//  LastLander
//
//  Created by Aaron Cox on 2013-06-23.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LTSLevel : NSObject

@property (nonatomic, readonly, strong) NSArray *platforms;

@property (nonatomic, readonly) CGRect redShipSpawnZone;
@property (nonatomic) bool redShipSpawnZoneOccupied;

@property (nonatomic, readonly) CGRect blueShipSpawnZone;

@property (nonatomic, readonly) float redShipSpawnIntervalMin;
@property (nonatomic, readonly) float redShipSpawnIntervalMax;

+ (LTSLevel *)createLevel1WithBatchNode:(CCSpriteBatchNode *)batchNode;

@end
