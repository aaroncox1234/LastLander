//
//  LTSPlayerShip.m
//  LastLander
//
//  Created by Aaron Cox on 2013-06-17.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSShip.h"
#import "LTSConstants.h"
#import "LTSSpawnWarningBlip.h"

static const int STATE_AVAILABLE_FOR_USE = 0;
static const int STATE_RESERVED = 1;
static const int STATE_FLYING = 2;
static const int STATE_DYING = 3;

@interface LTSShip ()

- (id)initWithSprite:(CCSprite *)sprite polygon:(NSArray *)polygon;

- (void)changeState:(int)newState;
- (void)enterState:(int)state;
- (void)exitState:(int)state;

@end

@implementation LTSShip

+ (LTSShip *)createBlueShipWithBatchNode:(CCSpriteBatchNode *)batchNode {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"ship_B_01.png"];
	sprite.position = ccp(OFF_SCREEN_X, OFF_SCREEN_Y);
	[batchNode addChild:sprite];
	
	NSArray *polygon = [NSArray arrayWithObjects:
						[NSValue valueWithCGPoint:CGPointMake(14.1f, 6.7f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.2f, 6.6f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.3f, -1.6f)],
						[NSValue valueWithCGPoint:CGPointMake(-7.6f, -6.8f)],
						[NSValue valueWithCGPoint:CGPointMake(14.4f, -6.8f)],
						[NSValue valueWithCGPoint:CGPointMake(14.1f, 6.7f)],
						 nil];
	
	return [[self alloc] initWithSprite:sprite polygon:polygon];
}

+ (LTSShip *)createRedShipWithBatchNode:(CCSpriteBatchNode *)batchNode {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"ship_R_01.png"];
	sprite.position = ccp(OFF_SCREEN_X, OFF_SCREEN_Y);
	[batchNode addChild:sprite];
	
	NSArray *polygon = [NSArray arrayWithObjects:
						[NSValue valueWithCGPoint:CGPointMake(7.1f, -6.7f)],
						[NSValue valueWithCGPoint:CGPointMake(14.3f, -1.5f)],
						[NSValue valueWithCGPoint:CGPointMake(14.0f, 6.8f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.5f, 6.7f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.4f, -6.6f)],
						[NSValue valueWithCGPoint:CGPointMake(7.1f, -6.7f)],
						nil];
	
	return [[self alloc] initWithSprite:sprite polygon:polygon];
}

- (id)initWithSprite:(CCSprite *)sprite polygon:(NSArray *)polygon {
	
	self = [super init];
	
	if (self) {
	
		_state = STATE_AVAILABLE_FOR_USE;
		
		_sprite = sprite;
		
		_localPolygon = polygon;
		_worldPolygon = [polygon copy];
		
		_isHitOtherShip = NO;
		_isHitPlatform = NO;
	}
	
	return self;
}

- (void)prepareCollisionData {
	
	for (int i = 0; i < [self.localPolygon count]; i++) {
		
		CGPoint localPoint = [[self.localPolygon objectAtIndex:i] CGPointValue];
		
		CGPoint worldPoint = [self.sprite convertToNodeSpaceAR:localPoint];
		
		[self.worldPolygon replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:worldPoint]];
	}
}

- (void)update {
	
}

- (void)respondToCollisions {
	
	if (self.isHitOtherShip || self.isHitPlatform) {
		
		[self enterState:STATE_DYING];
	}
}

- (void)changeState:(int)newState {
	
	[self exitState:self.state];
	
	self.state = newState;
	
	[self enterState:newState];
}

- (void)enterState:(int)state {
	
}

- (void)exitState:(int)state {
	
}


- (BOOL)isAvailableForUse {
	
	return (self.state == STATE_AVAILABLE_FOR_USE);
}

- (BOOL)isReserved {
	
	return (self.state == STATE_RESERVED);
}

- (void)reserveAtSpawnPosition:(CGPoint)spawnPosition {

	self.sprite.position = spawnPosition;
	
	[self changeState:STATE_RESERVED];
}

- (void)spawn {
	
	[self changeState:STATE_FLYING];
}

@end
