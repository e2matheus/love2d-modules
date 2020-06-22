--[[
    Game modules

    -- Square Chain Class --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

    Features a chain of filled squares which will be drawn at different
    locations of the screen.
]]

-- The Square class, which stores the position and dimensions for the
-- square object and the logic for rendering it
require 'Square'

-- ColorMapper is a library that offers a way to apply colors to the
-- game independently of the current Love 2D version
if not clrMapper then
    clrMapper = require 'ColorMapper'
end

SquareChain = Class{}

function SquareChain:init(xPosition, yPosition, unitMeasurement, chainLength)
    self.squares = {}
    self.x = xPosition
    self.y = yPosition
    self.uom = unitMeasurement

    -- If a chain length was specified, use it to create that many square
    -- objects, and add them to the chain
    --
    -- Place the shapes from left to right
    if chainLength then
        squareX = self.x
        squareY = self.y
        for i = 1, chainLength do
            self:addSquare(squareX, squareY)
            squareX = squareX + self.uom
        end    
    end
end

function SquareChain:addSquare(xPosition, yPosition)
    table.insert(self.squares, Square(xPosition, yPosition, self.uom))
end

--[[
    Render the square chain, inside the grid, using each of its squares
    render method
]]
function SquareChain:render()
    totalSquares = #self.squares
    
    for i , square in pairs(self.squares) do
        -- Use 3 different colors to highlight the chain's head and tail
        if i == 1 then
            clrMapper:setColor(192, 192, 192, 255)
        elseif i ~= totalSquares then
            clrMapper:setColor(192, 192, 192, 200)
        else
            clrMapper:setColor(0, 192, 192, 180)
        end

        square:render()
    end
end
