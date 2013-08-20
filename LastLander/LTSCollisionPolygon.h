//
//  LTSCollisionPolygon.h
//  LastLander
//
//  Created by Aaron Cox on 2013-08-09.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LTSCollisionPolygon : NSObject

- (void)addPoint:(CGPoint)point;

- (void)updateFromSprite:(CCSprite *)sprite;

- (BOOL)isIntersecting:(LTSCollisionPolygon *)other;

- (NSArray *)worldPolygonAsArray;

@end
