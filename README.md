#SBSkeleton
###A game skeleton for cocos2d v3.x

SB Skeleton is a simple barebones template for cocos2d v3.x and SpriteBuilder, containing the skeleton to make a simple game. 

##Overview


It contains 5 scenes, all self-explanatory: 
- MainScene
- GameScene
- GameOverScene
- OptionScene
- CreditsScene
and a Singleton, for storing global variables.

It contains various options in OptionScene:
- Volume Controls
- Resetting High Score
- Switching the control scheme

It also includes:
- Detecting accelerometer velocity/movement
- Pause functionality
- The latest cocos2d submodule version

##Setup

1. Git clone this repo recursively (it has cocos2d and its submodules)

	git clone https://github.com/wilzh40/SBSkeleton.git --recursive

2. Open the directory `SBSkeleton.spritebuilder` with [SpriteBuilder](http://www.spritebuilder.com/) and hit the publish button

3. [Change the App name](http://stackoverflow.com/questions/238980/how-to-change-the-name-of-an-ios-app/20418989#20418989) to your project name

You're ready to go! 
 
##Why?

After while I got tired of doing the same tedious tasks: connecting different game scenes to buttons and reinventing the wheel by implementing high scores, volume, and all the basics of a game. Thus I decided to have a starting point template for all my games, and I hope this would help others as well.

##Roadmap


SBSkeleton is still a work in progress, and there are various flaws
I hope to fix, later on:
- Improper accelerometer calibration
- Bad programming syntax/conventions
- Fixing the credits for proper scrolling








