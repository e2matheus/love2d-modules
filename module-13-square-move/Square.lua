--[[
    Game modules

    -- Square Class --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

    Represents a filled square which will be drawn at different
    locations of the screen.
]]

Square = Class{}

function Square:init(xPosition, yPosition, width)
    self.x = xPosition
    self.y = yPosition
    self.width = width
    self.height = width

    -- Initialize movement values
    self.speed = 1
    self.dirX = 0
    self.dirY = 0
    self.secPerUpdate = 0
    self.timeSinceUpdate = 0
end

function Square:setDirection(dirX, dirY)
    self.dirX = dirX
    self.dirY = dirY
end

--[[
    Update the current position when the specified seconds
    have passed, and set the update timer to the remainder
    of the overhead.
]]
function Square:move(dt)
    self.timeSinceUpdate = self.timeSinceUpdate + dt

    if self.timeSinceUpdate > self.secPerUpdate then
        self.x = self.x + self.speed*self.dirX
        self.y = self.y + self.speed*self.dirY

        self.timeSinceUpdate = self.timeSinceUpdate % self.secPerUpdate
    end
end

function Square:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
