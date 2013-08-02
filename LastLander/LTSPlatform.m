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

- (id)initWithSprite:(CCSprite *)sprite localPolygon:(NSArray *)localPolygon landingZone:(CGRect)localLandingZone;

@end

@implementation LTSPlatform

+ (LTSPlatform *)createPlatform1WithBatchNode:(CCSpriteBatchNode *)batchNode position:(CGPoint)position {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"LTS_plat_01.png"];
	sprite.position = position;
	[batchNode addChild:sprite];
	
	NSArray *polygon = [NSArray arrayWithObjects:
						[NSValue valueWithCGPoint:CGPointMake(48.7f, 73.6f)],
						[NSValue valueWithCGPoint:CGPointMake(-48.8f, 73.1f)],
						[NSValue valueWithCGPoint:CGPointMake(-32.6f, 47.3f)],
						[NSValue valueWithCGPoint:CGPointMake(-30.3f, 21.5f)],
						[NSValue valueWithCGPoint:CGPointMake(-27.1f, 20.0f)],
						[NSValue valueWithCGPoint:CGPointMake(-26.2f, 4.7f)],
						[NSValue valueWithCGPoint:CGPointMake(-31.1f, 3.2f)],
						[NSValue valueWithCGPoint:CGPointMake(-29.8f, -35.4f)],
						[NSValue valueWithCGPoint:CGPointMake(-26.7f, -36.5f)],
						[NSValue valueWithCGPoint:CGPointMake(-26.6f, -47.5f)],
						[NSValue valueWithCGPoint:CGPointMake(-29.9f, -60.8f)],
						[NSValue valueWithCGPoint:CGPointMake(-44.2f, -62.7f)],
						[NSValue valueWithCGPoint:CGPointMake(-44.3f, -73.7f)],
						[NSValue valueWithCGPoint:CGPointMake(45.2f, -74.0f)],
						[NSValue valueWithCGPoint:CGPointMake(45.0f, -67.5f)],
						[NSValue valueWithCGPoint:CGPointMake(24.8f, -66.2f)],
						[NSValue valueWithCGPoint:CGPointMake(18.2f, -47.7f)],
						[NSValue valueWithCGPoint:CGPointMake(36.5f, -41.0f)],
						[NSValue valueWithCGPoint:CGPointMake(36.7f, -17.8f)],
						[NSValue valueWithCGPoint:CGPointMake(25.3f, -17.5f)],
						[NSValue valueWithCGPoint:CGPointMake(25.7f, -37.9f)],
						[NSValue valueWithCGPoint:CGPointMake(8.6f, -37.5f)],
						[NSValue valueWithCGPoint:CGPointMake(4.3f, -32.2f)],
						[NSValue valueWithCGPoint:CGPointMake(-1.3f, -32.8f)],
						[NSValue valueWithCGPoint:CGPointMake(-0.5f, -9.2f)],
						[NSValue valueWithCGPoint:CGPointMake(15.1f, -9.0f)],
						[NSValue valueWithCGPoint:CGPointMake(16.9f, 13.1f)],
						[NSValue valueWithCGPoint:CGPointMake(31.8f, 20.2f)],
						[NSValue valueWithCGPoint:CGPointMake(30.8f, 25.6f)],
						[NSValue valueWithCGPoint:CGPointMake(18.3f, 26.3f)],
						[NSValue valueWithCGPoint:CGPointMake(19.0f, 34.8f)],
						[NSValue valueWithCGPoint:CGPointMake(22.5f, 41.8f)],
						[NSValue valueWithCGPoint:CGPointMake(40.9f, 46.0f)],
						[NSValue valueWithCGPoint:CGPointMake(18.6f, 48.1f)],
						[NSValue valueWithCGPoint:CGPointMake(18.7f, 54.4f)],
						[NSValue valueWithCGPoint:CGPointMake(33.1f, 55.0f)],
						[NSValue valueWithCGPoint:CGPointMake(37.6f, 57.7f)],
						[NSValue valueWithCGPoint:CGPointMake(37.8f, 66.1f)],
						[NSValue valueWithCGPoint:CGPointMake(48.7f, 67.1f)],
						[NSValue valueWithCGPoint:CGPointMake(48.0f, 72.5f)],
						nil];
	
	CGRect landingZone = CGRectMake(-50.0f, 85.0f, 100.0f, 10.0f);
	
	return [[self alloc] initWithSprite:sprite localPolygon:polygon landingZone:landingZone];
}

