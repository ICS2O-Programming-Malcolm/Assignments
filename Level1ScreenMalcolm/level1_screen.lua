-----------------------------------------------------------------------------------------
-- level1_screen.lua
-- Created by: Malcolm Cantin
-- Credit: Many components were taken from the SimplePlatformGame and from the MathQuiz
-- Course: ICS2O Programming
-- Date: June 10, 2020
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- Load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- CONSTANTS
-----------------------------------------------------------------------------------------

-- Constants for movement speed with arrow keys (NOT IN USE YET)
local UP_SPEED = -2
local DOWN_SPEED = 2
local LEFT_SPEED = -2
local RIGHT_SPEED = 2

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene

-- Variable for the background image
local bkg_image

-- Variables for the countdown timer
local TOTAL_SECONDS = 30
local secondsLeft = 30
local clockText
local countDownTimer

-- Variable for the jet
local jet

-- Variable for the evil ship
local evilShip

-- Variables for the missiles
local missile1
local missile2
local missile3
local theMissile

-- Variables for motion
local motionx = 0
local SPEED = 8
local LINEAR_VELOCITY = -100
local GRAVITY = 3

-- Variables for arrows that will be on the screen
local rArrow 
local uArrow
local lArrow

-- Variables for the boundaries
local leftW 
local rightW
local topW
local floor

-- Variable to check the number of questions answered
local questionsAnswered = 0

-- Variable for the pause button
local pauseButton

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------

local level1Music = audio.loadSound("Sounds/level1Music.mp3")
local level1MusicChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Transition to the lose screen
local function YouLoseTransition()
    composer.gotoScene( "you_lose" )
end

-- Transition to the win screen
local function YouWinTransition()
    composer.gotoScene( "you_win" )
end

-- When right arrow is touched, move jet right
local function right (touch)
    motionx = SPEED
    jet.xScale = 1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    if (jet ~= nil) then
        jet:setLinearVelocity( 0, LINEAR_VELOCITY )
    end
end

-- When left arrow is touched, move jet left
local function left (touch)
    motionx = -SPEED
    jet.xScale = -1
end

-- Move jet horizontally
local function moveJet (event)
    jet.x = jet.x + motionx
end
 
-- Stop jet movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
    end
end

-- This function adds the arrow event listeners
local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
end

-- This function removes the arrow event listeners
local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)

end

-- This function add the runtime listeners
local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", moveJet)
    Runtime:addEventListener("touch", stop )
end

-- This function removes the runtime listeners
local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", moveJet)
    Runtime:removeEventListener("touch", stop )
end

