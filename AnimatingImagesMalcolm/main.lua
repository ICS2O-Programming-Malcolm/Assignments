-----------------------------------------------------------------------------------------
-- Title: AnimatingImagesMalcolm
-- Name: Malcolm Cantin
-- Course: ICS2O
-- This program 
-----------------------------------------------------------------------------------------
-- Your code here

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- global variables
scrollSpeed = 3
scrollSpeed2 = 0.01
-- create text variable
local programText

-- background image with width and height
local backgroundImage = display.newImageRect("Images/background.jpg", 2048, 1536)

-- label the program and colour the text
programText = display.newText("Super Silly Space", display.contentWidth/2 + 120, display.contentHeight/1 - 80, Arial, 80)
programText:setTextColor(255/255, 106/255, 0/255) 
-----------------------------------------------------------------------------------------
-- Sounds
-----------------------------------------------------------------------------------------
-- load the sound
local timewarpSound = audio.loadSound( "Sounds/timewarp.mp3")
-- play the sound
audio.play( timewarpSound, {duration = 10000} )

-- CODE FOR THE BLACKHOLE
-- character image with width and height
local blackholeWidth = 400
local blackholeHeight = 200
local blackhole = display.newImageRect("Images/blackhole.png", blackholeWidth, blackholeHeight)

-- set the image to be transparent at first
blackhole.alpha = 1

-- set the initial x and y position of blackhole
blackhole.x = 0
blackhole.y = display.contentHeight/4

-- global blackhole variables
x = blackhole.x
y = blackhole.y

-- Function: MoveBlackhole
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the blackhole
local function MoveBlackhole(event)
	-- movement path
	y = x
	-- add the scroll speed to the x-value of the blackhole
	blackhole.x = blackhole.x + scrollSpeed
	-- make the blackhole grow as it moves
	blackhole:scale(1, 1)
	-- make the blackhole grow as it moves
	blackhole.xScale = blackhole.xScale + scrollSpeed2
	blackhole.yScale = blackhole.yScale + scrollSpeed2
end

-- MoveBlackhole will be called over and over again
Runtime:addEventListener("enterFrame", MoveBlackhole)

-- CODE FOR THE ROCKETSHIP
-- character image with width and height
local rocketship = display.newImageRect("Images/rocketship.png", 200, 200)

-- set the image to be visible at first
rocketship.alpha = 1

-- set the initial x and y position of rocketship
rocketship.x = 1024
rocketship.y = display.contentHeight*(2/3)

-- Function: MoveRocketship
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the ship
local function MoveRocketship(event)
	-- add the scroll speed to the x-value of the ship
	rocketship.x = rocketship.x - scrollSpeed - 2
end

-- MoveRocketship will be called over and over again
Runtime:addEventListener("enterFrame", MoveRocketship)

-- flip the rocket
rocketship:scale(-1, 1)

-- CODE FOR THE ALIEN
-- character image with width and height
local alien = display.newImageRect("Images/alien.png", 200, 200)

-- set the image to be transparent at first
alien.alpha = 1

-- set the initial x and y position of alien
alien.x = 0
alien.y = 768

-- Function: MoveAlien
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the alien
local function MoveAlien(event)
	-- add the scroll speed to the x-value of the alien
	alien.x = alien.x + scrollSpeed + 2
	alien.y = alien.y - scrollSpeed - 2
	-- change the transparency of the alien every time it moves so that it fades out
	alien.alpha = alien.alpha - 0.000000001
	-- make alien spin
	alien:rotate(10)
	timer.performWithDelay(10000)
end


-- MoveAlien will be called over and over again
Runtime:addEventListener("enterFrame", MoveAlien)