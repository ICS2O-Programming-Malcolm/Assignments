-----------------------------------------------------------------------------------------
-- Title: DrawingShapesMalcolm
-- Name: Malcolm Cantin
-- Course: ICS2O
-- This program displays four shapes 
-----------------------------------------------------------------------------------------

-- Your code here

-- create my local variables
local myPentagon 
local myPentagonVertices = {-70, 60, -20, 20, 80, -60, 50, -50, -80, -40}
local myTriangle 
local myOctagon 
local myHexagon 

-- set the background colour of my screen
display.setDefault("background", 1/255, 11/255, 11/255)

-- to remove status bar
display.setStatusBar(display.HiddenStatusBar)

-- draw the pentagon that is in the top left of the screen
myPentagon = display.newPolygon(display.contentWidth/4, display.contentHeight/4, myPentagonVertices)