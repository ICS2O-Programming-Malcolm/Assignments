-----------------------------------------------------------------------------------------
-- Title: DrawingShapesMalcolm
-- Name: Malcolm Cantin
-- Course: ICS2O
-- This program displays four shapes 
-----------------------------------------------------------------------------------------

-- Your code here

-- create my local variables
local myPentagon 
local myPentagonVertices = {50, -50, -80, -40, -70, 60, -20, 20, 80, 60} 
local myTriangle 
local myTriangleVertices = {-50, 60, 70, 30, -10, -40}
local myOctagon
local myOctagonVertices = {}
local myHexagon 
local myHexagonVertices = {}

-- set the background colour of my screen
display.setDefault("background", 155/255, 11/255, 11/255)

-- to remove status bar
display.setStatusBar(display.HiddenStatusBar)

-- PENTAGON
-- draw the pentagon that is in the top left of the screen
myPentagon = display.newPolygon(display.contentWidth/4, display.contentHeight/4, myPentagonVertices)

-- anchor the pentagon at the top left corner of the screen and set its (x,y) position
myPentagon.x = display.contentWidth/4
myPentagon.y = display.contentHeight/4

-- set the width of the border of the pentagon
myPentagon.strokeWidth = 15

-- set the colour of the pentagon
myPentagon:setFillColor(0.8, 0.1, 0.9)

-- set the colour of the border
myPentagon:setStrokeColor(0, 1, 1)

-- flip the pentagon
myPentagon:scale(1, -1)

-- TRIANGLE
-- draw the triangle that is in the top right of the screen
myTriangle = display.newPolygon(display.contentWidth/2, display.contentHeight/4, myTriangleVertices)

-- anchor the triangle at the top right corner of the screen
myTriangle.x = display.contentWidth/2
myTriangle.y = display.contentHeight/4

-- set the width of the border of the triangle
myTriangle.strokeWidth = 15

-- set the colour of the triangle
myTriangle:setFillColor(0.3, 0.7, 0.6)

-- set the colour of the border if the triangle
myTriangle:setStrokeColor(2, 5, 1)

-- flip the triangle
myTriangle:scale(1, -1)