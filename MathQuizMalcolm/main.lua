-----------------------------------------------------------------------------------------
-- Title: MathQuizMalcolm
-- Name: Malcolm Cantin
-- Course: ICS2O
-- This program is a math game that has a variety of math questions that can be asked 
-- to the user, to which the user can input an answer. If the user gets 5 correct 
-- answers, they win the game. If they lose 3 lives, they will lose the game. Also, this 
-- program has a timer that gives the user only 10 seconds to answer each question. If 
-- the time runs out, the user will also lose a life. 
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar) 

-- set the background colour
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
local counter

local points = 0

local amountSpun = 1080

-- variables for the timer
local TOTAL_SECONDS = 10
local secondsLeft = 10
local clockText
local countDownTimer

-- variables for the heart
local lives = 4
local heart1
local heart2
local heart3

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

-- You Win sound
local youWinSound = audio.loadSound("Sounds/you_win.mp3")
local youWinSoundChannel

-- Background music
local backgroundSound = audio.loadSound("Sounds/The Price is Right.mp3")
local backgroundSoundChannel

-- Play the background music when the game begins
backgroundSoundChannel = audio.play(backgroundSound)

------------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
------------------------------------------------------------------------------------------------
-- This function generates a math question which the user will be asked and required to input 
-- an answer
local function AskQuestion()

    -- generate a random number between 1 and 7 which will decide what operator to do
    randomOperator = math.random(1, 7)
    
    -- if the random operator is 1, then do addition
    if (randomOperator == 1) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(1, 20)
        randomNumber2 = math.random(1, 20)

        -- calculate the correct answer
        correctAnswer = randomNumber1 + randomNumber2

        -- create question in text object
        questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
    
    -- otherwise, if the random operator is 2, do subtraction
    elseif (randomOperator == 2) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(1, 20)
        randomNumber2 = math.random(1, 20)        

        -- to ensure we get no negative answers:
        if (randomNumber2 > randomNumber1) then
        
            -- calculate answer with numbers flipped
            correctAnswer = randomNumber2 - randomNumber1

            -- create question in text object
            questionObject.text = randomNumber2 .. " - " .. randomNumber1 .. " = "

        else 

	        -- calculate the correct answer
	        correctAnswer = randomNumber1 - randomNumber2

	        -- create question in text object
            questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

        end

    -- otherwise, if the random operator is 3, do multiplication
    elseif (randomOperator == 3) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(1, 10)
        randomNumber2 = math.random(1, 10) 

        -- calculate the correct answer
        correctAnswer = randomNumber1*randomNumber2

        -- create question in text object
        questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

     -- otherwise, if the random operator is 4, do division
    elseif (randomOperator == 4) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(1, 10)
        randomNumber2 = math.random(1, 10) 

        -- calculate the correct answer
        tempAnswer = randomNumber1*randomNumber2

        randomNumber1 = tempAnswer

        correctAnswer = randomNumber1/randomNumber2

        -- create question in text object
        questionObject.text = randomNumber1 .. " / " .. randomNumber2 .. " = "

    elseif (randomOperator == 5) then

        -- generate a random number between a max. and a min. number
        randomNumber1 = math.random(1, 6)
        
        -- intializations
        correctAnswer = 1
        counter = 1

        -- calculate the correct answer
        while (counter <= randomNumber1) do

            correctAnswer = correctAnswer * counter
            
            counter = counter + 1

        end

        -- create question in text object
        questionObject.text = randomNumber1 .. "! = "

    elseif (randomOperator == 6) then

        -- generate 2 random numbers between a max. and a min. number
        randomNumber1 = math.random(1, 6)
        randomNumber2 = math.random(1, 5)

        -- intializations
        correctAnswer = 1
        counter = 1
        
        -- calculate the correct answer
        while (counter <= randomNumber2) do

            correctAnswer = correctAnswer * randomNumber1

            counter = counter + 1

        end

        -- create question in text object
        questionObject.text = randomNumber1 .. " ^ " .. randomNumber2 .. " = "

    elseif (randomOperator == 7) then

        -- generate a random number between a max. and a min. number
        randomNumber1 = math.random(1, 10)

        -- calculate the correct answer
        randomNumber1 = randomNumber1 * randomNumber1

        correctAnswer = math.sqrt(randomNumber1)

        -- create question in text object
        questionObject.text = "√" .. randomNumber1 .. " = "

    end

end

-- This function is used after a question was answered wrong or the time runs out, and it 
-- updates the number of lives remaining
local function LoseLives()

    -- play incorrect sound
    incorrectSoundChannel = audio.play(incorrectSound)
    
    -- subtract a life
    lives = lives - 1
    
    -- reset the number of seconds
	secondsLeft = TOTAL_SECONDS

    if (lives == 3) then
        
        -- make heart 3 invisible
        heart3.isVisible = false

    elseif (lives == 2) then
        
        -- make heart 2 invisible
        heart2.isVisible = false

    elseif (lives == 1) then
        
        -- make heart 1 invisible
        heart1.isVisible = false

        -- stop the game from doing AskQuestion()
        stopGame = true

        -- get rid of the timer
        timer.cancel(countDownTimer)
        clockText.isVisible = false

        -- make the quesion text invisible
        questionObject.isVisible = false

        -- display the game over image
        gameOverObject.isVisible = true

        -- stop the background music
        backgroundSound = audio.stop(backgroundSoundChannel)

        -- play the game over music
        gameOverSoundChannel = audio.play(gameOverSound)

        -- make the numeric field invisible
        numericField.isVisible = false

    end
    
end

