//
//  HelloWorldLayer.m
//  LastLander
//
//  Created by Aaron Cox on 2013-05-04.
//  Copyright Aaron Cox 2013. All rights reserved.
//


// Import the interfaces
#import "GameplayLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "SimpleAudioEngine.h"

#import "LTSDebugDrawLayer.h"
#import "GameOverLayer.h"

#pragma mark - GameplayLayer

@implementation GameplayLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	GameplayLayer *layer = [GameplayLayer node];
	
	[scene addChild: layer];
	[scene addChild: [LTSDebugDrawLayer getSharedInstance]];
	
	// return the scene
	return scene;
}

- (id)init {
	
	self = [super initWithColor:ccc4(255,255,255,255)];
	
    if (self) {
		
        CGSize winSize = [CCDirector sharedDirector].winSize;
		
		_spriteSheet1 = [CCSpriteBatchNode batchNodeWithFile:@"LTSGameplaySpriteSheet1.png" capacity:2];
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"LTSGameplaySpriteSheet1.plist"];
		[self addChild:_spriteSheet1];
		
		CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"LTS_bg_03.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [_spriteSheet1 addChild:background];
		
		_playerShip = [CCSprite spriteWithSpriteFrameName:@"ship_B_01.png"];
        _playerShip.position = ccp(-_playerShip.contentSize.width/2, winSize.height/2);
        [_spriteSheet1 addChild:_playerShip];
    
		[self schedule:@selector(gameLogic:) interval:2.0];
    
		[self schedule:@selector(update:)];
    
		self.touchEnabled = YES;
		
		_enemyShips = [[NSMutableArray alloc] init];
		
		NSArray *playerShipCollisionPolygon = [NSArray arrayWithObjects:
											   [NSValue valueWithCGPoint:CGPointMake(14.1f, 6.7f)],
											   [NSValue valueWithCGPoint:CGPointMake(-14.2f, 6.6f)],
											   [NSValue valueWithCGPoint:CGPointMake(-14.3f, -1.6f)],
											   [NSValue valueWithCGPoint:CGPointMake(-7.6f, -6.8f)],
											   [NSValue valueWithCGPoint:CGPointMake(14.4f, -6.8f)],
											   nil];
		
		_collisionComponent1 = [[LTSCollisionComponent alloc] initWithPolygon:playerShipCollisionPolygon];
    
		//[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
    }
	
	return self;
}

- (void) addEnemyShip {

    CCSprite *enemyShip = [CCSprite spriteWithSpriteFrameName:@"ship_R_01.png"];
    enemyShip.flipX = false;
    
    enemyShip.tag = 1;
    [_enemyShips addObject:enemyShip];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = enemyShip.contentSize.height/2;
    int maxY = winSize.height - enemyShip.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    enemyShip.position = ccp(winSize.width + enemyShip.contentSize.width/2, actualY);
    [_spriteSheet1 addChild:enemyShip];
    
    int minDuration = 5.0;
    int maxDuration = 10.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    CCMoveTo *actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(-enemyShip.contentSize.width/2, actualY)];
    CCCallBlockN *actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [_enemyShips addObject:enemyShip];
        [node removeFromParentAndCleanup:YES];
    }];
    [enemyShip runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    
}

-(void) gameLogic:(ccTime)dt {
    [self addEnemyShip];
}

-(void)update:(ccTime)dt {
    
    float playerSpeed = 75.0f;
    float playerAngle = _playerShip.rotation * M_PI / 180.0f;
    float vx = cos(playerAngle) * playerSpeed * dt;
    float vy = -sin(playerAngle) * playerSpeed * dt;
    CGPoint velocity = ccp(vx, vy);
    _playerShip.position = ccpAdd(_playerShip.position, velocity);
	
    for (CCSprite *enemyShip in _enemyShips) {
        if (CGRectIntersectsRect(_playerShip.boundingBox, enemyShip.boundingBox)) {
            CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
            [[CCDirector sharedDirector] replaceScene:gameOverScene];
        }
    }
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    if (_playerShip.position.x >= winSize.width + (_playerShip.contentSize.width / 2)) {
        CCScene *gameOverScene = [GameOverLayer sceneWithWon:YES];
        [[CCDirector sharedDirector] replaceScene:gameOverScene];
    }
	
	NSMutableArray *worldPolygon = [NSMutableArray arrayWithCapacity:[_collisionComponent1.polygon count]];
		
	for (NSValue *localPoint in _collisionComponent1.polygon) {
		
		CGPoint worldPoint = [_playerShip convertToWorldSpaceAR:[localPoint CGPointValue]];
		
		[worldPolygon addObject:[NSValue valueWithCGPoint:worldPoint]];
	}
	
	[[LTSDebugDrawLayer getSharedInstance] drawPolygon:worldPolygon];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    
    _enemyShips = nil;
	
	// don't forget to call "super dealloc"
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    const float angle = 15.0f;
    if (location.x > winSize.width * 0.75) {
        _playerShip.rotation += angle;
    }
    else if (location.x < winSize.width * 0.25) {
        _playerShip.rotation -= angle;
    }
    
    //[[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
