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
            self:addSquare(Square(squareX, squareY, self.uom))
            squareX = squareX + self.uom
        end
    -- If it was not specified, add a single square to the chain
    else
        self:addSquare(Square(self.x, self.y, self.uom))
    end

    -- Initialize movement values
    self.headDirX = 0
    self.headDirY = 0
    self.speed = 1
    self.secPerUpdate = 0
    self.timeSinceUpdate = 0
    self.bodyFollowsHead = false

    for i , square in pairs(self.squares) do
        square.speed = self.speed
        square.dirX = 0
        square.dirY = 0
    end

    -- Initialize growth flag
    self.growing = false
end

--[[
    Inserts a square before the element currently at a given position of
    the chain.

    If it's called without a position, it inserts the square in the last
    position of the chain (moves no elements).

    Sets the square's speed as the speed of the chain.
]]
function SquareChain:addSquare(newSquare, position)
    if not position then
        table.insert(self.squares, newSquare)
        self.squares[#self.squares].speed = self.speed
    else
        table.insert(self.squares, position, newSquare)
        self.squares[position].speed = self.speed
    end
end

function SquareChain:setSpeed(chainSpeed)
    self.speed = chainSpeed

    for i , square in pairs(self.squares) do
        square.speed = self.speed
    end
end

function SquareChain:setDirection(dirX, dirY, updateEntireChain)
    self.headDirX = dirX
    self.headDirY = dirY
    
    if updateEntireChain then
        for i , square in pairs(self.squares) do
            square:setDirection(self.headDirX, self.headDirY)
        end
    else
        self.squares[1]:setDirection(self.headDirX, self.headDirY)
    end
end

function SquareChain:setGrowing(growing)
    self.growing = growing
end

--[[
    Updates the current position when the specified seconds have passed,
    and set the update timer to the remainder of the overhead.

    It only modifies the body to follow the head's trajectory if the
    number of squares is greater than 1, and the follow flag is set to
    true. If that condition is not met, the position of every element of
    the chain is updated according to its respective direction; unless
    the structure has a single square and the growth flag was set to
    true, in which case the chain's size is increased by 1, once.
]]
function SquareChain:move(dt)
    self.timeSinceUpdate = self.timeSinceUpdate + dt

    if self.timeSinceUpdate > self.secPerUpdate then

        totalSquares = #self.squares

        if self.bodyFollowsHead and totalSquares > 1 then
            -- Increase the chain size by 1
            self:duplicateHead()
            -- Remove the previous square off the list, if the chain is
            -- not growing
            if not self.growing then
                table.remove(self.squares, #self.squares)
            end
            -- Set the growth flag back to false, so that the chain
            -- doesn't grow indefinitely
            self.growing = false
        else
            -- If the chain has a single square and the growth flag was
            -- set to true, increase the structure size by 1 and set the
            -- flag back to false
            if totalSquares == 1 and self.growing then
                self:duplicateHead()

                -- Set the growth flag back to false, so prevent the
                -- chain from growing indefinitely
                self.growing = false
            else
                -- Update the position of every item on the list
                for i , square in pairs(self.squares) do
                    square:updatePosition()
                end
            end
        end

        self.timeSinceUpdate = self.timeSinceUpdate % self.secPerUpdate
    end
end

--[[
    Duplicates the chain's head to increase the structure size by 1.
]]
function SquareChain:duplicateHead()
    -- Make copy of the head
    previousHead = self.squares[1]
    newHead = Square(previousHead.x, previousHead.y, self.uom)
    newHead.speed = self.speed
    -- Set copy's direction in the head's direction
    newHead:setDirection(self.headDirX, self.headDirY)
    -- Update the new head position
    newHead:updatePosition()
    -- Set the head's direction to the previous head's direction
    self.squares[1]:setDirection(self.headDirX, self.headDirY)
    -- Place the new head at the start of the list
    self:addSquare(newHead, 1) 
end

--[[
    Renders the square chain, inside the grid, using each of its squares
    render method.
]]
function SquareChain:render()
    totalSquares = #self.squares
    
    for i , square in pairs(self.squares) do
        -- Use 3 different colors to highlight the chain's head and tail
        if i == 1 then
            -- Display visual feedback when the chain is growing
            if not self.growing then
                clrMapper:setColor(192, 192, 192, 255)
            else
                clrMapper:setColor(64, 255, 255, 255)
            end
        elseif i ~= totalSquares then
            clrMapper:setColor(192, 192, 192, 200)
        else
            clrMapper:setColor(0, 192, 192, 180)
        end

        square:render()
    end
end
