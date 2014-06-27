  //
//  GameOverScene.m
//  Untitled
//
//  Created by Wilson Zhao on 4/8/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameOverScene.h"
#import "Singleton.h"

@implementation GameOverScene

- (void) onEnter
{
    
    singleton = [Singleton sharedManager];
    [self setScore];
    [super onEnter];
}

- (void) setScore
{
    int score = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Score"] intValue ];
    NSLog(@"SCORE:%i",score);
    [scoreLabel setString:[NSString stringWithFormat:@"%i",score]];
    
    int highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"] intValue ];
    
    [highScoreLabel setString:[NSString stringWithFormat:@"%i",highScore]];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HighScoreBool"] == YES){
        // If there's a new high score
        highScoreLabel.opacity = 0;
        highScoreLabelHeader.opacity = 0;
        [yourScoreLabel setString:[NSString stringWithFormat:@"New High Score!"]];
        // Resets for next time
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HighScoreBool"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) handleQuitGame
{
    CCScene *mainMenu = [CCBReader loadAsScene:@"MainScene"];
    
    [[CCDirector sharedDirector]replaceScene:mainMenu withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
    [[OALSimpleAudio sharedInstance] playBg:@"Synth.mp3" loop:YES];
    singleton.firstGame = YES;
}

- (void) handleRestartGame
{
    CCScene *gameScene = [CCBReader loadAsScene:@"GameScene"];
    
    [[CCDirector sharedDirector]replaceScene:gameScene withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
    singleton.firstGame = YES;
}

@end
