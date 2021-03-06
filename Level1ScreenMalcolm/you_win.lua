-----------------------------------------------------------------------------------------
-- SceneTemplate.lua
-- Scene Template (Composer API)
--
-- Edited by: Malcolm Cantin
-- Editied on: Apr. 28th, 2020
-- Course: ICS2O Programming
-- Description: This is the win screen of my game
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Calling Composer Library
local composer = require( "composer" )

local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "you_win"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- FORWARD REFERENCES
-----------------------------------------------------------------------------------------

-- local variables for the scene
local bkg

local mainMenuButton

----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------

-- add win sound effect
local winSound = audio.loadSound("Sounds/win.mp3")
local winSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- This function returns to the main menu
local function ReturnToMenu()

    composer.gotoScene("main_menu")

end

--------------------------------------------------------------------------------------
-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Display background
    bkg = display.newImage("Images/YouWin.png")
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight
   
    -- Associating display objects with this scene 
    sceneGroup:insert( bkg )

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Main Menu Button
    mainMenuButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth - 135,
            y = display.contentHeight - 95,

            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Main Menu Button Unpressed.png",
            overFile = "Images/Main Menu Button Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = ReturnToMenu          
        } )

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( mainMenuButton )
  
end    

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        if (soundOn == true) then

            -- play win sound effect
            winSoundChannel = audio.play(winSound, {channel = 12})

        end

    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

        if (soundOn == true) then

            -- stop win sound effect
            audio.stop(winSoundChannel)
            
        end

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

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