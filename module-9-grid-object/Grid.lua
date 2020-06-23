--[[
    Game modules

    -- Grid Class --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

	Represents a pixel grid using arbitrary unit square dimensions,
    and a set number of rows and columns, calculated by the window
    width and height.
]]

Grid = Class{}

function Grid:init(windowWidth, windowHeight, unitMeasurement)
    -- Set the unit of measurement as 1 if the specified unit is less than or
    -- equal to 0
    self.uom = unitMeasurement > 0 and unitMeasurement or 1
    -- Set the number of rows and columns as integer values
    self.numCols = math.floor(windowWidth/self.uom)
    self.numRows = math.floor(windowHeight/self.uom)
end

--[[
    Renders the pixel grid using the unit square dimensions.

    Makes sure not to draw cells out of the screen.
]]
function Grid:render()
    for j = 0, self.numRows-1 do
        for i = 0, self.numCols-1 do
            love.graphics.rectangle('line', i*self.uom, j*self.uom, self.uom, self.uom)
        end
    end
end
