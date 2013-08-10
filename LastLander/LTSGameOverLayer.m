//
//  GameOverLayer.m
//  LastLander
//
//  Created by Aaron Cox on 2013-05-05.
//  Copyright 2013 Aaron Cox. All rights reserved.
//

#import "LTSGameOverLayer.h"
#import "LTSGameLayer.h"

@implementation LTSGameOverLayer

+ (CCScene *) scene {
	
    LTSGameOverLayer *layer = [[LTSGameOverLayer alloc] init];
    
	CCScene *scene = [CCScene node];
	[scene addChild: layer];
    
	return scene;
}

- (id)init {
	
	self = [super initWithColor:ccc4(0, 0, 0, 255)];
	
    if (self) {
        
        NSString *message = @"CRASHED";
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
		
        CCLabelTTF *label = [CCLabelTTF labelWithString:message fontName:@"Arial" fontSize:32];
        label.color = ccc3(255,255,255);
        label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:label];
        
        [self runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:3],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
             [[CCDirector sharedDirector] replaceScene:[LTSGameLayer scene]];
         }],
          nil]];
    }
    return self;
}

@end
