//
//  CCEffectGlow.h
//  cocos2d-ios
//
//  Created by Oleg Osin on 4/14/14.
//
//

#import "CCEffect.h"


@interface CCEffectGlow : CCEffect

@property (nonatomic) float blurStrength;

-(id)initWithbBlurStrength:(float)blurStrength;
+(id)effectWithBlurStrength:(float)blurStrength;

@end

