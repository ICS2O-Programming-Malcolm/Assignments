-----------------------------------------------------------------------------------------
-- Title: MathQuizMalcolm
-- Name: Malcolm Cantin
-- Course: ICS2O
-- This program 
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar) 

-- sets the background colour
display.setDefault("background", 0/255, 0/255, 204/255)

------------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
------------------------------------------------------------------------------------------------

-- create local variables
local randomOperator

local questionObject
local correctObject
local incorrectObject

local numericField

local randomNumber1
local randomNumber2

local userAnswer
local tempAnswer
local correctAnswer
local correctAnswerText
local incorrectAnswer

local points = 0
local wrongs = 0

-- variables for the timer
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer

-- variables for the heart
local lives = 4
local heart1
local heart2

local stopGame = false

------------------------------------------------------------------------------------------------
-- SOUNDS
------------------------------------------------------------------------------------------------

-- Correct sound
local correctSound = audio.loadSound("Sounds/Correct Answer Sound Effect.mp3")
local correctSoundChannel

-- Incorrect sound
local incorrectSound = audio.loadSound("Sounds/Wrong Buzzer Sound Effect.mp3")
local incorrectSoundChannel

-- Game Over sound
local gameOverSound = audio.loadSound("Sounds/GameOver.mp3")
local gameOverSoundChannel

-- Background music
local backgroundSound = audio.loadSound("Sounds/The Price Is Right.mp3")
local backgroundSoundChannel

-- Play the background music when the game begins
backgroundSoundChannel = audio.play(backgroundSound)

------------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
------------------------------------------------------------------------------------------------

local function AskQuestion()
    -- generate a random number between 1 and 4
    randomOperator = math.random(1, 4)
    
    -- if the random operator is 1, then do addition
    if (randomOperator == 1) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(0, 20)
        randomNumber2 = math.random(0, 20)

        -- calculate the correct answer
        correctAnswer = randomNumber1 + randomNumber2

        -- create question in text object
        questionObject.text = "What does " .. randomNumber1 .. " + " .. randomNumber2 .. " = "
    
    -- otherwise, if the random operator is 2, do subtraction
    elseif (randomOperator == 2) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(0, 20)
        randomNumber2 = math.random(0, 20)        

        
        if (randomNumber2 > randomNumber1) then
        
            -- calculate answer with numbers flipped
            correctAnswer = randomNumber2 - randomNumber1

            -- create question in text object
            questionObject.text = "What does " .. randomNumber2 .. " - " .. randomNumber1 .. " = "

        else 

	        -- calculate the correct answer
	        correctAnswer = randomNumber1 - randomNumber2

	        -- create question in text object
            questionObject.text = "What does " .. randomNumber1 .. " - " .. randomNumber2 .. " = "

        end

    -- otherwise, if the random operator is 3, do multiplication
    elseif (randomOperator == 3) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(0, 10)
        randomNumber2 = math.random(0, 10) 

        -- calculate the correct answer
        correctAnswer = randomNumber1*randomNumber2

        -- create question in text object
        questionObject.text = "What does " .. randomNumber1 .. " * " .. randomNumber2 .. " = "

     -- otherwise, if the random operator is 4, do division
    elseif (randomOperator == 4) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(0, 100)
        randomNumber2 = math.random(0, 100) 

        -- calculate the correct answer
        tempAnswer = randomNumber1*randomNumber2

        randomNumber1 = tempAnswer

        correctAnswer = randomNumber1/randomNumber2

        -- create question in text object
        questionObject.text = "What does " .. randomNumber1 .. " / " .. randomNumber2 .. " = "

    end

end

local function LoseLives()

	incorrectSoundChannel = audio.play(incorrectSound)

	lives = lives - 1

	secondsLeft = totalSeconds

	if (lives == 3) then
        heart3.isVisible = false
	elseif (lives == 2) then
        heart2.isVisible = false
	elseif (lives == 1) then
		heart1.isVisible = false
		gameOverSoundChannel = audio.play(gameOverSound)
		gameOverObject.isVisible = true
		timer.cancel(countDownTimer)
		clockText.isVisible = false
		stopGame = true
        backgroundSound = audio.stop(backgroundSoundChannel)
        numericField.isVisible = false
        questionObject.isVisible = false
	end
