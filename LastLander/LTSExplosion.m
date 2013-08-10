//
//  LTSExplosion.m
//  LastLander
//
//  Created by Aaron Cox on 2013-08-04.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSExplosion.h"
#import "LTSConstants.h"

static const int STATE_AVAILABLE_FOR_USE = 0;
static const int STATE_ACTIVE = 1;

@interface LTSExplosion ()
{
	NSInteger _state;
}

- (id)initWithSprite:(CCSprite *)sprite explodingAction:(CCAction *)explodingAction;

- (void)changeState:(int)newState;
- (void)enterState:(int)state;
- (void)exitState:(int)state;

@end

@implementation LTSExplosion

+ (LTSExplosion *)createShipExplosionWithBatchNode:(CCSpriteBatchNode *)batchNode {
	
	NSMutableArray *explodingAnimationFrames = [NSMutableArray array];
	for (int i = 0; i < 16; i++) {
		
		NSMutableString* frameName = [NSMutableString stringWithFormat:@"ship_explode%d.png", i];
		[explodingAnimationFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
	}
	
	CCAnimation *explodingAnimation = [CCAnimation animationWithSpriteFrames:explodingAnimationFrames delay:0.1f];
	
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"ship_explode1.png"];
	sprite.position = ccp(OFF_SCREEN_X, OFF_SCREEN_Y);
	sprite.zOrder = Z_ORDER_SHIP_EXPLOSION;
	
	CCAction *explodingAction = [CCAnimate actionWithAnimation:explodingAnimation];
	[batchNode addChild:sprite];
	
	return [[self alloc] initWithSprite:sprite explodingAction:explodingAction];
}

- (void)update:(ccTime)dt {

	switch (_state) {
			
		case STATE_ACTIVE:
			
			if (self.explodingAction.isDone) {
				
				[self changeState:STATE_AVAILABLE_FOR_USE];
			}
			
			break;
	}
}

- (BOOL)isActive {
	
	return (_state == STATE_ACTIVE);
}

- (BOOL)isAvailableForUse {
	
	return (_state == STATE_AVAILABLE_FOR_USE);
}

- (void)spawnAtPosition:(CGPoint)position {
	
	self.sprite.position = position;
	[self changeState:STATE_ACTIVE];
}

- (id)initWithSprite:(CCSprite *)sprite explodingAction:(CCAction *)explodingAction {
	
	self = [super init];
	
	if (self) {
		
		_state = STATE_AVAILABLE_FOR_USE;
		
		_sprite = sprite;
		
		_explodingAction = explodingAction;
	}
	
	return self;
}

- (void)changeState:(int)newState {
	
	[self exitState:_state];
	
	_state = newState;
	
	[self enterState:newState];
}

- (void)enterState:(int)state {
	
	switch (_state) {
			
		case STATE_AVAILABLE_FOR_USE:
			
			[self.sprite stopAction:self.explodingAction];
			
			self.sprite.position = ccp(OFF_SCREEN_X, OFF_SCREEN_Y);
			
			break;
			
		case STATE_ACTIVE:
			
			[self.sprite runAction:self.explodingAction];
			
			break;
	}
}

- (void)exitState:(int)state {
	
}

@end