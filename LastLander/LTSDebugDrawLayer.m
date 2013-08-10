//
//  LTSDebugLayer.m
//  LastLander
//
//  Created by Aaron Cox on 2013-06-05.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSDebugDrawLayer.h"

@interface LTSDebugDrawLayer()

- (id)init;

@end

@implementation LTSDebugDrawLayer
{
	NSMutableArray *_polygons;
	NSMutableArray *_rectangles;
}


+ (LTSDebugDrawLayer *)getSharedInstance {
	
	static LTSDebugDrawLayer *instance = nil;
	
	@synchronized(self)
	{
		if (!instance) {
		
			instance = [[self alloc] init];
		}
	}
	
	return instance;
}

- (id)init {
	
	self = [super init];
	
	if (self) {
		
		_polygons = [NSMutableArray array];
		_rectangles = [NSMutableArray array];
	}
	
	return self;
}

- (void)drawPolygon:(NSArray *)polygon {
	
	[_polygons addObject:polygon];
}

- (void)drawRectangle:(CGRect)rectangle {
	
	[_rectangles addObject:[NSValue valueWithCGRect:rectangle]];
}

- (void)draw {
	
	// Polygons
	
	ccDrawColor4F(1.0f, 1.0f, 1.0f, 1.0f);
	
	for (NSArray *polygon in _polygons) {
		
		for (int startIdx = 0; startIdx < [polygon count]; startIdx++) {
		
			int endIdx = startIdx + 1;
			if (endIdx >= [polygon count]) {
				
				endIdx = 0;
			}
			
			ccDrawLine([[polygon objectAtIndex:startIdx] CGPointValue], [[polygon objectAtIndex:endIdx] CGPointValue]);
		}
	}
	
	[_polygons removeAllObjects];
	
	// Rectangles
	
	ccDrawColor4F(1.0f, 0.0f, 0.0f, 1.0f);
	
	for (int i = 0; i < [_rectangles count]; i++) {
		
		CGRect rectangle = [[_rectangles objectAtIndex:i] CGRectValue];
		
		CGPoint destination = ccp(rectangle.origin.x + rectangle.size.width, rectangle.origin.y + rectangle.size.height);

		ccDrawRect( rectangle.origin, destination );
	}
	
	for (NSArray *polygon in _polygons) {
		
		for (int startIdx = 0; startIdx < [polygon count]; startIdx++) {
			
			int endIdx = startIdx + 1;
			if (endIdx >= [polygon count]) {
				
				endIdx = 0;
			}
			
			ccDrawLine([[polygon objectAtIndex:startIdx] CGPointValue], [[polygon objectAtIndex:endIdx] CGPointValue]);
		}
	}
	
	[_rectangles removeAllObjects];
}

@end
