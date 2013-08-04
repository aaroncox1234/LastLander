//
//  LTSSpawnWarning.m
//  LastLander
//
//  Created by Aaron Cox on 2013-08-01.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSSpawnWarningBlip.h"
#import "LTSConstants.h"

static const int STATE_AVAILABLE_FOR_USE = 0;
static const int STATE_ACTIVE = 1;
static const int STATE_FINISHED_COUNTDOWN = 2;

@interface LTSSpawnWarningBlip ()
{
	CGFloat _timeRemaining;
}

- (id)initWithSprite:(CCSprite *)sprite blinkingAction:(CCAction *)blinkingAction;

- (void)changeState:(int)newState;
- (void)enterState:(int)state;
- (void)exitState:(int)state;

@end

@implementation LTSSpawnWarningBlip

+ (LTSShip *)createRedShipSpawnWarningBlip:(CCSpriteBatchNode *)batchNode {
	
	NSMutableArray *blinkingAnimationFrames = [NSMutableArray array];
	[blinkingAnimationFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spawn_R_frame1"]];
    [blinkingAnimationFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spawn_R_frame2"]];
	
	CCAnimation *blinkingAnimation = [CCAnimation animationWithSpriteFrames:blinkingAnimationFrames delay:0.1f];
	
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"spawn_R_frame1.png"];
	sprite.position = ccp(OFF_SCREEN_X, OFF_SCREEN_Y);
	
	CCAction *blinkingAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:blinkingAnimation]];
	[batchNode addChild:sprite];
	
	return [[self alloc] initWithSprite:sprite blinkingAction:blinkingAction];
}

- (void)update:(ccTime)dt
{
	switch (self.state) {
			
		case STATE_ACTIVE:
			
			_timeRemaining -= dt;
			if (_timeRemaining <= 0.0f) {
				
				[self changeState:STATE_FINISHED_COUNTDOWN];
			}
			
			break;
	}
}
	 
- (id)initWithSprite:(CCSprite *)sprite blinkingAction:(CCAction *)blinkingAction {
		 
	self = [super init];
		 
	if (self) {
			 
		_state = STATE_AVAILABLE_FOR_USE;
			 
		_sprite = sprite;
			 
		_blinkingAction = blinkingAction;
			 
		_timeRemaining = SPAWN_WARNING_BLIP_DURATION;
	}
		 
	return self;
}

- (BOOL)isAvailableForUse {
	
	return (self.state == STATE_AVAILABLE_FOR_USE);
}

- (BOOL)isCountdownFinished {
	
	return (self.state == STATE_FINISHED_COUNTDOWN);
}

- (void)spawnAtPosition:(CGPoint)position forShip:(LTSShip *)ship {

	self.sprite.position = position;
	self.correspondingRedShip = ship;
	[self changeState:STATE_ACTIVE];
}

- (void)setAvailableForUse {
	
	[self changeState:STATE_AVAILABLE_FOR_USE];
}

- (void)changeState:(int)newState {
	
	[self exitState:self.state];
	
	self.state = newState;
	
	[self enterState:newState];
}

- (void)enterState:(int)state {
	
	switch (state) {
		
		case STATE_AVAILABLE_FOR_USE:
			
			[self.sprite stopAction:self.blinkingAction];
			
			self.sprite.position = ccp(OFF_SCREEN_X, OFF_SCREEN_Y);
			
			break;
			
		case STATE_ACTIVE:
			
			[self.sprite runAction:self.blinkingAction];
			
			_timeRemaining = SPAWN_WARNING_BLIP_DURATION;
			
			break;
	}
}

- (void)exitState:(int)state {
	
}
	 
@end
