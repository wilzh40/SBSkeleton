##What is SBSkeleton?

SB Skeleton is a simple barebones template for cocos2d v3.x and SpriteBuilder, containing the skeleton to make a simple game. The scenes are in a landscape orientation, but everything is easily changeable. 

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
- Volume Controls
- Resetting High Score
- Switching the control scheme

It also includes:
- Detecting accelerometer velocity/movement
- Pause functionatity
- The latest cocos2d submodule version

##How do I use SBSkeleton?

1.Git clone this repo (recursively! It has cocos2d/chipmunk submodules.)

	git clone https://github.com/wilzh40/SBSkeleton.git --recursive

2.First rename the containing folder by adding a  ".spritebuilder" extension so it can opened by [SpriteBuilder](http://www.spritebuilder.com/)

3.[Change the App name](http://stackoverflow.com/questions/238980/how-to-change-the-name-of-an-ios-app/20418989#20418989)

4. Publish the resources within SpriteBuilder

You're ready to go! 

##Roadmap

SBSkeleton is still a work in progress, and there are various flaws
I hope to fix, later on:
- Improper accelerometer calibration
- Bad programming syntax/conventions
- Lack of comments
- Fixing the credits for proper scrolling
- Renaming the Singleton 







