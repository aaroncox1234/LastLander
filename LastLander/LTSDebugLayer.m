//
//  LTSDebugLayer.m
//  LastLander
//
//  Created by Aaron Cox on 2013-06-05.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSDebugLayer.h"

#import "LTSLine.h"

@interface LTSDebugLayer()

- (id)init;

@end

@implementation LTSDebugLayer
{
	NSMutableArray *_lineList;
}


+ (LTSDebugLayer *)getInstance {
	
	static LTSDebugLayer *instance = nil;
	
	@synchronized(self)
	{
		if (!instance) {
		
			instance = [[self alloc] init];
		}
	
		return instance;
	}
}

- (id)init {
	
	self = [super init];
	
	if (self) {
		
		_lineList = [NSMutableArray array];
	}
	
	return self;
}

- (void)pushLineFrom:(CGPoint)start to:(CGPoint)end {
	
	LTSLine *newLine = [LTSLine lineFrom:start to:end];
	
	[_lineList addObject:newLine];
}

- (void)draw {
	
	ccDrawColor4F(1.0f, 1.0f, 1.0f, 1.0f);
	
	for (LTSLine *line in _lineList) {
		
		ccDrawLine(line.p1, line.p2);
	}
	
	[_lineList removeAllObjects];
}

@end
