//
//  Constants.m
//  LastLander
//
//  Created by Aaron Cox on 2013-06-17.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSConstants.h"

const float OFF_SCREEN_X = -9999.0f;
const float OFF_SCREEN_Y = -9999.0f;

const float SCREEN_SIDE_TOUCH_THRESHOLD_PERCENT = 0.2;

const int BLUE_SHIP_POOL_SIZE = 1;
const int RED_SHIP_POOL_SIZE = 10;
const int RED_SHIP_SPAWN_WARNING_BLIP_POOL_SIZE = 4;
const int SHIP_EXPLOSION_POOL_SIZE = BLUE_SHIP_POOL_SIZE + RED_SHIP_POOL_SIZE;

const float RED_SHIP_SPAWN_INTERVAL_MIN = 3.0f;
const float RED_SHIP_SPAWN_INTERVAL_MAX = 5.0f;

const float RED_SHIP_SPEED_MIN = 40.0f;
const float RED_SHIP_SPEED_MAX = 60.0f;

const float PLAYER_SHIP_SPEED_MIN = 40.0;
const float PLAYER_SHIP_SPEED_MAX = 100.0;
const float PLAYER_SHIP_SPEED_BOOST_RATE = 20.0f;
const float PLAYER_SHIP_TURN_RATE_DEGREES = 2.5f;

const float LANDING_ANGLE_MIN = 0.0f;
const float LANDING_ANGLE_MAX = 25.0f;

const float SPAWN_WARNING_BLIP_DURATION = 5.0f;

const int Z_ORDER_BACKGROUND = 0;
const int Z_ORDER_PLATFORM = 1;
const int Z_ORDER_BLUE_SHIP = 2;
const int Z_ORDER_RED_SHIP = 3;
const int Z_ORDER_SHIP_EXPLOSION = 4;
const int Z_ORDER_RED_SHIP_SPAWN_WARNING_BLIP = 5;