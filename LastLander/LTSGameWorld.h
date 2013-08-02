//
//  LTSGameWorld.h
//  LastLander
//
//	Storage and central processing for all game entities.
//
//  Created by Aaron Cox on 2013-06-17.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LTSLevel.h"
#import "LTSShip.h"
#import "LTSSpawnWarningBlip.h"

@interface LTSGameWorld : NSObject

@property (nonatomic, readonly, strong) NSArray *blueShips;
@property (nonatomic, readonly, strong) NSArray *redShips;

@property (nonatomic, readonly, strong) NSArray *redShipWarningBlips;

@property (nonatomic, readonly, strong) LTSLevel *level;

- (id)initWithBatchNode:(CCSpriteBatchNode *)batchNode;

- (void)update:(ccTime)dt;

@end