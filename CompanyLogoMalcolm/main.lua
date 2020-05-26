-----------------------------------------------------------------------------------------
--
-- main.lua
-- Title: SampleVideoGame
-- Created by: Malcolm Cantin
-- Course: ICS2O
-- Date: May 25, 2020
-- Description: This calls the splash screen of the app to load itself.
-----------------------------------------------------------------------------------------

-- Hiding Status Bar
display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Go to the intro screen
composer.gotoScene( "splash_screen" )
