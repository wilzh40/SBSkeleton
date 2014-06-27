//
//  GameScene.m
//  RoidAvoid
//
//  Created by Wilson Zhao on 5/24/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (void) onEnter
{
    singleton = [Singleton sharedManager];
    winSize = [[CCDirector sharedDirector]viewSize];
    
	
	[super onEnter];
    [self setupScene];

}

- (void) onExit
{
    [_motionManager startAccelerometerUpdates];
    [[OALSimpleAudio sharedInstance] playBg:@"Piano.m4a" loop:YES];
    [super onExit];
	
}

#pragma mark Setup

- (void) setupScene
{
  
    // Enabling touch
    
    self.multipleTouchEnabled = YES;
    
    // Physics properties config
    physicsNode.debugDraw = NO;
    if (physicsNode.collisionDelegate == Nil)
        physicsNode.collisionDelegate = self;
    
    // Resetting the singleton properties
    singleton.firstGame = NO;
    singleton.score = 0;
    
    // Hiding the back button
    back.visible = YES;
    back.userInteractionEnabled = YES;
    pause.visible = NO;
    pause.userInteractionEnabled = NO;
    
    // Initing the accelerometer
    _motionManager = [[CMMotionManager alloc]init];
    [_motionManager startAccelerometerUpdates];
    
    // Play background music
    [[OALSimpleAudio sharedInstance] playBg:@"Jazz.mp3" loop:YES];
    
    // Other setup functions
    [self displayHighScore];
    
    NSLog(@"Setup Scene");
    
}

- (void) displayHighScore
{
    // Displays the high score
    int highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"] intValue ];
    [highScoreLabel setString:[NSString stringWithFormat:@"%d",highScore]];
}

#pragma mark Scheduler
- (void) update:(CCTime) dt
{
    singleton.score++;
    [scoreLabel setString:[NSString stringWithFormat:@"%d",singleton.score]];
    
}

#pragma mark Event Handling

- (void) handleGameOver
{
    //Sets score
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:singleton.score] forKey:@"Score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    int highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"] intValue ];
    
    if (singleton.score>highScore){
        //If score is higher than the highscore, saves the highscore!
        highScore = singleton.score;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:highScore] forKey:@"HighScore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // There is a high score in town!
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:@"HighScoreBool"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    //Plays game over screen at on the same layer
    
    CCScene *GameOverScene = [CCBReader loadAsScene:@"GameOverScene"];
    [[CCDirector sharedDirector]replaceScene:GameOverScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
    
    singleton.firstGame = YES;
}


- (void) handlePauseGame
{
    
    // Displays a blurred background
    [singleton storeBlurredSprite:self];
    blurredSprite = singleton.blurredSprite;
    
    CCActionFiniteTime *fadeOut = [CCActionFadeOut actionWithDuration:1.0f];
    CCActionFiniteTime *fadeIn = [CCActionFadeOut actionWithDuration:1.0f];
    
    [blurredSprite runAction:[CCActionSequence actionWithArray:@[fadeOut,fadeIn]]];
    
    [self addChild:blurredSprite];
    
    // Enable the Back Button
    back.zOrder = 100;
    back.visible = YES;
    back.userInteractionEnabled = YES;
    pause.visible = NO;
    pause.userInteractionEnabled = NO;
    
    
    // [blurredSprite runAction:[CCActionFadeTo actionWithDuration:0.1f opacity:0.0f]];
    
    [back runAction:[CCActionFadeTo actionWithDuration:0.1f opacity:0.0f]];
    [back runAction:[CCActionFadeTo actionWithDuration:1.0f opacity:1.0f]];
    // Pauses the Game
    self.paused = true;
    
}

- (void) handleResumeGame
{
    [self removeChild:blurredSprite];
    back.visible = NO;
    back.userInteractionEnabled = NO;
    pause.visible = YES;
    pause.userInteractionEnabled = YES;
    
    self.paused = false;
    
    
}

#pragma mark User Interaction

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{


}

- (void) touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
   

}

- (void) releaseMovement
{
   
}

- (void) updateAccelerometer
{
    if (singleton.controlScheme == kAccelerometer) {
        
    }
}
@end
