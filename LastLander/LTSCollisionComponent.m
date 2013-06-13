//
//  LTSCollisionComponent.m
//  LastLander
//
//  Created by Aaron Cox on 2013-06-09.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSCollisionComponent.h"

@implementation LTSCollisionComponent

- (id)initWithPolygon:(NSArray *)polygon {
	
	self = [super init];
	
	if (self) {
		
		_polygon = polygon;
	}
	
	return self;
}

@end
