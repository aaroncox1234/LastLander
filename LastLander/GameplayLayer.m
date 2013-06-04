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

#import "GameOverLayer.h"

#pragma mark - GameplayLayer

// HelloWorldLayer implementation
@implementation GameplayLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameplayLayer *layer = [GameplayLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) addEnemyShip {
    
    CCSprite *enemyShip = [CCSprite spriteWithFile:@"ship_R_01.png"];
    enemyShip.flipX = false;
    
    enemyShip.tag = 1;
    [_enemyShips addObject:enemyShip];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = enemyShip.contentSize.height/2;
    int maxY = winSize.height - enemyShip.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    enemyShip.position = ccp(winSize.width + enemyShip.contentSize.width/2, actualY);
    [self addChild:enemyShip];
    
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
}

// on "init" you need to initialize your instance
-(id) init
{
    // TODO: Handle failure intelligently.
    if ((self = [super initWithColor:ccc4(255,255,255,255)])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *background = [CCSprite spriteWithFile:@"LTS_bg_03.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        
        [self addChild:background];
        
        _playerShip = [CCSprite spriteWithFile:@"ship_B_01.png"];
        _playerShip.position = ccp(-_playerShip.contentSize.width/2, winSize.height/2);
        [self addChild:_playerShip];
    }
    
    [self schedule:@selector(gameLogic:) interval:2.0];
    
    [self schedule:@selector(update:)];
    
    self.touchEnabled = YES;
    
    _enemyShips = [[NSMutableArray alloc] init];
    
    //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
    
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    
    [_enemyShips release];
    _enemyShips = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
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
