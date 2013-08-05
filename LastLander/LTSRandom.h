//
//  LTSRandom.h
//  LastLander
//
//  Created by Aaron Cox on 2013-07-03.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTSRandom : NSObject

+ (int)randomIntFrom:(int)min to:(int)max;

+ (CGFloat)randomFloatFrom:(CGFloat)min to:(CGFloat)max;

+ (CGPoint)randomPointInRect:(CGRect)rect;

@end
