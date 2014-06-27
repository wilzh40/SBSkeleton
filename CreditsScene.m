//
//  CreditsScene.m
//  Untitled
//
//  Created by Wilson Zhao on 4/9/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "CreditsScene.h"


@implementation CreditsScene

- (void) pressedBack
{
    [[CCDirector sharedDirector]popSceneWithTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

@end
