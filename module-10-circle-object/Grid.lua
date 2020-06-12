--[[
    Game modules

    -- Grid Class --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

	Represents a pixel grid using arbitrary unit square dimensions    
]]

Grid = Class{}

function Grid:init(windowWidth, windowHeight, unitMeasurement)
    self.uom = unitMeasurement
    self.numCols = windowWidth/self.uom
    self.numRows = windowHeight/self.uom
end

function Grid:render()
    for r = 0, self.numRows do
        for c = 0, self.numCols do
            love.graphics.rectangle('line', c*self.uom, r*self.uom, self.uom, self.uom)
        end
    end
end
