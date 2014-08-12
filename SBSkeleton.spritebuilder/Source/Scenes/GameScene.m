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
    _singleton = [Singleton sharedManager];
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
    self.userInteractionEnabled = YES;
    // Physics properties config
    _physicsNode.debugDraw = NO;
    if (_physicsNode.collisionDelegate == Nil)
        _physicsNode.collisionDelegate = self;
    
    // Resetting the singleton properties
    _singleton.firstGame = NO;
    _singleton.score = 0;
    
    // Hiding the back/menu buttons
    _menu.visible = NO;
    _menu.userInteractionEnabled = NO;
    _back.visible = NO;
    _back.userInteractionEnabled = NO;
    _pause.visible = YES;
    _pause.userInteractionEnabled = YES;
    
    
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
    [_highScoreLabel setString:[NSString stringWithFormat:@"%d",highScore]];
}

#pragma mark Scheduler
- (void) update:(CCTime) dt
{
    // Updates the score label
    //_singleton.score++;
    [_scoreLabel setString:[NSString stringWithFormat:@"%d",_singleton.score]];
    
}

#pragma mark Event Handling

- (void) handleGameOver
{
    // Sets score
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_singleton.score] forKey:@"Score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    int _highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"] intValue ];
    
    if (_singleton.score>_highScore){
        // If score is higher than the highscore, saves the highscore!
        _highScore = _singleton.score;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_highScore] forKey:@"HighScore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // There is a high score in town!
        [[NSUserDefaults standardUserDefaults] setBool:YES  forKey:@"HighScoreBool"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    
    // Plays game over screen at on the same layer
    
    CCScene *GameOverScene = [CCBReader loadAsScene:@"GameOverScene"];
    [[CCDirector sharedDirector]replaceScene:GameOverScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
    
    _singleton.firstGame = YES;
}


- (void) handlePauseGame
{
    
    // Displays a blurred background
    [_singleton storeBlurredSprite:self];
    _blurredSprite = _singleton.blurredSprite;
    
    CCActionFiniteTime *fadeOut = [CCActionFadeOut actionWithDuration:1.0f];
    CCActionFiniteTime *fadeIn = [CCActionFadeOut actionWithDuration:1.0f];
    
    [_blurredSprite runAction:[CCActionSequence actionWithArray:@[fadeOut,fadeIn]]];
    
    [self addChild:_blurredSprite];
    
    // Enable the Back Button
    
    _back.zOrder = 100;
    _menu.zOrder = 100;
    _back.visible = YES;
    _back.userInteractionEnabled = YES;
    _menu.visible = YES;
    _menu.userInteractionEnabled = YES;
    _pause.visible = NO;
    _pause.userInteractionEnabled = NO;
    
    
    // [blurredSprite runAction:[CCActionFadeTo actionWithDuration:0.1f opacity:0.0f]];
    
    [_back runAction:[CCActionFadeTo actionWithDuration:0.1f opacity:0.0f]];
    [_back runAction:[CCActionFadeTo actionWithDuration:1.0f opacity:1.0f]];
    [_menu runAction:[CCActionFadeTo actionWithDuration:0.1f opacity:0.0f]];
    [_menu runAction:[CCActionFadeTo actionWithDuration:1.0f opacity:1.0f]];
    // Pauses the Game
    self.paused = true;
    
}

- (void) handleResumeGame
{
    [self removeChild:_blurredSprite];
    _back.visible = NO;
    _back.userInteractionEnabled = NO;
    _menu.visible = NO;
    _menu.userInteractionEnabled = NO;
    _pause.visible = YES;
    _pause.userInteractionEnabled = YES;
    
    self.paused = false;
    
    
}

- (void) handleMenu
{
    CCScene *scene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector]pushScene:scene withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

#pragma mark User Interaction

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //Overwrite these functions to provide input functionality
    
    /*
    if (self.paused)
        [self handleResumeGame];
    else
        [self handlePauseGame];
     */
    
   
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
     _singleton.score++;
    _bgColor.color = [CCColor colorWithCcColor4f:ccc4f(frandom_range(0, 1.0f), frandom_range(0, 1.0f), frandom_range(0,1.0f),frandom_range(0, 1.0f))];

}

- (void) touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
   

}

- (void) releaseMovement
{
   
}

- (void) updateAccelerometer
{
    if (_singleton.controlScheme == kAccelerometer) {
        
        float X =  _motionManager.accelerometerData.acceleration.x;
        float Y =  _motionManager.accelerometerData.acceleration.y;
        float Z =  _motionManager.accelerometerData.acceleration.z;
        GLKVector2 accel2d = {{0,0}};
        GLKVector3 ax = {{1, 0, 0}};
        GLKVector3 ay = {{-.63f, 0,-.92f}};
        //  GLKVector3 ay = {{0,0,0}};
        GLKVector3 az = GLKVector3Normalize(GLKVector3CrossProduct(ay, ax));
        GLKVector3 xyz = {{X,Y,Z}};
        ax = GLKVector3Normalize(GLKVector3CrossProduct(az, ay));
        accel2d.x = GLKVector3DotProduct(xyz, ax);
        accel2d.y = GLKVector3DotProduct(xyz, az);
        
        const float xSensitivity = 2.8f;
        const float ySensitivity = 2.8f; //the magic numbers!
        const float tiltAmplifier = 2;
        
        // Use vx and vy as final outputs
        float vx = (accel2d.y) * tiltAmplifier * xSensitivity;
        float vy = accel2d.x * tiltAmplifier * ySensitivity;
        
    }
}
@end
