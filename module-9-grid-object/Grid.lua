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
    self.width = windowWidth/self.uom
    self.height = windowHeight/self.uom
end

function Grid:render()
    for j = 0, self.height do
        for i = 0, self.width do
            love.graphics.rectangle('line', i*self.uom, j*self.uom, self.uom, self.uom)
        end
    end
end
