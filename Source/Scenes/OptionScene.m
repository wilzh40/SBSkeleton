//
//  OptionScene.m
//  Untitled
//
//  Created by Wilson Zhao on 4/8/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "OptionScene.h"
#import "Singleton.h"

@implementation OptionScene

- (void) onEnter
{

    // First syncs the sliderValues to the previous session
    backgroundVolume.sliderValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"BGVolume"]floatValue];
    effectsVolume.sliderValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"FXVolume"]floatValue];
    
    // Changes the button text based on the control scheme
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ControlScheme"]intValue] == kTouch) {
        controlScheme.title = [NSString stringWithFormat:@"Control Scheme: Touch"];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ControlScheme"]intValue] == kAccelerometer) {
        controlScheme.title = [NSString stringWithFormat:@"Control Scheme: Accelerometer"];
    }
    
    // Inits various managers
    singleton = [Singleton sharedManager];
    _motionManager = [[CMMotionManager alloc]init];
    [_motionManager startAccelerometerUpdates];
    self.userInteractionEnabled = TRUE;
    
    [super onEnter];
}

- (void) onExit
{
    [_motionManager stopAccelerometerUpdates];
    [super onExit];
}

- (void) pressedBack
{
    [[CCDirector sharedDirector]popSceneWithTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

- (void) pressedResetHighScore
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:0] forKey:@"HighScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // Kills the highscore
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HighScoreBool"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"Reset High Score");
}

- (void) setCalibrationVector
{
 
    // Sets the calibration vector based on the current tilt of the device
    // Still buggy and needs integration with the z-axis
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;

    singleton.calibrationVector = ccp(acceleration.y,acceleration.x);
    NSLog(@"Set Calibration Vector:%f,%f",singleton.calibrationVector.y,singleton.calibrationVector.x);

}

- (void) setControlScheme
{
    // Switches the control scheme based on the current one
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ControlScheme"]intValue] == kTouch) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:kAccelerometer] forKey:@"ControlScheme"];
       [controlScheme setTitle:[NSString stringWithFormat:@"Control Scheme: Accelerometer"]];
    
    }
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ControlScheme"]intValue] == kAccelerometer) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:kTouch] forKey:@"ControlScheme"];
        [controlScheme setTitle:[NSString stringWithFormat:@"Control Scheme: Touch"]];
    }

    NSLog(@"Changed Control Scheme to :%@",
          ([[[NSUserDefaults standardUserDefaults]objectForKey:@"ControlScheme"]intValue]==1)?@"Accel":@"Touch");

}

- (void)valueChanged1:(CCSlider *)sender
{
    // Change volume of your sounds
    [[OALSimpleAudio sharedInstance] setEffectsVolume:sender.sliderValue];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:sender.sliderValue] forKey:@"FXVolume"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)valueChanged2:(CCSlider *)sender
{
    // Change volume of your sounds
    [[OALSimpleAudio sharedInstance] setBgVolume:sender.sliderValue];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:sender.sliderValue] forKey:@"BGVolume"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
