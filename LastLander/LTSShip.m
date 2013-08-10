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
static const int STATE_LANDED = 4;

@interface LTSShip ()
{
	NSInteger _state;
	CGFloat _spawnDirection;
}

- (id)initWithSprite:(CCSprite *)sprite polygon:(NSArray *)polygon spawnDirection:(CGFloat)spawnDirection;

- (void)changeState:(int)newState;
- (void)enterState:(int)state;
- (void)exitState:(int)state;

@end

@implementation LTSShip

+ (LTSShip *)createBlueShipWithBatchNode:(CCSpriteBatchNode *)batchNode {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"ship_B_01.png"];
	sprite.position = ccp(OFF_SCREEN_X, OFF_SCREEN_Y);
	sprite.zOrder = Z_ORDER_BLUE_SHIP;
	[batchNode addChild:sprite];
	
	NSArray *polygon = [NSArray arrayWithObjects:
						[NSValue valueWithCGPoint:CGPointMake(14.1f, 6.7f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.2f, 6.6f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.3f, -1.6f)],
						[NSValue valueWithCGPoint:CGPointMake(-7.6f, -6.8f)],
						[NSValue valueWithCGPoint:CGPointMake(14.4f, -6.8f)],
						[NSValue valueWithCGPoint:CGPointMake(14.1f, 6.7f)],
						nil];
	
	return [[self alloc] initWithSprite:sprite polygon:polygon spawnDirection:1.0f];
}

+ (LTSShip *)createRedShipWithBatchNode:(CCSpriteBatchNode *)batchNode {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"ship_R_01.png"];
	sprite.position = ccp(OFF_SCREEN_X, OFF_SCREEN_Y);
	sprite.zOrder = Z_ORDER_RED_SHIP;
	[batchNode addChild:sprite];
	
	NSArray *polygon = [NSArray arrayWithObjects:
						[NSValue valueWithCGPoint:CGPointMake(7.1f, -6.7f)],
						[NSValue valueWithCGPoint:CGPointMake(14.3f, -1.5f)],
						[NSValue valueWithCGPoint:CGPointMake(14.0f, 6.8f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.5f, 6.7f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.4f, -6.6f)],
						[NSValue valueWithCGPoint:CGPointMake(7.1f, -6.7f)],
						nil];
	
	return [[self alloc] initWithSprite:sprite polygon:polygon spawnDirection:-1.0f];
}

- (id)initWithSprite:(CCSprite *)sprite polygon:(NSArray *)polygon spawnDirection:(CGFloat)spawnDirection {
	
	self = [super init];
	
	if (self) {
	
		_state = STATE_AVAILABLE_FOR_USE;
		
		_sprite = sprite;
		
		_localPolygon = polygon;
		_worldPolygon = [NSMutableArray arrayWithArray:polygon];
		
		_isHitOtherShip = NO;
		_isHitPlatform = NO;
		_isHitLandingZone = NO;
		
		_canLand = NO;
		
		_spawnDirection = spawnDirection;
	}
	
	return self;
}

- (void)prepareCollisionData {
	
	for (int i = 0; i < [self.localPolygon count]; i++) {
		
		CGPoint localPoint = [[self.localPolygon objectAtIndex:i] CGPointValue];
		
		CGPoint worldPoint = [self.sprite convertToWorldSpaceAR:localPoint];
		
		[self.worldPolygon replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:worldPoint]];
	}
}

- (void)update:(ccTime)dt {
	
	switch (_state) {
			
		case STATE_FLYING:
			
			self.sprite.position = ccpAdd( self.sprite.position, ccpMult(self.heading, self.speed * dt) );
			
			break;
			
		case STATE_DYING:
			
			if (![self.explosion isActive]) {
				
				[self changeState:STATE_AVAILABLE_FOR_USE];
			}
			
			break;
	}
}

- (void)respondToCollisions {
	
	switch (_state) {
			
		case STATE_FLYING:
		{
			float rotation = -CC_RADIANS_TO_DEGREES( ccpToAngle(self.heading) );

			if (self.canLand && self.isHitLandingZone && self.isHitPlatform && (rotation >= LANDING_ANGLE_MIN) && (rotation <= LANDING_ANGLE_MAX)) {

				self.speed = 0.0f;
				self.heading = ccp(1.0f, 0.0f);
				self.sprite.rotation = 0.0f;
				self.sprite.position = ccp(self.sprite.position.x, self.sprite.position.y - 2.0f); // HACK
					
				[self changeState:STATE_LANDED];
			}
			else if (self.isHitOtherShip || self.isHitPlatform) {
				
				[self changeState:STATE_DYING];
			}
		}break;
	}
}

- (void)changeState:(int)newState {
	
	[self exitState:_state];
	
	_state = newState;
	
	[self enterState:newState];
}

- (void)enterState:(int)state {

	switch (_state) {
			
		case STATE_DYING:
			
			[self.explosion spawnAtPosition:self.sprite.position];
			 
			self.sprite.position = ccp(OFF_SCREEN_X, OFF_SCREEN_Y);
			
			break;
	}
}

- (void)exitState:(int)state {
	
}


- (BOOL)isAvailableForUse {
	
	return (_state == STATE_AVAILABLE_FOR_USE);
}

- (BOOL)isReserved {
	
	return (_state == STATE_RESERVED);
}

- (void)reserveAtSpawnPosition:(CGPoint)spawnPosition {

	self.sprite.position = spawnPosition;
	
	[self changeState:STATE_RESERVED];
}

- (void)spawnWithSpeed:(CGFloat)speed {
	
	self.heading = ccp(_spawnDirection, 0.0f);
	self.speed = speed;
	
	[self changeState:STATE_FLYING];
}

- (void)spawnWithSpeed:(GLfloat)speed atSpawnPosition:(CGPoint)spawnPosition {
	
	self.sprite.position = spawnPosition;
	
	[self spawnWithSpeed:speed];
}

- (void)setLanded {
	
	[self changeState:STATE_LANDED];
}

- (void)setFlying {
	
	[self changeState:STATE_FLYING];
}

- (BOOL)isLanded {
	
	return (_state == STATE_LANDED);
}

- (BOOL)isCrashed {
	
	return (_state == STATE_DYING);
}

- (void)rotate:(GLfloat)degrees {
	
	self.sprite.rotation += degrees;
	
	self.heading = ccpForAngle( -CC_DEGREES_TO_RADIANS(self.sprite.rotation) );
}

@end
