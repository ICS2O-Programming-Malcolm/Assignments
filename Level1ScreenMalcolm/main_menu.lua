-----------------------------------------------------------------------------------------
-- main_menu.lua
-- Created by: Malcolm Cantin
-- Course: ICS2O Programming
-- Date: June 10, 2020
-- Description: This is the main menu, that includes a credits screen, instructions 
-- screen, and a level 1 screen with buttons to each and back buttons from the 
-- credits/instructions screens.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

-- Create the global variable to check whether or not the user wants to play the music
soundOn = true

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- Variable for the background image
local bkg_image

-- Variables for the buttons
local playButton
local creditsButton
local instructionsButton

-- Variable for the jet
local jet

-- Vriables for the mute/unmute buttons
local muteButton
local unmuteButton

-----------------------------------------------------------------------------------------
-- LOCAL SOUNDS
-----------------------------------------------------------------------------------------

-- Load the main menu audio
local mainMenuMusic = audio.loadSound("Sounds/mainMenuMusic.mp3")
local mainMenuMusicChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- This function will mute all sounds
local function Mute(touch)

    if (touch.phase == "ended") then

        -- pause all sounds
        audio.pause(bgSoundL1Channel)

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

        -- resume all sounds
        audio.resume(bgSoundL1Channel)

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

-- REmove mute/unmute button listeners
local function RemoveMuteUnmuteListeners()

    unmuteButton:removeEventListener("touch", Mute)

    muteButton:removeEventListener("touch", Unmute)

end

-- This function rotates the jet
local function RotateJet()

    jet:rotate(1)

end

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "zoomOutInRotate", time = 1000})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "flipFadeOutIn", time = 1000})
end    

-----------------------------------------------------------------------------------------

local function InstructionsTransition( )
    composer.gotoScene( "instructions_screen", {effect = "zoomOutIn", time = 1000})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/main_menu.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- mute button 
    muteButton = display.newImageRect ("Images/mute.png", 70, 70)
    muteButton.x = 950
    muteButton.y = 60
    muteButton.isVisible = false

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( muteButton )

    -- mute button 
    unmuteButton = display.newImageRect ("Images/unmute.png", 70, 70)
    unmuteButton.x = 950
    unmuteButton.y = 60
    unmuteButton.isVisible = true
    
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( unmuteButton )

    -----------------------------------------------------------------------------------------
    -- MOVING OBJECTS IN THE BACKGROUND
    -----------------------------------------------------------------------------------------

    -- Insert the image of the jet
    jet = display.newImage("Images/jetMainMenu.png")
    jet.x = display.contentWidth/2
    jet.y = display.contentHeight/2 + 50
    jet:scale(0.125, 0.125)

    -- Associating display objects with this scene 
    sceneGroup:insert( jet )

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,

            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Start Button Unpressed.png",
            overFile = "Images/Start Button Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*7/8,
            y = display.contentHeight*7/8,

            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Credits Button Unpressed.png",
            overFile = "Images/Credits Button Pressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    
    
    -----------------------------------------------------------------------------------------

        -- Creating Credits Button
    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*7/8,

            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Instructions Button Unpressed.png",
            overFile = "Images/Instructions Button Pressed.png",

            -- When the button is released, call the instructions transition function
            onRelease = InstructionsTransition
        } ) 

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then       
        
        Runtime:addEventListener("enterFrame", RotateJet)

        if (soundOn == true) then
            -- play the background music
            mainMenuMusicChannel = audio.play(mainMenuMusic, {loops = -1})
            muteButton.isVisible = false
            unmuteButton.isVisible = true
        else
            -- pause the background music
            audio.pause(mainMenuMusic)
            muteButton.isVisible = true
            unmuteButton.isVisible = false
        end

        -- add the mute and unmute functionality to the buttons
        AddMuteUnmuteListeners()

    end

end -- function scene:show( event )

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
        
        Runtime:removeEventListener("enterFrame", RotateJet)

        audio.stop(mainMenuMusicChannel)

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

        -- Remove the mute/unmute listeners
        RemoveMuteUnmuteListeners()

        
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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