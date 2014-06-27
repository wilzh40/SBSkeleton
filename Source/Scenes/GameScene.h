//
//  GameScene.h
//  RoidAvoid
//
//  Created by Wilson Zhao on 5/24/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "cocos2d.h"
#import "Singleton.h"

enum HeroMovement {
    MOVE_RIGHT = -1,
    MOVE_STILL,
    MOVE_LEFT,
};

@interface GameScene : CCNode <CCPhysicsCollisionDelegate,UIAccelerometerDelegate> {
    CGSize winSize;
    Singleton *_singleton;
    CCPhysicsNode *_physicsNode;
   
   
    CCNode *_bgColor;
    
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_highScoreLabel;
    
    CCSprite *_blurredSprite;
    CCButton *_back, *_pause;
    
    CMMotionManager *_motionManager;
    
}

@end