+ (LTSPlatform *)createPlatform2WithBatchNode:(CCSpriteBatchNode *)batchNode position:(CGPoint)position {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"LTS_plat_02.png"];
	sprite.position = position;
	[batchNode addChild:sprite];
	
	NSArray *polygon = [NSArray arrayWithObjects:
						[NSValue valueWithCGPoint:CGPointMake(31.5f, 38.7f)],
						[NSValue valueWithCGPoint:CGPointMake(-31.1f, 38.5f)],
						[NSValue valueWithCGPoint:CGPointMake(-26.0f, 26.1f)],
						[NSValue valueWithCGPoint:CGPointMake(-27.7f, -23.5f)],
						[NSValue valueWithCGPoint:CGPointMake(-31.6f, -25.2f)],
						[NSValue valueWithCGPoint:CGPointMake(-31.4f, -39.0f)],
						[NSValue valueWithCGPoint:CGPointMake(15.7f, -39.3f)],
						[NSValue valueWithCGPoint:CGPointMake(16.2f, -32.5f)],
						[NSValue valueWithCGPoint:CGPointMake(29.6f, -28.1f)],
						[NSValue valueWithCGPoint:CGPointMake(29.1f, -21.2f)],
						[NSValue valueWithCGPoint:CGPointMake(25.5f, -20.6f)],
						[NSValue valueWithCGPoint:CGPointMake(24.3f, -15.4f)],
						[NSValue valueWithCGPoint:CGPointMake(18.9f, -15.0f)],
						[NSValue valueWithCGPoint:CGPointMake(18.1f, -4.8f)],
						[NSValue valueWithCGPoint:CGPointMake(14.9f, -3.4f)],
						[NSValue valueWithCGPoint:CGPointMake(13.3f, 3.8f)],
						[NSValue valueWithCGPoint:CGPointMake(10.2f, 4.9f)],
						[NSValue valueWithCGPoint:CGPointMake(10.3f, 19.2f)],
						[NSValue valueWithCGPoint:CGPointMake(19.0f, 19.5f)],
						[NSValue valueWithCGPoint:CGPointMake(21.5f, 21.7f)],
						[NSValue valueWithCGPoint:CGPointMake(21.9f, 28.1f)],
						[NSValue valueWithCGPoint:CGPointMake(28.4f, 29.4f)],
						[NSValue valueWithCGPoint:CGPointMake(30.7f, 33.8f)],
						[NSValue valueWithCGPoint:CGPointMake(30.8f, 38.2f)],
						nil];
	
	CGRect landingZone = CGRectMake(-32.0f, 50.0f, 64.0f, 10.0f);
	
	return [[self alloc] initWithSprite:sprite localPolygon:polygon landingZone:landingZone];
}

