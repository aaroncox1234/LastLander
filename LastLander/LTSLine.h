//
//  LTSLine.h
//  LastLander
//
//  Created by Aaron Cox on 2013-06-05.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTSLine : NSObject

@property (nonatomic, assign) CGPoint p1;
@property (nonatomic, assign) CGPoint p2;

+ (id)lineFrom:(CGPoint)start to:(CGPoint)end;

@end
