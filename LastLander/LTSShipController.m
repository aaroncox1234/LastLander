//
//  LTSShipController.m
//  LastLander
//
//  Created by Aaron Cox on 2013-08-04.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSShipController.h"
#import "LTSConstants.h"

static const int INPUT_NONE = 0;
static const int INPUT_STEER_CW = 1;
static const int INPUT_STEER_CCW = (1<<1);
static const int INPUT_BOOST = (1<<2);

@interface LTSShipController ()
{
	CGFloat _leftScreenTouchThreshold;
	CGFloat _rightScreenTouchThreshold;
	
	int _inputSteerState;
	int _inputBoostState;
	
	NSInteger *_inputSteerTouchHash;
	NSInteger *_inputBoostTouchHash;
}

- (id)init;

@end

@implementation LTSShipController

+ (LTSShipController *)createShipController {
	
	return [[LTSShipController alloc] init];
}

- (void)SetControlledShip:(LTSShip *)ship {
	
	if (self.ship != NULL) {
		
		self.ship.speed = PLAYER_SHIP_SPEED_MIN;
	}
	
	_ship = ship;
}

- (void)update:(ccTime)dt {
	
	if (self.ship == NULL) {
		
		return;
	}
	
	if (self.ship.isLanded) {
		
		if (_inputBoostState == INPUT_BOOST) {
			
			// The ship has to leave the current landing zone before it can land again.
			self.ship.canLand = NO;
			
			[self.ship setSpeed:PLAYER_SHIP_SPEED_MIN];
			[self.ship setFlying];
			
			_inputBoostState = INPUT_NONE;
			_inputBoostTouchHash = -1;
		}
	}
	else {
		
		if (_inputBoostState == INPUT_BOOST)	{
			
			self.ship.speed = MIN(self.ship.speed + PLAYER_SHIP_SPEED_BOOST_RATE, PLAYER_SHIP_SPEED_MAX);
		}
		// TODO: it's not very nice how Ship and ShipController can fight over speed...
		else if (self.ship.collidingLandingStrip == NULL) {
			
			self.ship.speed = MAX(self.ship.speed - PLAYER_SHIP_SPEED_BOOST_RATE, PLAYER_SHIP_SPEED_MIN);
		}
		
		float rotation = PLAYER_SHIP_TURN_RATE_DEGREES * dt;
		
		if (_inputSteerState == INPUT_STEER_CW) {
				
			[self.ship rotate:rotation];
		}
		else if (_inputSteerState == INPUT_STEER_CCW) {
				
			[self.ship rotate:-rotation];
		}
		
		// Assumption: The ship can't land because it's still in its initial landing zone.
		// TODO: Remove this logic in the second pass of player control.
		if (!self.ship.canLand) {
			
			if (!self.ship.isHitLandingZone) {
				
				self.ship.canLand = YES;
			}
		}
	}
}

- (void)onScreenTouchStart:(CGPoint)location touchHash:(NSInteger *)hash {
	
	if ( self.ship == NULL) {
		
		return;
	}
	
	if (location.x < _leftScreenTouchThreshold) {
		
		_inputSteerState = INPUT_STEER_CCW;
		_inputSteerTouchHash = hash;
	}
	else if (location.x > _rightScreenTouchThreshold) {
		
		_inputSteerState = INPUT_STEER_CW;
		_inputSteerTouchHash = hash;
	}
	else {
		
		_inputBoostState = INPUT_BOOST;
		_inputBoostTouchHash = hash;
	}
}

- (void)onScreenTouchEnd:(CGPoint)location touchHash:(NSInteger *)hash {

	if ( self.ship == NULL) {
		
		return;
	}
	
	if (hash == _inputSteerTouchHash) {
		
		_inputSteerState = INPUT_NONE;
		_inputSteerTouchHash = -1;
	}
	else if (hash == _inputBoostTouchHash) {
		
		_inputBoostState = INPUT_NONE;
		_inputBoostTouchHash = -1;
	}
}

- (id)init {
	
	self = [super init];
	
	if (self) {
		
		_ship = NULL;
		
		_inputSteerTouchHash = -1;
		_inputBoostTouchHash = -1;
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		_leftScreenTouchThreshold = winSize.width * SCREEN_SIDE_TOUCH_THRESHOLD_PERCENT;
		_rightScreenTouchThreshold = winSize.width - winSize.width * SCREEN_SIDE_TOUCH_THRESHOLD_PERCENT;
	}
	
	return self;
}

@end
