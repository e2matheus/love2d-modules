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
end

--[[
    Centers the square inside the given rectangle container.
]]
function Square:centerInRect(rX, rY, rWidth, rHeight)
    if rWidth >= self.width and rHeight >= self.height then
        self.x = rX + rWidth/2 - self.width/2
        self.y = rY + rHeight/2 - self.height/2
    end
end

function Square:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