-- This function replaces the jet
local function ReplaceJet()
    
    -- create the image of the jet
    jet = display.newImage("Images/jet.png")
    jet.x = 75
    jet.y = display.contentHeight/2 + 50
    jet.myName = "Jet"

    -- intialize horizontal movement of jet
    motionx = 0

    -- add physics body
    physics.addBody( jet, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- prevent jet from being able to tip over
    jet.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

local function MakeMissilesVisible()
    missile1.isVisible = true
    missile2.isVisible = true
    missile3.isVisible = true
end

-- This function check if the jet has collided with any of the things in the scene
local function onCollision(self, event)

    if ( event.phase == "began" ) then

        if  (event.target.myName == "missile1") or
            (event.target.myName == "missile2") or
            (event.target.myName == "missile3") then

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            jet.isVisible = false

            -- store the event.target in the variable theMissile
            theMissile = event.target

            -- set the gravity
            physics.setGravity(0, 0)

            -- show overlay with math question
            composer.showOverlay( "level1_question", { isModal = true, effect = "crossFade", time = 100})

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1

        end  
        
        if (event.target.myName == "evilShip") then

            --check to see if the user has answered 3 questions
            if (questionsAnswered == 3) then

                -- after getting 3 questions right, stop the timer and go to the you win screen 

                timer.cancel(countDownTimer)
                clockText.isVisible = false

                composer.gotoScene( "you_win" )

            end
        end

    end

end

-- This function will add all the collision listeners
local function AddCollisionListeners()

    -- if character collides with a missile, onCollision will be called    
    missile1.collision = onCollision
    missile1:addEventListener( "collision" )
    missile2.collision = onCollision
    missile2:addEventListener( "collision" )
    missile3.collision = onCollision
    missile3:addEventListener( "collision" )

    evilShip.collision = onCollision
    evilShip:addEventListener( "collision" )

end

-- This function will remove all the collision listeners
local function RemoveCollisionListeners()

    missile1:removeEventListener( "collision" )
    missile2:removeEventListener( "collision" )
    missile3:removeEventListener( "collision" )

    evilShip:removeEventListener( "collision" )

end

-- This function will add all the physics bodies
local function AddPhysicsBodies()

    --add to the physics engine
    physics.addBody(missile1, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(missile2, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(missile3, "static",  {density=0, friction=0, bounce=0} )

    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody(evilShip, "static", {density=1, friction=0.3, bounce=0.2})

end

-- This function will remove all the physics bodies
local function RemovePhysicsBodies()

    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)
    physics.removeBody(floor)

end

-- This function will remove missile bodies if they still exist on the screen
local function RemoveMissilePhysicsBodies()

    if (missile1.isBodyActive == true) then

        physics.removeBody(missile1)

    end

    if (missile2.isBodyActive == true) then

        physics.removeBody(missile2)

    end

    if (missile3.isBodyActive == true) then

        physics.removeBody(missile3)

    end

end

-- This function updates the time remaining
local function UpdateTime()

	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = secondsLeft

    -- if the time runs out, get rid of the time and go to the lose screen
    if (secondsLeft == 0) then
        
        timer.cancel(countDownTimer)

        clockText.isVisible = false

        YouLoseTransition()

    end
    
end

-- This function calls the timer
local function StartTimer()

    -- initialize timer
    secondsLeft = TOTAL_SECONDS

    -- maker timer visible
    clockText.isVisible = true

	-- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
        
end

-- This is the transition to the pause menu
local function PauseScreenTransition()

    -- make the jet invisible
    jet.isVisible = false 

    -- remove physics body
    physics.removeBody(jet)

    -- pause the timer
    timer.pause(countDownTimer)

    -- pause the audio
    audio.pause(level1MusicChannel)

    -- show pause screen overlay
    composer.showOverlay("pause_screen", { isModal = true, effect = "crossFade", time = 100})

end

-- This function is meant to allow the use of arrow keys but is not in use at the moment
local function MoveUp(event)

    if (event.keyName == "up") then

        jet.y = jet.y + UP_SPEED

    end

end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- This function will resume the game
function ResumeGameFromQuestion() 

    -- make jet visible again
    jet.isVisible = true

    -- set gravity
    physics.setGravity(0, GRAVITY)
    
    if (questionsAnswered > 0) then
        if (theMissile ~= nil) and (theMissile.isBodyActive == true) then
            theMissile.isVisible = false
            physics.removeBody(theMissile)
        end
    end

end

-- This function will resume the game
function ResumeGameFromPause() 

    -- make jet visible again
    jet.isVisible = true

    -- add physics body
    physics.addBody( jet, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- resume the timer
    timer.resume(countDownTimer)

    -- resume the music
    audio.resume(level1MusicChannel)

end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/level1_screen.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    

    -- display the number of seconds remaining
    clockText = display.newText(secondsLeft, 60, 45, nil, 75)
    clockText:setTextColor(0/255, 102/255, 0/255)
    clockText.isVisible = true

    -- Associating display objects with this scene 
    sceneGroup:insert( clockText )

    -- Insert the image of the evil ship
    evilShip = display.newImage("Images/evilShip.png")
    evilShip.x = display.contentWidth
    evilShip.y = display.contentHeight/2 - 40
    evilShip.myName = "evilShip"

    -- Associating display objects with this scene 
    sceneGroup:insert( evilShip )

    -- Insert the image of missile #1
    missile1 = display.newImage("Images/missile.png")
    missile1.x = display.contentWidth*2/3 - 70
    missile1.y = 80
    missile1.isVisible = true
    missile1.myName = "missile1"

    -- Associating display objects with this scene 
    sceneGroup:insert( missile1 )

    -- Insert the image of missile #2
    missile2 = display.newImage("Images/missile.png")
    missile2.x = display.contentWidth*1/3
    missile2.y = display.contentHeight - 80
    missile2.isVisible = true
    missile2.myName = "missile2"

    -- Associating display objects with this scene 
    sceneGroup:insert( missile2 )

    -- Insert the image of missile #3
    missile3 = display.newImage("Images/missile.png")
    missile3.x = display.contentWidth*3/4 + 90
    missile3.y = display.contentHeight*2/3 + 75
    missile3.isVisible = true
    missile3.myName = "missile3"

    -- Associating display objects with this scene 
    sceneGroup:insert( missile3 )

    --Insert the right arrow
    rArrow = display.newImageRect("Images/RightArrowUnpressed.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rArrow)

    --Insert the left arrow
    uArrow = display.newImageRect("Images/UpArrowUnpressed.png", 50, 100)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8.5 / 10

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( uArrow)

    --Insert the left arrow
    lArrow = display.newImageRect("Images/LeftArrowUnpressed.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.y = display.contentHeight * 9.5 / 10
       
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( lArrow)

    --WALLS--
    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( leftW )

    rightW = display.newLine( 0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rightW )

    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.y = 0
    topW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topW )

    floor = display.newLine( 0, display.contentHeight, display.contentWidth, display.contentHeight)
    floor.x = 0
    floor.y = display.contentHeight * 1

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( floor )

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Pause Button
    pauseButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = 950,
            y = 60,

            width = 70,
            height = 70,

            -- Insert the images here
            defaultFile = "Images/Pause Button Unpressed.png",
            overFile = "Images/Pause Button Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = PauseScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( pauseButton )

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
        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity(0, GRAVITY)

        -- Start the timer
        StartTimer()


    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        -- If the sound has not been muted, play the level 1 music
        if (soundOn == true) then

            -- play level 1 music
            level1MusicChannel = audio.play(level1Music)
            
        end

        -- Initialize questionsAnswered to 0
        questionsAnswered = 0

        -- create the jet, add physics bodies and runtime listeners
        ReplaceJet()

        -- make missiles visible
        MakeMissilesVisible()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- Runtime:addEventListener("up", MoveUp)

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

        -- If the sound has not been muted, stop the audio
        if (soundOn == true) then

            -- stop level 1 music
            audio.pause(level1MusicChannel)
            
        end

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

        -- Remove collision and physics functionality
        RemoveCollisionListeners()

        RemovePhysicsBodies()

        RemoveMissilePhysicsBodies()

        physics.stop()

        -- remove runtime listeners that move the jet
        RemoveArrowEventListeners()

        RemoveRuntimeListeners()

        -- remove jet
        display.remove(jet)

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
