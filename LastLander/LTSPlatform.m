//
//  LTSPlatform.m
//  LastLander
//
//  Created by Aaron Cox on 2013-06-23.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#import "LTSPlatform.h"
#import "LTSConstants.h"

@interface LTSPlatform ()

- (id)initWithSprite:(CCSprite *)sprite polygon:(LTSCollisionPolygon *)polygon landingStrip:(LTSCollisionSegment *)landingStrip landingZone:(CGRect)localLandingZone;

@end

@implementation LTSPlatform

+ (LTSPlatform *)createPlatform1WithBatchNode:(CCSpriteBatchNode *)batchNode position:(CGPoint)position {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"LTS_plat_01.png"];
	sprite.position = position;
	sprite.zOrder = Z_ORDER_PLATFORM;
	[batchNode addChild:sprite];
	
	LTSCollisionPolygon *polygon = [[LTSCollisionPolygon alloc] init];
	[polygon addPoint:CGPointMake(48.7f, 73.0f)];
	[polygon addPoint:CGPointMake(-48.8f, 73.0f)];
	[polygon addPoint:CGPointMake(-32.6f, 47.3f)];
	[polygon addPoint:CGPointMake(-30.3f, 21.5f)];
	[polygon addPoint:CGPointMake(-27.1f, 20.0f)];
	[polygon addPoint:CGPointMake(-26.2f, 4.7f)];
	[polygon addPoint:CGPointMake(-31.1f, 3.2f)];
	[polygon addPoint:CGPointMake(-29.8f, -35.4f)];
	[polygon addPoint:CGPointMake(-26.7f, -36.5f)];
	[polygon addPoint:CGPointMake(-26.6f, -47.5f)];
	[polygon addPoint:CGPointMake(-29.9f, -60.8f)];
	[polygon addPoint:CGPointMake(-44.2f, -62.7f)];
	[polygon addPoint:CGPointMake(-44.3f, -73.7f)];
	[polygon addPoint:CGPointMake(45.2f, -74.0f)];
	[polygon addPoint:CGPointMake(45.0f, -67.5f)];
	[polygon addPoint:CGPointMake(24.8f, -66.2f)];
	[polygon addPoint:CGPointMake(18.2f, -47.7f)];
	[polygon addPoint:CGPointMake(36.5f, -41.0f)];
	[polygon addPoint:CGPointMake(36.7f, -17.8f)];
	[polygon addPoint:CGPointMake(25.3f, -17.5f)];
	[polygon addPoint:CGPointMake(25.7f, -37.9f)];
	[polygon addPoint:CGPointMake(8.6f, -37.5f)];
	[polygon addPoint:CGPointMake(4.3f, -32.2f)];
	[polygon addPoint:CGPointMake(-1.3f, -32.8f)];
	[polygon addPoint:CGPointMake(-0.5f, -9.2f)];
	[polygon addPoint:CGPointMake(15.1f, -9.0f)];
	[polygon addPoint:CGPointMake(16.9f, 13.1f)];
	[polygon addPoint:CGPointMake(31.8f, 20.2f)];
	[polygon addPoint:CGPointMake(30.8f, 25.6f)];
	[polygon addPoint:CGPointMake(18.3f, 26.3f)];
	[polygon addPoint:CGPointMake(19.0f, 34.8f)];
	[polygon addPoint:CGPointMake(22.5f, 41.8f)];
	[polygon addPoint:CGPointMake(40.9f, 46.0f)];
	[polygon addPoint:CGPointMake(18.6f, 48.1f)];
	[polygon addPoint:CGPointMake(18.7f, 54.4f)];
	[polygon addPoint:CGPointMake(33.1f, 55.0f)];
	[polygon addPoint:CGPointMake(37.6f, 57.7f)];
	[polygon addPoint:CGPointMake(37.8f, 66.1f)];
	[polygon addPoint:CGPointMake(48.7f, 67.1f)];
	[polygon addPoint:CGPointMake(48.0f, 72.5f)];
	
	LTSCollisionSegment *landingStrip = [LTSCollisionSegment createSegmentFrom:ccp(48.7f, 73.0f) to:ccp(-48.8f, 73.0f)];
	
	CGRect landingZone = CGRectMake(-50.0f, 72.0f, 100.0f, 10.0f);
	
	return [[self alloc] initWithSprite:sprite polygon:polygon landingStrip:landingStrip landingZone:landingZone];
}

+ (LTSPlatform *)createPlatform2WithBatchNode:(CCSpriteBatchNode *)batchNode position:(CGPoint)position {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"LTS_plat_02.png"];
	sprite.position = position;
	sprite.zOrder = Z_ORDER_PLATFORM;
	[batchNode addChild:sprite];
	
	LTSCollisionPolygon *polygon = [[LTSCollisionPolygon alloc] init];
	[polygon addPoint:CGPointMake(31.5f, 38.7f)];
	[polygon addPoint:CGPointMake(-31.1f, 38.5f)];
	[polygon addPoint:CGPointMake(-26.0f, 26.1f)];
	[polygon addPoint:CGPointMake(-27.7f, -23.5f)];
	[polygon addPoint:CGPointMake(-31.6f, -25.2f)];
	[polygon addPoint:CGPointMake(-31.4f, -39.0f)];
	[polygon addPoint:CGPointMake(15.7f, -39.3f)];
	[polygon addPoint:CGPointMake(16.2f, -32.5f)];
	[polygon addPoint:CGPointMake(29.6f, -28.1f)];
	[polygon addPoint:CGPointMake(29.1f, -21.2f)];
	[polygon addPoint:CGPointMake(25.5f, -20.6f)];
	[polygon addPoint:CGPointMake(24.3f, -15.4f)];
	[polygon addPoint:CGPointMake(18.9f, -15.0f)];
	[polygon addPoint:CGPointMake(18.1f, -4.8f)];
	[polygon addPoint:CGPointMake(14.9f, -3.4f)];
	[polygon addPoint:CGPointMake(13.3f, 3.8f)];
	[polygon addPoint:CGPointMake(10.2f, 4.9f)];
	[polygon addPoint:CGPointMake(10.3f, 19.2f)];
	[polygon addPoint:CGPointMake(19.0f, 19.5f)];
	[polygon addPoint:CGPointMake(21.5f, 21.7f)];
	[polygon addPoint:CGPointMake(21.9f, 28.1f)];
	[polygon addPoint:CGPointMake(28.4f, 29.4f)];
	[polygon addPoint:CGPointMake(30.7f, 33.8f)];
	[polygon addPoint:CGPointMake(30.8f, 38.2f)];
	
	LTSCollisionSegment *landingStrip = [LTSCollisionSegment createSegmentFrom:ccp(31.5f, 38.7f) to:ccp(-31.1f, 38.5f)];
	
	CGRect landingZone = CGRectMake(-32.0f, 37.0f, 64.0f, 10.0f);
	
	return [[self alloc] initWithSprite:sprite polygon:polygon landingStrip:landingStrip landingZone:landingZone];
}

