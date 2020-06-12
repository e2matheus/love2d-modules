--[[
    Game modules

    -- Circle Class --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

	Represents a circle with a small square that indicates its center    
]]

Circle = Class{}

function Circle:init(mode, x, y, radius, visibleCenter)
    self.mode = mode
    self.x = x
    self.y = y
    self.radius = radius
    self.visibleCenter = visibleCenter

    -- Initialize the center indicator
    ctrIndWidth = (2*self.radius)/4
    self.ctrInd = Square(self.x, self.y, ctrIndWidth)
    
    -- Place the indicator inside the circle's bounding box
    bBox = self:getBBox()
    self.ctrInd:centerInRect(bBox.x, bBox.y, bBox.width, bBox.height)
end

--[[
    Returns a table representing the circle's bounding box.
]]
function Circle:getBBox()
    return {
        x = self.x - self.radius,
        y = self.y - self.radius,
        width = 2*self.radius,
        height = 2*self.radius
    }
end

function Circle:render()
    love.graphics.circle(self.mode, self.x, self.y, self.radius)

    -- Draw a small square to indicate the center of the circle
    if self.visibleCenter then
        self.ctrInd:render()
    end
end
