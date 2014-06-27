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
    Singleton *singleton;
    CCPhysicsNode *physicsNode;
   
   
    CCNode *bgColor;
    
    CCLabelTTF *scoreLabel;
    CCLabelTTF *highScoreLabel;
    
    CCSprite *blurredSprite;
    CCButton *back, *pause;
    
    CMMotionManager *_motionManager;
    
}

@end
