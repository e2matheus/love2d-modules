--[[
    Game modules

    -- Color Mapper Class --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

    Represents an object that applies colors to the game, independently of
    the current Love 2D version, by converting component values to the range
    supported by that version.
]]

local love11 = love.getVersion() == 11
local MAX_PRIOR_LOVE11 = 255

local clrMapper = {}

setmetatable(clrMapper, clrMapper)

--[[
    Sets the specified color used for drawing, independently of the current
    Love 2D version.
]]
function clrMapper:setColor(red, green, blue, alpha)
	clr = clrMapper.ConvertComponents(red, green, blue, alpha)

	love.graphics.setColor(clr.red, clr.green, clr.blue, clr.alpha)
end

-- static api

--[[
    Returns a table representing the specified component values converted to
    the range supported by the current Love 2D version.

    In versions prior to 11.0, color component values were within the range
    of 0 to 255 instead of 0 to 1.
	
	https://love2d.org/wiki/love.graphics.clear
]]
function clrMapper.ConvertComponents(red, green, blue, alpha)
	r = red
	g = green
	b = blue
	a = alpha

	if love11 then
		-- If any of the color component values are greater than the maximum
		-- value supported by LÖVE version 11.0, map the numeric range onto
		-- 0..1
		if (r > 1 or g > 1 or b > 1  or a > 1) then
			r = r / MAX_PRIOR_LOVE11
			g = g / MAX_PRIOR_LOVE11
			b = b / MAX_PRIOR_LOVE11
			a = a / MAX_PRIOR_LOVE11
		end
	else
		-- If all color component values are normalized, map the numeric
		-- range onto 0..MAX_PRIOR_LOVE11
		if (clrMapper.normalized(r) and clrMapper.normalized(g) and
			clrMapper.normalized(b) and clrMapper.normalized(a)) then
			r = MAX_PRIOR_LOVE11 * r
			g = MAX_PRIOR_LOVE11 * g
			b = MAX_PRIOR_LOVE11 * b
			a = MAX_PRIOR_LOVE11 * a
		end
	end

    return {
        red = r,
        green = g,
        blue = b,
        alpha = a
    }
end

function clrMapper.normalized(component)
	return component >= 0 and component <= 1
end

return clrMapper
