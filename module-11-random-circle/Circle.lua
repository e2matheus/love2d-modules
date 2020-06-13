--[[
    Game modules

    -- Circle Class --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

	Represents a circle with a small square that indicates its center    
]]

Circle = Class{}

function Circle:init(mode, x, y, radius, grid, visibleCenter)
    self.mode = mode
    self.radius = radius
    self.grid = grid
    self.x = x
    self.y = y
    
    -- If the x and y positions of the center are not specified, place the shape inside a
    -- pseudo-random grid square
    if (not self.x and not self.y) then
        randomX = math.random(0, self.grid.numCols - 1)
        circleAreaX = randomX*self.grid.uom
        randomY = math.random(0, self.grid.numRows - 1)
        circleAreaY = randomY*self.grid.uom
        self:setCenterPosition(circleAreaX, circleAreaY)
    end

    self.visibleCenter = visibleCenter

    -- Initialize the center indicator
    ctrIndWidth = (2*self.radius)/4
    self.ctrInd = Square(self.x, self.y, ctrIndWidth)
    
    -- Place the indicator inside the circle's bounding box
    bBox = self:getBBox()
    self.ctrInd:centerInRect(bBox.x, bBox.y, bBox.width, bBox.height)
end

--[[
    Set the position of the center along the x and y axis in the center of the
    specified grid cell.
]]
function Circle:setCenterPosition(gridCellX, gridCellY)
    self.x = gridCellX + self.grid.uom/2
    self.y = gridCellY + self.grid.uom/2
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
