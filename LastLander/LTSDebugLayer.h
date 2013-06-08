//
//  LTSDebugLayer.h
//  LastLander
//  Singleton class used for drawing debug lines.
//
//  Created by Aaron Cox on 2013-06-05.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "CCLayer.h"

#import "cocos2d.h"

@interface LTSDebugLayer : CCLayer

+ (LTSDebugLayer *)getInstance;

- (void)pushLineFrom:(CGPoint)start to:(CGPoint)end;

@end
