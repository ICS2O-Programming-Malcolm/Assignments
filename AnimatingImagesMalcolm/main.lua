-----------------------------------------------------------------------------------------
-- Title: AnimatingImagesMalcolm
-- Name: Malcolm Cantin
-- Course: ICS2O
-- This program 
-----------------------------------------------------------------------------------------
-- Your code here

-- CODE FOR THE BLACKHOLE
-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- global variables
scrollSpeed = 3

-- background image with width and height
local backgroundImage = display.newImageRect("Images/background.jpg", 2048, 1536)

-- character image with width and height
local blackhole = display.newImageRect("Images/blackhole.png", 400, 200)

-- set the image to be transparent
blackhole.alpha = 0

-- set the initial x and y position of blackhole
blackhole.x = 0
blackhole.y = display.contentHeight/3

-- Function: MoveBlackhole
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the blackhole
local function MoveBlackhole(event)
	-- add the scroll speed to the x-value of the blackhole
	blackhole.x = blackhole.x + scrollSpeed
	-- change the transparency of the blackhole every time it moves so that it fades out
	blackhole.alpha = blackhole.alpha + 0.01
end

-- MoveBlackhole will be called over and over again
Runtime:addEventListener("enterFrame", MoveBlackhole)

-- CODE FOR THE ROCKETSHIP
-- character image with width and height
local rocketship = display.newImageRect("Images/rocketship.png", 200, 200)

-- set the image to be transparent
rocketship.alpha = 1

-- set the initial x and y position of rocketship
rocketship.x = 1024
rocketship.y = display.contentHeight*(2/3)

-- Function: MoveShip
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the ship
local function MoveRocket(event)
	-- add the scroll speed to the x-value of the ship
	rocketship.x = rocketship.x - scrollSpeed - 2
	-- change the transparency of the ship every time it moves so that it fades out
	rocketship.alpha = rocketship.alpha - 0.000000001
end

-- MoveRocket will be called over and over again
Runtime:addEventListener("enterFrame", MoveRocket)

-- flip the rocket
rocketship:scale(-1, 1)

-- CODE FOR THE ROCKETSHIP
-- character image with width and height
local rocketship = display.newImageRect("Images/rocketship.png", 200, 200)

-- set the image to be transparent
rocketship.alpha = 1

-- set the initial x and y position of rocketship
rocketship.x = 1024
rocketship.y = display.contentHeight*(2/3)

-- Function: MoveShip
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the ship
local function MoveRocket(event)
	-- add the scroll speed to the x-value of the ship
	rocketship.x = rocketship.x - scrollSpeed - 2
	-- change the transparency of the ship every time it moves so that it fades out
	rocketship.alpha = rocketship.alpha - 0.000000001
end

-- MoveRocket will be called over and over again
Runtime:addEventListener("enterFrame", MoveRocket)

-- flip the rocket
rocketship:scale(-1, 1)