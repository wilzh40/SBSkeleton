//
//  Singleton.h
//  RoidAvoid
//
//  Created by Wilson Zhao on 5/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

#pragma mark Useful Macros

#define frandom                 ((float)arc4random()/UINT64_C(0x100000000))
#define frandom_range(low,high) (((high-low)*frandom)+low)
#define random_range(low,high)  ((arc4random()%(high-low+1))+low)
#define RTD(radians) (radian/M_PI*180)

typedef NS_ENUM(NSUInteger, ControlScheme) {
    kTouch = 0,
    kAccelerometer = 1
};


@interface Singleton : NSObject {
    int _score;
    bool _firstGame;
    bool _switched;
    CCSprite *_blurredSprite;
    
    ControlScheme _controlScheme;
    
    CGPoint _calibrationVector;
    
    CMMotionManager *_motionManager;
}

+ (id)sharedManager;

- (void) setDefaultVars;
- (void) storeBlurredSprite:(CCNode *)node;

@property (readwrite,nonatomic) int score;
@property (readwrite,nonatomic) bool firstGame;

@property (readwrite,nonatomic) ControlScheme controlScheme;

@property (readwrite,nonatomic) CGPoint asteroidPos;
@property (readwrite,nonatomic) CGPoint calibrationVector;

@property (nonatomic,strong) CCSprite *blurredSprite;

@end
