//
//  LTSRandom.m
//  LastLander
//
//  Created by Aaron Cox on 2013-07-03.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSRandom.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation LTSRandom

+ (CGFloat)randomFloatFrom:(CGFloat)min to:(CGFloat)max {
	
	return min + (max - min) * (CGFloat)arc4random() / ARC4RANDOM_MAX;
}

+ (CGPoint)randomPointInRect:(CGRect)rect {
	
	CGPoint result;
	
	result.x = [self randomFloatFrom:rect.origin.x to:(rect.origin.x + rect.size.width)];
	result.y = [self randomFloatFrom:rect.origin.y to:(rect.origin.y + rect.size.height)];
	
	return result;
}

@end