+ (LTSPlatform *)createPlatform3WithBatchNode:(CCSpriteBatchNode *)batchNode position:(CGPoint)position {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"LTS_plat_03.png"];
	sprite.position = position;
	sprite.zOrder = Z_ORDER_PLATFORM;
	[batchNode addChild:sprite];
	
	LTSCollisionPolygon *polygon = [[LTSCollisionPolygon alloc] init];
	[polygon addPoint:CGPointMake(35.7f, 61.1f)];
	[polygon addPoint:CGPointMake(-35.5f, 61.4f)];
	[polygon addPoint:CGPointMake(-35.8f, 55.4f)];
	[polygon addPoint:CGPointMake(-22.8f, 47.1f)];
	[polygon addPoint:CGPointMake(-22.4f, 41.3f)];
	[polygon addPoint:CGPointMake(-31.0f, 40.7f)];
	[polygon addPoint:CGPointMake(-31.1f, 30.8f)];
	[polygon addPoint:CGPointMake(-14.4f, 30.7f)];
	[polygon addPoint:CGPointMake(-14.8f, 20.1f)];
	[polygon addPoint:CGPointMake(-20.1f, 19.2f)];
	[polygon addPoint:CGPointMake(-24.6f, 14.3f)];
	[polygon addPoint:CGPointMake(-25.4f, -26.4f)];
	[polygon addPoint:CGPointMake(-26.5f, -45.9f)];
	[polygon addPoint:CGPointMake(-30.1f, -49.1f)];
	[polygon addPoint:CGPointMake(-29.8f, -61.5f)];
	[polygon addPoint:CGPointMake(26.4f, -61.7f)];
	[polygon addPoint:CGPointMake(26.9f, -52.0f)];
	[polygon addPoint:CGPointMake(31.5f, -50.0f)];
	[polygon addPoint:CGPointMake(30.7f, -43.8f)];
	[polygon addPoint:CGPointMake(27.2f, -43.1f)];
	[polygon addPoint:CGPointMake(26.1f, -38.9f)];
	[polygon addPoint:CGPointMake(20.2f, -37.8f)];
	[polygon addPoint:CGPointMake(19.0f, -26.7f)];
	[polygon addPoint:CGPointMake(16.3f, -25.7f)];
	[polygon addPoint:CGPointMake(15.0f, -15.4f)];
	[polygon addPoint:CGPointMake(18.8f, -11.6f)];
	[polygon addPoint:CGPointMake(18.1f, 0.8f)];
	[polygon addPoint:CGPointMake(11.7f, 1.3f)];
	[polygon addPoint:CGPointMake(19.8f, 10.4f)];
	[polygon addPoint:CGPointMake(21.2f, 18.1f)];
	[polygon addPoint:CGPointMake(26.8f, 19.1f)];
	[polygon addPoint:CGPointMake(27.3f, 39.5f)];
	[polygon addPoint:CGPointMake(17.0f, 41.8f)];
	[polygon addPoint:CGPointMake(17.8f, 47.6f)];
	[polygon addPoint:CGPointMake(23.0f, 47.3f)];
	[polygon addPoint:CGPointMake(29.1f, 54.1f)];
	[polygon addPoint:CGPointMake(35.8f, 55.3f)];
	[polygon addPoint:CGPointMake(34.9f, 60.4f)];
    
	LTSCollisionSegment *landingStrip = [LTSCollisionSegment createSegmentFrom:ccp(35.7f, 61.1f) to:ccp(-35.5f, 61.4f)];
	
	CGRect landingZone = CGRectMake(-37.0f, 60.0f, 75.0f, 10.0f);
	
	return [[self alloc] initWithSprite:sprite polygon:polygon landingStrip:landingStrip landingZone:landingZone];
}

- (id)initWithSprite:(CCSprite *)sprite polygon:(LTSCollisionPolygon *)polygon landingStrip:(LTSCollisionSegment *)landingStrip landingZone:(CGRect)localLandingZone {
	
	self = [super init];
	
	if (self) {
		
		_sprite = sprite;
		
		_collisionPolygon = polygon;
		[_collisionPolygon updateFromSprite:sprite];
		
		_landingStrip = landingStrip;
		[_landingStrip updateFromSprite:sprite];
		
		_landingZone.origin = [_sprite convertToWorldSpaceAR:localLandingZone.origin];
		_landingZone.size = localLandingZone.size;
	}
	
	return self;
}

@end
