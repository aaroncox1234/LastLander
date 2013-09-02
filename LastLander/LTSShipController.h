//
//  LTSShipController.h
//  LastLander
//
//  Created by Aaron Cox on 2013-08-04.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "LTSShip.h"

@interface LTSShipController : NSObject

@property (nonatomic, readonly, strong) LTSShip *ship;

+ (LTSShipController *)createShipController;

- (void)SetControlledShip:(LTSShip *)ship;

- (void)update:(ccTime)dt;

- (void)onScreenTouchStart:(CGPoint)location touchHash:(NSInteger *)hash;
- (void)onScreenTouchEnd:(CGPoint)location touchHash:(NSInteger *)hash;

@end
