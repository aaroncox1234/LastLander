//
//  LTSGameLayer.h
//  LastLander
//
//  Created by Aaron Cox on 2013-08-04.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

#import "LTSGameWorld.h"

@interface LTSGameLayer : CCLayerColor

@property (nonatomic, readonly, strong) LTSGameWorld *gameWorld;

+(CCScene *) scene;

@end
