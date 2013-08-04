//
//  LTSPlayerShip.h
//  LastLander
//
//  Created by Aaron Cox on 2013-06-17.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "LTSExplosion.h"

@interface LTSShip : NSObject

@property (nonatomic) NSInteger state;

@property (nonatomic, readonly, strong) CCSprite *sprite;

@property (nonatomic) CGPoint position;

@property (nonatomic, readonly, strong)	NSArray *localPolygon;
@property (nonatomic, readonly, strong) NSMutableArray *worldPolygon;

@property (nonatomic) CGFloat velocityX;
@property (nonatomic) CGFloat velocityY;

@property (nonatomic) BOOL isHitOtherShip;
@property (nonatomic) BOOL isHitPlatform;

@property (nonatomic, strong) LTSExplosion *explosion;

+ (LTSShip *)createBlueShipWithBatchNode:(CCSpriteBatchNode *)batchNode;
+ (LTSShip *)createRedShipWithBatchNode:(CCSpriteBatchNode *)batchNode;

- (void)update:(ccTime)dt;
- (void)prepareCollisionData;
- (void)respondToCollisions;

- (BOOL)isAvailableForUse;
- (BOOL)isReserved;
- (void)reserveAtSpawnPosition:(CGPoint)spawnPosition;
- (void)spawn:(GLfloat)speed;

@end
