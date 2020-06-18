-----------------------------------------------------------------------------------------
-- level1_screen.lua
-- Created by: Allison
-- Date: May 16, 2017
-- Edited by: Malcolm Cantin
-- Editied on: Apr. 28th, 2020
-- Description: This is the level 1 question screen. A question will pop up and the user
-- has to choose an answer to keep playing.
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
sceneName = "level1_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene

local randomQuestionNum

local questionText

local answerText 
local wrongAnswerText1
local wrongAnswerText2
local wrongAnswerText3

local answerPosition = 1
local bkg
local cover

local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*4/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7

local userAnswer
local textTouched = false

-----------------------------------------------------------------------------------------
--SOUNDS
-----------------------------------------------------------------------------------------

local correctSound = audio.loadSound("Sounds/correct.mp3")
local correctSoundChannel

local incorrectSound = audio.loadSound("Sounds/incorrect.mp3")
local incorrectSoundChannel

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function BackToLevel1() 
    composer.hideOverlay("crossFade", 400 )
  
    ResumeGameFromQuestion()
    
end 

-----------------------------------------------------------------------------------------
--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerAnswer(touch)
    userAnswer = answerText.text
    
    if (touch.phase == "ended") then

        if (soundOn == true) then

            correctSoundChannel = audio.play(correctSound)

        end

        BackToLevel1( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer(touch)
    userAnswer = wrongAnswerText1.text
    
    if (touch.phase == "ended") then

        if (soundOn == true) then

            incorrectSoundChannel = audio.play(incorrectSound)

        end

        BackToLevel1( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)
    userAnswer = wrongAnswerText2.text
    
    if (touch.phase == "ended") then

        if (soundOn == true) then

            incorrectSoundChannel = audio.play(incorrectSound)
        
        end

        BackToLevel1( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer3(touch)
    userAnswer = wrongAnswerText3.text
    
    if (touch.phase == "ended") then

        if (soundOn == true) then

            incorrectSoundChannel = audio.play(incorrectSound)

        end

        BackToLevel1( )
        
    end 
end


--adding the event listeners 
local function AddTextListeners()
    answerText:addEventListener( "touch", TouchListenerAnswer)
    wrongAnswerText1:addEventListener( "touch", TouchListenerWrongAnswer)
    wrongAnswerText2:addEventListener( "touch", TouchListenerWrongAnswer2)
    wrongAnswerText3:addEventListener( "touch", TouchListenerWrongAnswer3)
end

--removing the event listeners
local function RemoveTextListeners()
    answerText:removeEventListener( "touch", TouchListenerAnswer )
    wrongAnswerText1:removeEventListener( "touch", TouchListenerWrongAnswer)
    wrongAnswerText2:removeEventListener( "touch", TouchListenerWrongAnswer2)
    wrongAnswerText3:removeEventListener( "touch", TouchListenerWrongAnswer3)
end

local function DisplayQuestions()

    -- choose a random question number
    randomQuestionNum = math.random(1, 6)

    if (randomQuestionNum == 1) then

        -- create the question text
        questionText.text = "How many days\nare there in a year?"

        -- set answer
        answerText.text = "365"

        -- set wrong answers
        wrongAnswerText1.text = "235"
        wrongAnswerText2.text = "280"
        wrongAnswerText3.text = "400"

    elseif (randomQuestionNum == 2) then

        -- create the question text
        questionText.text = "How many weeks\nare there in a year?"

        -- set answer
        answerText.text = "52"

        -- set wrong answers
        wrongAnswerText1.text = "60"
        wrongAnswerText2.text = "45"
        wrongAnswerText3.text = "27"

    elseif (randomQuestionNum == 3) then

        -- create the question text
        questionText.text = "How many months are\nthere in a school year?"

        -- set answer
        answerText.text = "10"

        -- set wrong answers
        wrongAnswerText1.text = "7"
        wrongAnswerText2.text = "12"
        wrongAnswerText3.text = "9"

    elseif (randomQuestionNum == 4) then

        -- create the question text
        questionText.text = "How many letters are\nthere in the alphabet?"

        -- set answer
        answerText.text = "26"

        -- set wrong answers
        wrongAnswerText1.text = "27"
        wrongAnswerText2.text = "28"
        wrongAnswerText3.text = "29"

    elseif (randomQuestionNum == 5) then

        -- create the question text
        questionText.text = "How many minutes are\nthere in an hour?"

        -- set answer
        answerText.text = "60"

        -- set wrong answers
        wrongAnswerText1.text = "30"
        wrongAnswerText2.text = "15"
        wrongAnswerText3.text = "45"

    elseif (randomQuestionNum == 6) then

        -- create the question text
        questionText.text = "How many cents are\nthere in a dollar?"

        -- set answer
        answerText.text = "100"

        -- set wrong answers
        wrongAnswerText1.text = "150"
        wrongAnswerText2.text = "50"
        wrongAnswerText3.text = "200"

    end

end

local function PositionAnswers()

    --creating random start position in a cretain area
    answerPosition = math.random(1,4)

    if (answerPosition == 1) then

        answerText.x = X1
        answerText.y = Y1
        
        wrongAnswerText1.x = X1
        wrongAnswerText1.y = Y2
        
        wrongAnswerText2.x = X2
        wrongAnswerText2.y = Y1

        wrongAnswerText3.x = X2
        wrongAnswerText3.y = Y2

        
    elseif (answerPosition == 2) then

        answerText.x = X1
        answerText.y = Y2
            
        wrongAnswerText1.x = X2
        wrongAnswerText1.y = Y1
            
        wrongAnswerText2.x = X2
        wrongAnswerText2.y = Y2

        wrongAnswerText3.x = X1
        wrongAnswerText3.y = Y1


    elseif (answerPosition == 3) then

        answerText.x = X2
        answerText.y = Y1
            
        wrongAnswerText1.x = X2
        wrongAnswerText1.y = Y2
            
        wrongAnswerText2.x = X1
        wrongAnswerText2.y = Y1

        wrongAnswerText3.x = X1
        wrongAnswerText3.y = Y2

    elseif (answerPosition == 4) then

        answerText.x = X2
        answerText.y = Y2
            
        wrongAnswerText1.x = X1
        wrongAnswerText1.y = Y1
            
        wrongAnswerText2.x = X1
        wrongAnswerText2.y = Y2

        wrongAnswerText3.x = X2
        wrongAnswerText3.y = Y1
            
    end

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

    -- create the answer text object & wrong answer text objects
    answerText = display.newText("", X1, Y2, Arial, 75)
    answerText.anchorX = 0
    wrongAnswerText1 = display.newText("", X2, Y2, Arial, 75)
    wrongAnswerText1.anchorX = 0
    wrongAnswerText2 = display.newText("", X1, Y1, Arial, 75)
    wrongAnswerText2.anchorX = 0
    wrongAnswerText3 = display.newText("", X2, Y1, Arial, 75)
    wrongAnswerText3.anchorX = 0

    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert(answerText)
    sceneGroup:insert(wrongAnswerText1)
    sceneGroup:insert(wrongAnswerText2)
    sceneGroup:insert(wrongAnswerText3)


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
        DisplayQuestions()
        PositionAnswers()
        AddTextListeners()
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
        RemoveTextListeners()
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