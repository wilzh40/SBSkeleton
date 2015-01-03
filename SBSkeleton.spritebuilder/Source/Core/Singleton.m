//
//  Singleton.m
//  RoidAvoid
//
//  Created by Wilson Zhao on 5/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Singleton.h"




@implementation Singleton

+ (id)sharedManager {
    static Singleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id) init {
    if (self = [super init]) {
        _firstGame = TRUE;
        _motionManager = [[CMMotionManager alloc] init];
        [self setDefaultVars];
    }
    return self;
}

- (void) setDefaultVars
{
    NSMutableArray *vars = [NSMutableArray arrayWithObjects:@"ControlScheme", @"FXVolume", @"BGVolume", nil];
    NSMutableArray *values = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:0.5f], nil];
    for (int index = 1; index < [vars count]; index++) {
            if ([[NSUserDefaults standardUserDefaults]objectForKey:vars[index]] == nil) {
            [[NSUserDefaults standardUserDefaults]setObject:[values objectAtIndex:index] forKey:[vars objectAtIndex:index]];
            
        }
    }
    
}

-(void) storeBlurredSprite:(CCNode*)node{
    
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    UIImage *img = [self screenshotWithNode:node];
    CCTexture *texture = [[CCTexture alloc] initWithCGImage:img.CGImage contentScale:2.0f];
    _blurredSprite = [CCSprite spriteWithTexture:texture];
    _blurredSprite.position = ccp(winSize.width/2, winSize.height/2);
    _blurredSprite.effect = [CCEffectBlur effectWithBlurRadius:10];
    [self setBlurredSprite:_blurredSprite];
    
}
- (UIImage *) screenshotWithNode:(CCNode*)node
{
    
    CGSize winSize = [[CCDirector sharedDirector]viewSize];
    CCRenderTexture* rtx = [CCRenderTexture renderTextureWithWidth:winSize.width
                                                            height:winSize.height];
    [rtx begin];
    [node visit];
    [rtx end];
    
    return [rtx getUIImage];
}

@end
