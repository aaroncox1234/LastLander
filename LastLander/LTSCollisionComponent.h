//
//  LTSCollisionComponent.h
//  LastLander
//
//  Created by Aaron Cox on 2013-06-09.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTSCollisionComponent : NSObject

@property (nonatomic, readonly, strong) NSArray *polygon;

- (id)initWithPolygon:(NSArray *)polygon;

@end
