//
//  LTSLine.m
//  LastLander
//
//  Created by Aaron Cox on 2013-06-05.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSLine.h"

@interface LTSLine ()
	
- (id)initFrom:(CGPoint)start to:(CGPoint)end;

@end

@implementation LTSLine

- (id)initFrom:(CGPoint)start to:(CGPoint)end {

	self = [super init];
	
	if (self) {
		
		_p1 = start;
		_p2 = end;
	}
	
	return self;
}

+ (id)lineFrom:(CGPoint)start to:(CGPoint)end {
	
	return [[self alloc] initFrom:start to:end];
}

@end
