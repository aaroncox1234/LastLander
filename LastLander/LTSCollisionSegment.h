//
//  LTSCollisionLine.h
//  LastLander
//
//  Created by Aaron Cox on 2013-08-19.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LTSCollisionSegment : NSObject

@property (nonatomic) CGPoint localStart;
@property (nonatomic) CGPoint localEnd;

@property (nonatomic) CGPoint worldStart;
@property (nonatomic) CGPoint worldEnd;

+ (LTSCollisionSegment *)createSegmentFrom:(CGPoint)start to:(CGPoint)end;

- (void)updateFromSprite:(CCSprite *)sprite;

- (BOOL)isIntersecting:(LTSCollisionSegment *)other;

@end
