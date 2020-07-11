--[[
    Game modules

    -- Grid Class --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

	Represents a pixel grid using arbitrary unit square dimensions,
    and a set number of rows and columns, calculated by an arbitrary
    width and height.
]]

Grid = Class{}

function Grid:init(gridWidth, gridHeight, unitMeasurement, settings)
    -- Set the unit of measurement as 1 if the specified unit is less than or
    -- equal to 0
    self.uom = unitMeasurement > 0 and unitMeasurement or 1
    -- Set the number of rows and columns as integer values
    self.numCols = math.floor(gridWidth/self.uom)
    self.numRows = math.floor(gridHeight/self.uom)

    self.offsetX = 0
    self.offsetY = 0

    -- If the settings table is received, check what were the given optional fields
    -- Use every optional field value to update the corresponding class property
    if settings and type(settings) == "table" then
        if settings.offsetX ~= nil then
            self.offsetX = settings.offsetX
        end

        if settings.offsetY ~= nil then
            self.offsetY = settings.offsetY
        end
    end
end

--[[
    Renders the pixel grid using the unit square dimensions.

    Makes sure to draw every row and every column on the screen.
]]
function Grid:render()
    for j = 0, self.numRows-1 do
        for i = 0, self.numCols-1 do
            love.graphics.rectangle('line',
                self.offsetX + i*self.uom, self.offsetY + j*self.uom, self.uom, self.uom)
        end
    end
end
