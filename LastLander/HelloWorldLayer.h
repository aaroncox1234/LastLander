//
//  HelloWorldLayer.h
//  LastLander
//
//  Created by Aaron Cox on 2013-05-04.
//  Copyright Aaron Cox 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
    NSMutableArray *_enemyShips;
    NSMutableArray *_projectiles;
    
    CCSprite *_playerShip;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
