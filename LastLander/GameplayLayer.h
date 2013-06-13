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

#import "LTSCollisionComponent.h"

// HelloWorldLayer
@interface GameplayLayer : CCLayerColor
{
    NSMutableArray *_enemyShips;
    NSMutableArray *_projectiles;
    
	CCSpriteBatchNode *_spriteSheet1;
    CCSprite *_playerShip;
	
	LTSCollisionComponent *_collisionComponent1;
	LTSCollisionComponent *_collisionComponent2;
}

+(CCScene *) scene;

@end
