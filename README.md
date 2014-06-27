##What is SBSkeleton?

SB Skeleton is a simple barebones template for cocos2d v3.1 and SpriteBuilder, containing the skeleton to make a simple game. The scenes are in a landscape orientation, but everything is easily changeable. 

###Why?

After while I got tired of doing the same tedious tasks: connecting different game scenes to buttons and reinventing the wheel by implementing high scores, volume, and all the basics of a game. Thus I decided to have a starting point template for all my games. 

##What does SBSkeleton contain?

It contains 5 scenes, all self-explanatory: 
- MainScene
- GameScene
- GameOverScene
- OptionScene
- CreditsScene
... and a Singleton

It contains various options in OptionScene:
- BGVolume
- FXVolume
- Reset High Score

##How do I use SBSkeleton?

Double click the project name in Xcode slowly, and rename it to whatever you choose.
You can also rename the containing folder, but make sure it has ".spritebuilder" in the name so it can be opened by the editor.


##Roadmap
SBSkeleton is still a work in progress, and there are various flaws
I hope to fix, later on:
- Improper accelerometer calibration
- Bad programming syntax/conventions
- Lack of comments
- Fixing the credits for proper scrolling
- Renaming the Singleton 