-- This function hides the correct answer text 
local function HideCorrectAnswerText()

    correctAnswerText.isVisible = false
    
end

-- This function updates the time remaining
local function UpdateTime()

	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = "Time Remaining: " .. secondsLeft .. ""

    if (secondsLeft == 0) then

		-- play incorrect answer sound
        incorrectSoundChannel = audio.play(incorrectSound)

        -- show the correct answer
        correctAnswerText = display.newText( "The correct answer is " .. correctAnswer, display.contentWidth/2, display.contentHeight*(4/5) - 60, nil, 50)
        correctAnswerText:setTextColor(204/255, 204/255, 0/255)
        correctAnswerText.isVisible = true

        timer.performWithDelay(2000, HideCorrectAnswerText)

        LoseLives()
        
        -- if the game has not been stopped, call AskQuestion()
        if (stopGame == false) then
        
            AskQuestion()
        
        end
        
    end
    
end

-- This function calls the timer
local function StartTimer()

	-- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
        
end

-- This function hides the "Good Job!" text
local function HideCorrect()

    correctObject.isVisible = false
    
    AskQuestion()
 
end

-- This function hides the "Sorry that's incorrect!" text
local function HideIncorrect()

    incorrectObject.isVisible = false
    
    -- if the game has not been stopped, call AskQuestion()
    if (stopGame == false) then
        
        AskQuestion()
    
    end
    
end

local function SpinYouWin()

    if (amountSpun < 1080) then

        -- make the You Win image spin
        youWinObject:rotate(5)

        amountSpun = amountSpun + 5

    end

end

-- This function controls the numeric field that a user can input answers into
local function NumericFieldListener(event)

	-- user begins editing "numericField"
	if (event.phase == "began") then

		-- clear text field
		event.target.text = ""

	elseif (event.phase == "submitted") then

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- if the user's answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
		
			-- give a point
            points = points + 1

            -- display "Correct!"
            correctObject.isVisible = true

            -- play a correct answer sound
            correctSoundChannel = audio.play(correctSound)
            
            -- reset the number of seconds on the timer
			secondsLeft = TOTAL_SECONDS

			-- update it in the display object
			pointsText.text = "Number Correct = " .. points

			-- perform HideCorrect with a delay and clear the text field
            timer.performWithDelay(1500, HideCorrect)
            
            --clear the text field
            event.target.text = ""
            
            -- if the user reaches 5 points, they win
            if (points == 5) then

                -- stop the game from doing AskQuestion()
                stopGame = true

                -- get rid of the timer
                timer.cancel(countDownTimer)
                clockText.isVisible = false
                
                -- make the quesion text invisible 
                questionObject.isVisible = false
                
                -- display the you win image and call the function to make the image spin
                youWinObject.isVisible = true

                -- image animation for You Win
                amountSpun = 0
                SpinYouWin()
                
                -- stop the background music
                backgroundSound = audio.stop(backgroundSoundChannel)

                -- play the you win music
                youWinSoundChannel = audio.play(youWinSound)
                
                -- make the numeric field invisible
                numericField.isVisible = false

            end

		else

			-- display "Incorrect!" for 2 seconds
            incorrectObject.isVisible = true
            timer.performWithDelay(2000, HideIncorrect)

            -- tell the user the correct answer for 2 seconds
            correctAnswerText = display.newText( "The correct answer is " .. correctAnswer, display.contentWidth/2, display.contentHeight*(4/5) - 35, nil, 50)
            correctAnswerText:setTextColor(204/255, 204/255, 0/255)
            correctAnswerText.isVisible = true
            timer.performWithDelay(2000, HideCorrectAnswerText)
            
            -- clear the text field
            event.target.text = ""
            
            -- call the LoseLives() function to update the number of lives remaining
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
heart1.y = display.contentWidth * 1 / 7 + 25

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentWidth * 1 / 7 + 25

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentWidth * 1 / 7 + 25

-- display the amount of points as a text object
pointsText = display.newText("Number Correct = " .. points, display.contentWidth*(1/4) + 35, display.contentHeight*(1/5) - 100, nil, 60)
pointsText:setTextColor(255/255, 128/255, 0/255)

-- display the number of seconds remaining
clockText = display.newText("Time Remaining: " .. secondsLeft .. "", display.contentWidth*(2/3) - 30, display.contentHeight - 85, nil, 75)
clockText:setTextColor(0/255, 255/255, 0/255)
clockText.isVisible = true

-- displays a question and sets the colour
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 75)
questionObject:setTextColor(155/255, 42/255, 198/255)
questionObject.isVisible = true

-- create the correct text object and make it invisible
correctObject = display.newText("Good Job!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(0/255, 204/255, 204/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText("Sorry, that's incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
incorrectObject:setTextColor(204/255, 0/255, 102/255)
incorrectObject.isVisible = false

-- create game over image
gameOverObject = display.newImage("Images/gameOver.jpg")
gameOverObject.x = display.contentWidth * 1 / 2
gameOverObject.y = display.contentWidth * 1 / 2 - 155
gameOverObject:scale(2, 2)
gameOverObject.isVisible = false

-- create you win image
youWinObject = display.newImage("Images/you_win.jpg")
youWinObject.x = display.contentWidth * 1 / 2
youWinObject.y = display.contentWidth * 1 / 2 - 75
youWinObject:scale(2, 2)
youWinObject.isVisible = false

-- create numeric field
numericField = native.newTextField(display.contentWidth/2 + 150, display.contentHeight/2, 300, 100)
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

Runtime:addEventListener("enterFrame", SpinYouWin)