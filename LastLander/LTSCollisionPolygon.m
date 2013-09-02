//
//  LTSCollisionPolygon.m
//  LastLander
//
//  Created by Aaron Cox on 2013-08-09.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSCollisionPolygon.h"
#import "LTSDebugDefines.h"
#import "LTSCollisionDetection.h"

static const int MAX_POINTS = 50;

@interface LTSCollisionPolygon ()
{
	CGPoint _localPoints[MAX_POINTS];
	CGPoint _worldPoints[MAX_POINTS];
	int _numPoints;
}

@end

@implementation LTSCollisionPolygon

- (id)init {
	
	self = [super init];
	
	if (self) {
		
		_numPoints = 0;
	}
	
	return self;
}

- (void)addPoint:(CGPoint)point {
	
	_localPoints[_numPoints] = point;
	_numPoints++;
}

- (void)updateFromSprite:(CCSprite *)sprite {
	
	for (int i = 0; i < _numPoints; ++i) {
		
		_worldPoints[i] = [sprite convertToWorldSpaceAR:_localPoints[i]];
	}
}

- (BOOL)isIntersecting:(LTSCollisionPolygon *)other {
	
	for (int index = 0; index < _numPoints - 1; ++index) {
		
		CGPoint myStartPoint = _worldPoints[index];
		CGPoint myEndPoint = _worldPoints[index+1];
		
		for (int otherIndex = 0; otherIndex < other->_numPoints - 1; ++otherIndex) {
			
			CGPoint otherStartPoint = other->_worldPoints[otherIndex];
			CGPoint otherEndPoint = other->_worldPoints[otherIndex+1];
			
			if (testSegmentIntersection(myStartPoint, myEndPoint, otherStartPoint, otherEndPoint)) {
				
				return YES;
			}
		}
	}
	
	return NO;
}

- (NSArray *)worldPolygonAsArray {
	
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:_numPoints];
	
	for (int i = 0; i < _numPoints; ++i) {
		
		[array addObject:[NSValue valueWithCGPoint:_worldPoints[i]]];
	}
	
	return array;
}

@end