end

local function HideCorrectAnswerText()

    correctAnswerText.isVisible = false
    
end

-- function that updates the time remaining
local function UpdateTime()

	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = secondsLeft .. ""

    if (secondsLeft == 0) then

        correctAnswerText = display.newText( "The correct answer is " .. correctAnswer, display.contentWidth/2, display.contentHeight*(4/5), nil, 50)
        correctAnswerText.isVisible = true

        timer.performWithDelay(2000, HideCorrectAnswerText)

        LoseLives()
        
        AskQuestion()
        
    end
    
end

-- function that calls the timer
local function StartTimer()

	-- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
        
end

local function HideCorrect()

    correctObject.isVisible = false
    
    if (stopGame == false) then
        
        AskQuestion()
    
    end
 
end

local function HideIncorrect()

    incorrectObject.isVisible = false
    
    if (stopGame == false) then
        
        AskQuestion()
    
    end
    
end

local function NumericFieldListener(event)

	-- user begins editing "numericField"
	if ( event.phase == "began" ) then

		-- clear text field
		event.target.text = ""

	elseif event.phase == "submitted" then

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- if the user's answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
		
			-- give a point if the user gets the correct answer, display "Correct!", and play a correct answer sound
            points = points + 1
            
            correctObject.isVisible = true
            
            correctSoundChannel = audio.play(correctSound)
            
			secondsLeft = totalSeconds

			-- update it in the display object
			pointsText.text = "Points = " .. points

			-- perform HideCorrect with a delay and clear the text field
            timer.performWithDelay(1500, HideCorrect)
            
            --clear the text field
			event.target.text = ""

		else

			-- display "Incorrect!", show the right answer, and subtract one life
            incorrectObject.isVisible = true
            
            timer.performWithDelay(2000, HideIncorrect)

            correctAnswerText = display.newText( "The correct answer is " .. correctAnswer, display.contentWidth/2, display.contentHeight*(4/5), nil, 50)
            correctAnswerText.isVisible = true
    
            timer.performWithDelay(2000, HideCorrectAnswerText)
            
            -- clear the text field
            event.target.text = ""
            
			LoseLives()

			-- play incorrect answer sound
            incorrectSoundChannel = audio.play(incorrectSound)
            
        end	
        
    end
    
end

------------------------------------------------------------------------------------------------
-- OBJECT CREATION
------------------------------------------------------------------------------------------------

-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentWidth * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentWidth * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentWidth * 1 / 7

-- display the amount of points as a text object
pointsText = display.newText("Points = " .. points, display.contentWidth*(1/4), display.contentHeight*(1/5), nil, 50)
pointsText:setTextColor(255/255, 255/255, 255/255)

-- display the number of seconds remaining
clockText = display.newText( secondsLeft .. "", display.contentWidth*(5/6), display.contentHeight*(6/7), nil, 150)
clockText:setTextColor(0/255, 255/255, 0/255)
clockText.isVisible = true

-- displays a question and sets the colour
questionObject = display.newText("", display.contentWidth/2 - 100, display.contentHeight/2, nil, 75)
questionObject:setTextColor(155/255, 42/255, 198/255)
questionObject.isVisible = true

-- create the correct text object and make it invisible
correctObject = display.newText("Good Job!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(0/255, 0/255, 204/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText("Sorry, that's incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
incorrectObject:setTextColor(204/255, 0/255, 102/255)
incorrectObject.isVisible = false

-- create game over image
gameOverObject = display.newImageRect("Images/gameOver.png", 500, 500)
gameOverObject.x = display.contentWidth * 1 / 2
gameOverObject.y = display.contentWidth * 1 / 2 - 75
gameOverObject.isVisible = false

-- create numeric field
numericField = native.newTextField(display.contentWidth*(7/8) - 75, display.contentHeight/2, 150, 100)
numericField.inputType = "number"
numericField.isVisible = true

-- add the event listeners for the numeric field
numericField:addEventListener("userInput", NumericFieldListener)

------------------------------------------------------------------------------------------------
-- FUNCTION CALLS
------------------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()

-- update the timer
StartTimer()