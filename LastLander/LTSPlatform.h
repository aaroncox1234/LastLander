//
//  LTSPlatform.h
//  LastLander
//
//  Created by Aaron Cox on 2013-06-23.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "LTSCollisionPolygon.h"

@interface LTSPlatform : NSObject

@property (nonatomic, readonly, strong) CCSprite *sprite;

@property (nonatomic, readonly, strong)	LTSCollisionPolygon *collisionPolygon;

@property (nonatomic, readonly) CGRect landingZone;

+ (LTSPlatform *)createPlatform1WithBatchNode:(CCSpriteBatchNode *)batchNode position:(CGPoint)position;
+ (LTSPlatform *)createPlatform2WithBatchNode:(CCSpriteBatchNode *)batchNode position:(CGPoint)position;
+ (LTSPlatform *)createPlatform3WithBatchNode:(CCSpriteBatchNode *)batchNode position:(CGPoint)position;

@end

