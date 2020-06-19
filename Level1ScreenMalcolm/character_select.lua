-----------------------------------------------------------------------------------------
-- character_select.lua
-- Created by: Malcolm Cantin
-- Created on: Apr. 28th, 2020
-- Description: This is the character select screen of the game. The user will have a 
-- couple of options to choose from, and whichever one they choose will set that as the 
-- main character in the first level.
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
sceneName = "character_select"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local characterSelectText

local bkg
local cover

local character

local characterSelectJet
local characterSelectJet2
local characterSelectPlane

local characterSelectJetText
local characterSelectJet2Text
local characterSelectPlaneText

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

userSelect = 0

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function Level1Transition()

    composer.gotoScene("level1_screen", {effect = "fade", time = 2000})

end 

-----------------------------------------------------------------------------------------
--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerJet(touch)

    userSelect = 1
    
    if (touch.phase == "ended") then

        Level1Transition()
        
    end 

end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerPlane(touch)

    userSelect = 2
    
    if (touch.phase == "ended") then

        Level1Transition()
        
    end

end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerJet2(touch)

    userSelect = 3
    
    if (touch.phase == "ended") then

        Level1Transition()
        
    end 

end

--adding the event listeners 
local function AddTouchListeners()
    characterSelectJet:addEventListener( "touch", TouchListenerJet )
    characterSelectPlane:addEventListener( "touch", TouchListenerPlane )
    characterSelectJet2:addEventListener( "touch", TouchListenerJet2 )
end

--removing the event listeners
local function RemoveTouchListeners()
    characterSelectJet:removeEventListener( "touch", TouchListenerJet )
    characterSelectPlane:removeEventListener( "touch", TouchListenerPlane )
    characterSelectJet2:removeEventListener( "touch", TouchListenerJet2 )
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

    -- create the character select text object
    characterSelectText = display.newText("Choose Your Character!", display.contentCenterX, display.contentCenterY*3/8 - 40, Arial, 75)
    characterSelectText:setFillColor(0/255, 204/255, 0/255)

    -- create the jet
    characterSelectJet = display.newImage("Images/characterSelectJet.png")
    characterSelectJet.x = display.contentWidth*1/3 - 40
    characterSelectJet.y = display.contentHeight/2 - 110

    -- create the jet #1 text object
    characterSelectJetText = display.newText("Jet #1", display.contentWidth/2 + 30, display.contentHeight/3 - 20, Arial, 60)
    characterSelectJetText:setFillColor(0/255, 128/255, 128/255)

    -- create the plane
    characterSelectPlane = display.newImage("Images/characterSelectPlane.png")
    characterSelectPlane.x = display.contentWidth/2
    characterSelectPlane.y = display.contentHeight/2 + 50

    -- create the plane text object
    characterSelectPlaneText = display.newText("Plane", display.contentWidth/2 - 250, display.contentHeight/2 + 100, Arial, 60)
    characterSelectPlaneText:setFillColor(0/255, 128/255, 128/255)

    -- create jet 2
    characterSelectJet2 = display.newImage("Images/characterSelectJet2.png")
    characterSelectJet2.x = display.contentWidth*2/3 + 90
    characterSelectJet2.y = display.contentHeight/2 + 250

    -- create the jet #2 text object
    characterSelectJet2Text = display.newText("Jet #2", display.contentWidth/2 + 20, display.contentHeight - 60, Arial, 60)
    characterSelectJet2Text:setFillColor(0/255, 128/255, 128/255)

    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(characterSelectText)
    sceneGroup:insert(characterSelectJet)
    sceneGroup:insert(characterSelectPlane)
    sceneGroup:insert(characterSelectJet2)
    sceneGroup:insert(characterSelectJetText)
    sceneGroup:insert(characterSelectPlaneText)
    sceneGroup:insert(characterSelectJet2Text)

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
        AddTouchListeners()
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
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveTouchListeners()
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