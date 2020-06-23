-----------------------------------------------------------------------------------------
-- main.lua
-- Title: Level1ScreenMalcolm
-- Created by: Malcolm Cantin
-- Course: ICS2O Programming
-- Date: June 10, 2020
-- Description: This calls the splash screen of the app to load itself.
-----------------------------------------------------------------------------------------

-- Hiding Status Bar
display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Go to the intro screen
composer.gotoScene( "main_menu" )
