--[[
    Game modules

    module-0
    "Hello World"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features the "Hello World" text at the center of the screen, with
    the default settings.
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

FONT_HALF_HEIGHT_SMALL = 6

--[[
    Runs only once; used to initialize the game.
]]
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--[[
    Called by Love 2D after the update action ends; used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    love.graphics.printf(
        'Hello World!',                              -- text to render
        0,                                           -- X position (0 because it's centered based on width)
        WINDOW_HEIGHT / 2 - FONT_HALF_HEIGHT_SMALL,  -- Y position (halfway down the screen, )
        WINDOW_WIDTH,                                -- rectangle width in pixels (the entire screen here)
        'center')                                    -- alignment mode to the center of the given rectangle 
end
