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
local myPentagonText 
local myTriangle 
local myTriangleVertices = {-50, 60, 70, 30, -10, -40}
local myTriangleText
local myOctagon
local myOctagonVertices = {-20, 60, 20, 60, 60, 20, 60, -20, 20, -60, -20, -60, -60, -20, -60, 20}
local myOctagonText
local myHexagon 
local myHexagonVertices = {-80, 50, 0, 50, 60, 0, -10, -70, -30, 10, -60, -40}
local myHexagonText

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

-- label the pentagon
myPentagonText = display.newText("Pentagon", myPentagon.x, myPentagon.y - 100, Arial, 50) 

-- TRIANGLE
-- draw the triangle that is in the top right of the screen
myTriangle = display.newPolygon(display.contentWidth*(3/4), display.contentHeight/4, myTriangleVertices)

-- anchor the triangle at the top right corner of the screen
myTriangle.x = display.contentWidth*(3/4)
myTriangle.y = display.contentHeight/4

-- set the width of the border of the triangle
myTriangle.strokeWidth = 15

-- set the colour of the triangle
myTriangle:setFillColor(0.3, 0.7, 0.6)

-- set the colour of the border if the triangle
myTriangle:setStrokeColor(1, 0.5, 0)

-- flip the triangle
myTriangle:scale(1, -1)

-- label the triangle
myTriangleText = display.newText("Triangle", myTriangle.x, myTriangle.y - 100, Arial, 50) 

-- OCTAGON
-- draw the octagon that is in the bottom left of the screen
myOctagon = display.newPolygon(display.contentWidth/4, display.contentHeight*(3/4), myOctagonVertices)

-- anchor the octagon at the bottom left corner of the screen
myOctagon.x = display.contentWidth/4
myOctagon.y = display.contentHeight*(3/4)

-- set the width of the border of the octagon
myOctagon.strokeWidth = 15

-- set the colour of the octagon
myOctagon:setFillColor(0.7, 0.7, 0.7)

-- set the colour of the border if the octagon
myOctagon:setStrokeColor(0, 0, 1)

-- flip the octagon
myOctagon:scale(1, -1)

-- label the octagon
myOctagonText = display.newText("Octagon", myOctagon.x, myOctagon.y - 100, Arial, 50) 

-- HEXAGON
-- draw the hexagon that is in the bottom right of the screen
myHexagon = display.newPolygon(display.contentWidth*(3/4), display.contentHeight*(3/4), myHexagonVertices)

-- anchor the hexagon at the top bottom right of the screen and set its (x,y) position
myHexagon.x = display.contentWidth*(3/4)
myHexagon.y = display.contentHeight*(3/4)

-- set the width of the border of the hexagon
myHexagon.strokeWidth = 15

-- set the colour of the hexagon
myHexagon:setFillColor(0.2, 0.2, 0.5)

-- set the colour of the border
myHexagon:setStrokeColor(0, 1, 0)

-- flip the hexagon
myHexagon:scale(1, -1)

-- label the hexagon
myHexagonText = display.newText("Hexagon", myHexagon.x, myHexagon.y - 100, Arial, 50) 