+ (LTSPlatform *)createPlatform3WithBatchNode:(CCSpriteBatchNode *)batchNode position:(CGPoint)position {
	
	CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"LTS_plat_03.png"];
	sprite.position = position;
	[batchNode addChild:sprite];
	
	NSArray *polygon = [NSArray arrayWithObjects:
						[NSValue valueWithCGPoint:CGPointMake(35.7f, 61.1f)],
						[NSValue valueWithCGPoint:CGPointMake(-35.5f, 61.4f)],
						[NSValue valueWithCGPoint:CGPointMake(-35.8f, 55.4f)],
						[NSValue valueWithCGPoint:CGPointMake(-22.8f, 47.1f)],
						[NSValue valueWithCGPoint:CGPointMake(-22.4f, 41.3f)],
						[NSValue valueWithCGPoint:CGPointMake(-31.0f, 40.7f)],
						[NSValue valueWithCGPoint:CGPointMake(-31.1f, 30.8f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.4f, 30.7f)],
						[NSValue valueWithCGPoint:CGPointMake(-14.8f, 20.1f)],
						[NSValue valueWithCGPoint:CGPointMake(-20.1f, 19.2f)],
						[NSValue valueWithCGPoint:CGPointMake(-24.6f, 14.3f)],
						[NSValue valueWithCGPoint:CGPointMake(-25.4f, -26.4f)],
						[NSValue valueWithCGPoint:CGPointMake(-26.5f, -45.9f)],
						[NSValue valueWithCGPoint:CGPointMake(-30.1f, -49.1f)],
						[NSValue valueWithCGPoint:CGPointMake(-29.8f, -61.5f)],
						[NSValue valueWithCGPoint:CGPointMake(26.4f, -61.7f)],
						[NSValue valueWithCGPoint:CGPointMake(26.9f, -52.0f)],
						[NSValue valueWithCGPoint:CGPointMake(31.5f, -50.0f)],
						[NSValue valueWithCGPoint:CGPointMake(30.7f, -43.8f)],
						[NSValue valueWithCGPoint:CGPointMake(27.2f, -43.1f)],
						[NSValue valueWithCGPoint:CGPointMake(26.1f, -38.9f)],
						[NSValue valueWithCGPoint:CGPointMake(20.2f, -37.8f)],
						[NSValue valueWithCGPoint:CGPointMake(19.0f, -26.7f)],
						[NSValue valueWithCGPoint:CGPointMake(16.3f, -25.7f)],
						[NSValue valueWithCGPoint:CGPointMake(15.0f, -15.4f)],
						[NSValue valueWithCGPoint:CGPointMake(18.8f, -11.6f)],
						[NSValue valueWithCGPoint:CGPointMake(18.1f, 0.8f)],
						[NSValue valueWithCGPoint:CGPointMake(11.7f, 1.3f)],
						[NSValue valueWithCGPoint:CGPointMake(19.8f, 10.4f)],
						[NSValue valueWithCGPoint:CGPointMake(21.2f, 18.1f)],
						[NSValue valueWithCGPoint:CGPointMake(26.8f, 19.1f)],
						[NSValue valueWithCGPoint:CGPointMake(27.3f, 39.5f)],
						[NSValue valueWithCGPoint:CGPointMake(17.0f, 41.8f)],
						[NSValue valueWithCGPoint:CGPointMake(17.8f, 47.6f)],
						[NSValue valueWithCGPoint:CGPointMake(23.0f, 47.3f)],
						[NSValue valueWithCGPoint:CGPointMake(29.1f, 54.1f)],
						[NSValue valueWithCGPoint:CGPointMake(35.8f, 55.3f)],
						[NSValue valueWithCGPoint:CGPointMake(34.9f, 60.4f)],
						nil];
    
	CGRect landingZone = CGRectMake(-37.0f, 72.0f, 75.0f, 10.0f);
	
	return [[self alloc] initWithSprite:sprite localPolygon:polygon landingZone:landingZone];
}

- (id)initWithSprite:(CCSprite *)sprite localPolygon:(NSArray *)localPolygon landingZone:(CGRect)localLandingZone {
	
	self = [super init];
	
	if (self) {
		
		_sprite = sprite;
		
		NSMutableArray *worldPolygon = [NSMutableArray arrayWithCapacity:[localPolygon count]];
		
		for (int i = 0; i < [localPolygon count]; i++) {
			
			CGPoint localPoint = [[localPolygon objectAtIndex:i] CGPointValue];
			
			CGPoint worldPoint = [_sprite convertToNodeSpaceAR:localPoint];
			
			[worldPolygon replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:worldPoint]];
		}
		
		_worldPolygon = worldPolygon;
		
		_landingZone.origin = [_sprite convertToNodeSpaceAR:localLandingZone.origin];
		_landingZone.size = localLandingZone.size;
	}
	
	return self;
}

@end
