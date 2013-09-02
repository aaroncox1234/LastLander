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
#import "LTSCollisionPolygon.h"
#import "LTSCollisionSegment.h"

@class LTSGameWorld;

@interface LTSShip : NSObject

@property (nonatomic, readonly, strong) CCSprite *sprite;

@property (nonatomic, readonly, strong)	LTSCollisionPolygon *collisionPolygon;
@property (nonatomic, readonly, strong) LTSCollisionSegment *bottom;			// Bottom of the ship. Intersects with platforms during landing.

@property (nonatomic) CGPoint heading;	// using CGPoint as vector
@property (nonatomic) CGFloat speed;

@property (nonatomic) BOOL isHitOtherShip;
@property (nonatomic) BOOL isHitPlatform;
@property (nonatomic) BOOL isHitLandingZone;
@property (nonatomic, strong) LTSCollisionSegment *collidingLandingStrip;

@property (nonatomic) BOOL canLand;

@property (nonatomic, strong) LTSExplosion *explosion;

+ (LTSShip *)createBlueShipWithBatchNode:(CCSpriteBatchNode *)batchNode;
+ (LTSShip *)createRedShipWithBatchNode:(CCSpriteBatchNode *)batchNode;

- (void)update:(ccTime)dt gameWorld:(LTSGameWorld *)world;
- (void)prepareCollisionData;
- (void)respondToCollisions;

- (BOOL)isAvailableForUse;
- (BOOL)isReserved;
- (void)reserveAtSpawnPosition:(CGPoint)spawnPosition;
- (void)spawnWithSpeed:(GLfloat)speed;
- (void)spawnWithSpeed:(GLfloat)speed atSpawnPosition:(CGPoint)spawnPosition;
- (void)spawnWithSpeed:(GLfloat)speed atSpawnPosition:(CGPoint)spawnPosition withRotation:(GLfloat)degrees;

// TODO: remove these when the player input model changes
- (void)setLanded;
- (void)setFlying;
- (BOOL)isLanded;
- (BOOL)isCrashed;

- (void)rotate:(GLfloat)degrees;

@end
