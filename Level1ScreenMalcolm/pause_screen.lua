-----------------------------------------------------------------------------------------
-- pause_screen.lua
-- Created by: Allison
-- Date: May 16, 2017
-- Edited by: Malcolm Cantin
-- Editied on: June 17, 2020
-- Description: This is the pause screen of my game. In it, the user can choose to mute 
-- the sound if it is not already, resume the game, and they can also return to the main 
-- menu.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics" )


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "pause_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local questionText

local bkg
local cover

local resumeButton
local muteButton
local unmuteButton

local mainMenuButton

-----------------------------------------------------------------------------------------
--SOUNDS
-----------------------------------------------------------------------------------------

-- local correctSound = audio.loadSound("Sounds/correct.mp3")
-- local correctSoundChannel

-- local incorrectSound = audio.loadSound("Sounds/incorrect.mp3")
-- local incorrectSoundChannel

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function BackToLevel1() 
    composer.hideOverlay("crossFade", 600 )
  
    ResumeGameFromPause()
    
end

-- This function returns to the main menu
local function ReturnToMenu()

    composer.gotoScene("main_menu", {effect = "fade", time = 2000})

end

-- This function will mute all sounds
local function Mute(touch)

    if (touch.phase == "ended") then

        -- make soundOn false
        soundOn = false

        -- make mute button visible
        muteButton.isVisible = true
        unmuteButton.isVisible = false

    end

end

-- This function will unmute all sounds
local function Unmute(touch)

    if (touch.phase == "ended") then

        -- make soundOn true
        soundOn = true

        -- make unmute button visible
        muteButton.isVisible = false
        unmuteButton.isVisible = true

    end

end

-- Add mute/unmute button listeners
local function AddMuteUnmuteListeners()

    unmuteButton:addEventListener("touch", Mute)

    muteButton:addEventListener("touch", Unmute)

end

-- Remove mute/unmute button listeners
local function RemoveMuteUnmuteListeners()

    unmuteButton:removeEventListener("touch", Mute)

    muteButton:removeEventListener("touch", Unmute)

end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view  

    -----------------------------------------------------------------------------------------
    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.5)

    -----------------------------------------------------------------------------------------
    --making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(96/255, 96/255, 96/255)

    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)
    
    -- mute button 
    muteButton = display.newImageRect ("Images/mute.png", 70, 70)
    muteButton:scale(2, 2)
    muteButton.x = display.contentCenterX
    muteButton.y = display.contentCenterY
    muteButton.isVisible = false

    -- unmute button 
    unmuteButton = display.newImageRect ("Images/unmute.png", 70, 70)
    unmuteButton:scale(2, 2)
    unmuteButton.x = display.contentCenterX
    unmuteButton.y = display.contentCenterY
    unmuteButton.isVisible = true

    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Main Menu Button
    resumeButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = 250,

            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Resume Button Unpressed.png",
            overFile = "Images/Resume Button Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = BackToLevel1          
        } )

    -- Creating Resume Button
    mainMenuButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight - 120,

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
    sceneGroup:insert( resumeButton )
    sceneGroup:insert( mainMenuButton )

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        -- add the mute and unmute functionality to the buttons
        AddMuteUnmuteListeners()

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        --parent:resumeGame()

        -- Remove the mute/unmute listeners
        RemoveMuteUnmuteListeners()

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

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