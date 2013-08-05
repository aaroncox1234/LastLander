//
//  IntroLayer.m
//  LastLander
//
//  Created by Aaron Cox on 2013-05-04.
//  Copyright Aaron Cox 2013. All rights reserved.
//

#import "IntroLayer.h"

#import "LTSGameLayer.h"

#pragma mark - IntroLayer

@implementation IntroLayer

+ (CCScene *)scene
{
	IntroLayer *layer = [IntroLayer node];
	
	CCScene *scene = [CCScene node];
	[scene addChild: layer];
	
	return scene;
}

- (id)init {
	
	self = [super init];
	
	if (self) {

		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		[self addChild: background];
	}
	
	return self;
}

- (void)onEnter {
	
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LTSGameLayer scene] ]];
}
@end
