//
//  LTSGameLayer.m
//  LastLander
//
//  Created by Aaron Cox on 2013-08-04.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSGameLayer.h"

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

#import "LTSDebugDrawLayer.h"
#import "LTSGameOverLayer.h"
#import "LTSConstants.h"

@interface LTSGameLayer ()
{
	CCSpriteBatchNode *_spriteSheet1;
}

@end

@implementation LTSGameLayer

+ (CCScene *)scene
{
	LTSGameLayer *layer = [LTSGameLayer node];

	CCScene *scene = [CCScene node];
	[scene addChild:layer];
	[scene addChild:[LTSDebugDrawLayer getSharedInstance]];

	return scene;
}

- (id)init {
	
	self = [super initWithColor:ccc4(255,255,255,255)];
	
    if (self) {
		
		_spriteSheet1 = [CCSpriteBatchNode batchNodeWithFile:@"LTSGameplaySpriteSheet1.png" capacity:24];
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"LTSGameplaySpriteSheet1.plist"];
		[self addChild:_spriteSheet1];

        _gameWorld = [[LTSGameWorld alloc] initWithBatchNode:_spriteSheet1];
		
		[self schedule:@selector(update:)];
		
		self.touchEnabled = YES;
		
		[[CCDirector sharedDirector].view setMultipleTouchEnabled:YES];
    }
	
	return self;
}

- (void)update:(ccTime)dt {
	
	[self.gameWorld update:dt];
	
	if (self.gameWorld.isFailed) {
		
		[self runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:2],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
             [[CCDirector sharedDirector] replaceScene:[LTSGameOverLayer scene]];
         }],
          nil]];
	}
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	for (UITouch* touch in touches) {
		
		CGPoint location = [self convertTouchToNodeSpace:touch];
		[self.gameWorld onScreenTouchStart:location touchHash:[touch hash]];
		
		CCLOG(@"Touch detected at (%f, %f)", location.x, location.y);
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
	for (UITouch* touch in touches) {
		
		CGPoint location = [self convertTouchToNodeSpace:touch];
		[self.gameWorld onScreenTouchEnd:location touchHash:[touch hash]];
	}
}

#pragma mark GameKit delegate

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
