//
//  LTSExplosion.h
//  LastLander
//
//  Created by Aaron Cox on 2013-08-04.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LTSExplosion : NSObject

@property (nonatomic) NSInteger state;

@property (nonatomic, readonly, strong) CCSprite *sprite;
@property (nonatomic, readonly, strong) CCAction *explodingAction;

+ (LTSExplosion *)createShipExplosionWithBatchNode:(CCSpriteBatchNode *)batchNode;

- (void)update:(ccTime)dt;

- (BOOL)isActive;
- (BOOL)isAvailableForUse;

- (void)spawnAtPosition:(CGPoint)position;

@end
