//
//  LTSCollisionLine.m
//  LastLander
//
//  Created by Aaron Cox on 2013-08-19.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSCollisionSegment.h"
#import "LTSCollisionDetection.h"

@interface LTSCollisionSegment ()

- (id)initWithStart:(CGPoint)start end:(CGPoint)end;

@end

@implementation LTSCollisionSegment

- (id)initWithStart:(CGPoint)start end:(CGPoint)end {
	
	self = [super init];
	
	if (self) {
		
		_localStart = start;
		_localEnd = end;
	}
	
	return self;
}

- (void)updateFromSprite:(CCSprite *)sprite {

	_worldStart = [sprite convertToWorldSpaceAR:_localStart];
	_worldEnd = [sprite convertToWorldSpaceAR:_localEnd];
}

- (BOOL)isIntersecting:(LTSCollisionSegment *)other {
	
	return testSegmentIntersection(self.worldStart, self.worldEnd, other.worldStart, other.worldEnd);
}

+ (LTSCollisionSegment *)createSegmentFrom:(CGPoint)start to:(CGPoint)end {
	
	return [[self alloc] initWithStart:start end:end];
}


@end
