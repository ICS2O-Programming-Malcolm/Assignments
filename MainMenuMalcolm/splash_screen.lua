-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Malcolm Cantin
-- Date: May 25, 2020
-- Description: This is the splash screen of the game. It animates parts of my company 
-- logo to come together on the screen.
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local background

local text
local scrollSpeedText = 6
local movingText = true

local crown -- 

local key -- zoom in?

local trophy
local trophyScrollXSpeed = 8
local trophyScrollYSpeed = -3
local movingTrophy = true

----------------------------------------------------------------------------------------
-- SOUNDS
----------------------------------------------------------------------------------------

local splashScreenSound = audio.loadSound("Sounds/splashScreenSound.mp3")
local splashScreenSoundChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

local function StopTrophy()
	if (trophy.x >= 768) and (trophy.y <= 192) then

        movingTrophy = false
        
        trophy:rotate(217)

        trophy.x = 850
        trophy.y = 130

	end

end

-- The function that moves the trophy across the screen
local function MoveTrophy()
    if (movingTrophy == true) then

        trophy.x = trophy.x + trophyScrollXSpeed
        trophy.y = trophy.y + trophyScrollYSpeed

        trophy:rotate(6)

        StopTrophy()

    end

end

local function StopText()
	if (text.x >= 512) then

		movingText = false

	end

end

local function MoveText()
	if (movingText == true) then

        text.x = text.x + scrollSpeedText
        
        text.alpha = text.alpha + 0.02
		
		StopText()

	end

end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu", {effect = "fromRight", time = 1000} )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- insert the background
    background = display.newImageRect("Images/Background.png", 1024, 768)
    background.anchorX = 0
    background.anchorY = 0

    -- insert the trophy image
    trophy = display.newImageRect("Images/Trophy.png", 382, 422)
    trophy:scale(0.5, 0.5)

    -- set the initial x and y position of the trophy
    trophy.x = 100
    trophy.y = display.contentHeight/2

    -- insert the text image
    text = display.newImageRect("Images/Cantin's Contests.png", 1614, 212)
    text:scale(0.5, 0.5)

    -- set the initial x and y position of the trophy and make it invisible
    text.x = 0
    text.y = display.contentHeight/2
    text.alpha = 0

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( background )
    sceneGroup:insert( trophy )
    sceneGroup:insert( text )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        splashScreenSoundChannel = audio.play(splashScreenSound)

        -- Call the moveText function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveText)

        -- Call the MoveTrophy function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveTrophy)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay (3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the splash screen sound channel for this screen
        audio.stop(splashScreenSoundChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
