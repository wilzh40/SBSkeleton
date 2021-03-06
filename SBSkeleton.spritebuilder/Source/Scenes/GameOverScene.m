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
    _singleton = [Singleton sharedManager];
    [self setScore];
    [super onEnter];
}

- (void) setScore
{
    int _score = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Score"] intValue ];
    NSLog(@"SCORE:%i",_score);
    [_scoreLabel setString:[NSString stringWithFormat:@"%i",_score]];
    
    int _highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"] intValue ];
    
    [_highScoreLabel setString:[NSString stringWithFormat:@"%i",_highScore]];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HighScoreBool"] == YES){
        // If there's a new high highScoreLabel.opacity = 0;
        _highScoreLabelHeader.opacity = 0;
        [_yourScoreLabel setString:[NSString stringWithFormat:@"New High Score!"]];
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
    _singleton.firstGame = YES;
}

- (void) handleRestartGame
{
    CCScene *gameScene = [CCBReader loadAsScene:@"GameScene"];
    
    [[CCDirector sharedDirector]replaceScene:gameScene withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
    _singleton.firstGame = YES;
}

@end
