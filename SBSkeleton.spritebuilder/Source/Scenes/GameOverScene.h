//
//  GameOverScene.h
//  Untitled
//
//  Created by Wilson Zhao on 4/8/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Singleton.h"

@interface GameOverScene : CCNode {
    CCLabelTTF *_scoreLabel, *_highScoreLabel, *_yourScoreLabel, *_highScoreLabelHeader;
    Singleton *_singleton;
}

@end
