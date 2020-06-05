--[[
    Game modules

    module-4
    "Corners"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features text at each of the corners of the screen, with a low-res
    aesthetic, and a "retro-looking" Font.
]]

-- push is a library that offers a way to draw the game at a virtual
-- resolution, instead of however large the window is.

-- Used to provide a more retro aesthetic.
--
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

FONT_HALF_HEIGHT_SMALL = 6

SQUARE_SIDE = 16

GRID_WIDTH = VIRTUAL_WIDTH/SQUARE_SIDE
GRID_HEIGHT = VIRTUAL_HEIGHT/SQUARE_SIDE

-- Offsets for the text placement at the corners of the screen
local rectOffsetX = 10
local rectOffsetY = 10
local bottomOffsetY = VIRTUAL_HEIGHT - rectOffsetY - FONT_HALF_HEIGHT_SMALL

--[[
    Runs only once; used to initialize the game.
]]
function love.load()
    -- Apply nearest-neighbor filtering on upscaling and downscaling to
    -- prevent blurring of text and graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Define "retro-looking" font object to use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- Set Love 2D's active font to the smallFont object
    love.graphics.setFont(smallFont)

    -- Initialize the virtual resolution, which will be rendered within
    -- the actual window no matter its dimensions.
    --
    -- Replace the love.window.setMode call from the last module
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--[[
    Called by Love 2D after the update action ends; used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    -- Begin rendering at virtual resolution
    push:start()
    
    -- Draw a pixel grid using the unit square dimensions
    for j = 0, GRID_HEIGHT do
        for i = 0, GRID_WIDTH do
            love.graphics.rectangle('line', i*SQUARE_SIDE, j*SQUARE_SIDE, SQUARE_SIDE, SQUARE_SIDE)
        end
    end

    -- Use virtual width and height for the text placement
    love.graphics.printf(
        'Hello World!',                               -- text to render
        0,                                            -- X position (0 because it's centered based on width)
        VIRTUAL_HEIGHT / 2 - FONT_HALF_HEIGHT_SMALL,  -- Y position (halfway down the screen)
        VIRTUAL_WIDTH,                                -- rectangle width in pixels (the entire screen here)
        'center')                                     -- alignment mode to the center of the given rectangle 

    -- Move text rectangle 10 px from the left, and 10 px down from the top
    love.graphics.printf('TOP LEFT', rectOffsetX, rectOffsetY, VIRTUAL_WIDTH, 'left')
    -- Move text rectangle 10 px from the right, and 10 px down from the top
    love.graphics.printf('TOP RIGHT', -rectOffsetX, rectOffsetY, VIRTUAL_WIDTH, 'right')
    -- Move text rectangle 10 px from the left, and 10 px plus half the Font height, from the bottom
    love.graphics.printf('BOTTOM LEFT', rectOffsetX, bottomOffsetY, VIRTUAL_WIDTH, 'left')
    -- Move text rectangle 10 px from the right, and 10 px plus half the Font height, from the bottom
    love.graphics.printf('BOTTOM RIGHT', -rectOffsetX, bottomOffsetY, VIRTUAL_WIDTH, 'right')
    
    -- End rendering at virtual resolution
    push:finish()
end
