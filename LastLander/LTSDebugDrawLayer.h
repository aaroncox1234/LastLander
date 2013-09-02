//
//  LTSDebugDrawLayer.h
//  LastLander
//
//  Created by Aaron Cox on 2013-06-05.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "CCLayer.h"

#import "cocos2d.h"

// Layer used for drawing debug information. A static instance is available for easy access through getSharedInstance.

@interface LTSDebugDrawLayer : CCLayer

+ (LTSDebugDrawLayer *)getSharedInstance;

- (void)drawPolygon:(NSArray *)polygon;
- (void)drawRectangle:(CGRect)rectangle;
- (void)drawLineFrom:(CGPoint)start to:(CGPoint)end;

@end
