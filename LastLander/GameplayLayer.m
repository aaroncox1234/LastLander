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
		
		/*NSArray *playerShipCollisionPolygon = [NSArray arrayWithObjects:
											   [NSValue valueWithCGPoint:CGPointMake(14.1f, 6.7f)],
											   [NSValue valueWithCGPoint:CGPointMake(-14.2f, 6.6f)],
											   [NSValue valueWithCGPoint:CGPointMake(-14.3f, -1.6f)],
											   [NSValue valueWithCGPoint:CGPointMake(-7.6f, -6.8f)],
											   [NSValue valueWithCGPoint:CGPointMake(14.4f, -6.8f)],
											   nil];*/
		
		_testPolygon1 = [NSArray arrayWithObjects:
								  [NSValue valueWithCGPoint:CGPointMake(71.4f, 88.1f)],
								  [NSValue valueWithCGPoint:CGPointMake(103.7f, 110.3f)],
								  [NSValue valueWithCGPoint:CGPointMake(75.6f, 137.1f)],
								  [NSValue valueWithCGPoint:CGPointMake(50.7f, 122.6f)],
								  [NSValue valueWithCGPoint:CGPointMake(48.3f, 95.5f)],
								  nil];
		
//		_testPolygon2 = [[LTSCollisionComponent alloc] initWithPolygon:debugPolygon1];
		
		_testPolygon2 = [NSArray arrayWithObjects:
								  [NSValue valueWithCGPoint:CGPointMake(169.1f, 72.8f)],
								  [NSValue valueWithCGPoint:CGPointMake(195.5f, 70.7f)],
								  [NSValue valueWithCGPoint:CGPointMake(222.6f, 106.3f)],
								  [NSValue valueWithCGPoint:CGPointMake(204.5f, 141.0f)],
								  [NSValue valueWithCGPoint:CGPointMake(178.5f, 140.0f)],
								  [NSValue valueWithCGPoint:CGPointMake(160.5f, 122.6f)],
								  [NSValue valueWithCGPoint:CGPointMake(155.7f, 103.9f)],
								  [NSValue valueWithCGPoint:CGPointMake(155.0f, 77.8f)],
								  nil];
		
//		_collisionComponent2 = [[LTSCollisionComponent alloc] initWithPolygon:debugPolygon2];
    
		//[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
    }
	
	return self;
}

- (void) addEnemyShip {

    /*CCSprite *enemyShip = [CCSprite spriteWithSpriteFrameName:@"ship_R_01.png"];
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
    [enemyShip runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];*/
    
}

-(void) gameLogic:(ccTime)dt {
    [self addEnemyShip];
}

-(void)update:(ccTime)dt {
    
    float playerSpeed = 0.0f;
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
	
	/*NSMutableArray *worldPolygon = [NSMutableArray arrayWithCapacity:[_collisionComponent1.polygon count]];
		
	for (NSValue *localPoint in _collisionComponent1.polygon) {
		
		CGPoint worldPoint = [_playerShip convertToWorldSpaceAR:[localPoint CGPointValue]];
		
		[worldPolygon addObject:[NSValue valueWithCGPoint:worldPoint]];
	}*/
	
	// TODO: start with AABB test of sprites
	
	BOOL collisionDetected = NO;
	
	int polygon1Count = [_testPolygon1 count];
	int polygon2Count = [_testPolygon2 count];
	
	for (int poly1StartIdx = 0; poly1StartIdx < polygon1Count; poly1StartIdx++) {
		
		int poly1EndIdx = poly1StartIdx + 1;
		if (poly1EndIdx >= polygon1Count) {
			
			poly1EndIdx = 0;
		}
		
		CGPoint poly1StartPoint = [[_testPolygon1 objectAtIndex:poly1StartIdx] CGPointValue];
		CGPoint poly1EndPoint = [[_testPolygon1 objectAtIndex:poly1EndIdx] CGPointValue];
		
		for (int poly2StartIdx = 0; poly2StartIdx < polygon2Count; poly2StartIdx++) {
			
			int poly2EndIdx = poly2StartIdx + 1;
			if (poly2EndIdx >= polygon2Count) {
				
				poly2EndIdx = 0;
			}
			
			CGPoint poly2StartPoint = [[_testPolygon2 objectAtIndex:poly2StartIdx] CGPointValue];
			CGPoint poly2EndPoint = [[_testPolygon2 objectAtIndex:poly2EndIdx] CGPointValue];
			
			if (ccpSegmentIntersect(poly1StartPoint, poly1EndPoint, poly2StartPoint, poly2EndPoint)) {
				
				collisionDetected = YES;
				
				// TODO return out, no need to keep the bool around
			}
		}
	}
	
	if (collisionDetected) {
		
		NSLog(@"COLLISION");
	}
	else {
		
		NSLog(@"NOTHING");
		
	}
	[[LTSDebugDrawLayer getSharedInstance] drawPolygon:_testPolygon1];
	[[LTSDebugDrawLayer getSharedInstance] drawPolygon:_testPolygon2];
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
    
	NSMutableArray *newPolygon = [NSMutableArray array];
	
	for (NSValue *pointAsValue in _testPolygon1) {
		
		CGPoint point = [pointAsValue CGPointValue];
		
		if (location.x > winSize.width * 0.75)
		{
			point.x += 10.0f;
		}
		if (location.x < winSize.width * 0.25)
		{
			point.x -= 10.0f;
		}

		if (location.y > winSize.height * 0.75)
		{
			point.y += 10.0f;
		}
		if (location.y < winSize.height * 0.25)
		{
			point.y -= 10.0f;
		}
		
		[newPolygon addObject:[NSValue valueWithCGPoint:point]];
	}
	
	_testPolygon1 = newPolygon;
	
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
