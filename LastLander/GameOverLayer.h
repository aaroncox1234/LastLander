//
//  GameOverLayer.h
//  LastLander
//
//  Created by Aaron Cox on 2013-05-05.
//  Copyright 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor {
}

+(CCScene *) sceneWithWon:(BOOL)won;

@end
