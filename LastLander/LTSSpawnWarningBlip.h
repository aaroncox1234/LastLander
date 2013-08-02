//
//  LTSSpawnWarning.h
//  LastLander
//
//  Created by Aaron Cox on 2013-08-01.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "LTSShip.h"

@interface LTSSpawnWarningBlip : NSObject

@property (nonatomic) NSInteger state;

@property (nonatomic, readonly, strong) CCSprite *sprite;
@property (nonatomic, readonly, strong) CCAction *blinkingAction;
@property (nonatomic, strong) LTSShip *correspondingRedShip;

+ (LTSShip *)createRedShipSpawnWarningBlip:(CCSpriteBatchNode *)batchNode;

- (void)update:(ccTime)dt;

- (BOOL)isAvailableForUse;
- (BOOL)isCountdownFinished;

- (void)spawnAtPosition:(CGPoint)position forShip:(LTSShip *)ship;
- (void)setAvailableForUse;

@end