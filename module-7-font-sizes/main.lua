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

FONT_HALF_HEIGHT_LARGE = 14

-- Offsets for the text placement at the corners of the screen
local rectOffsetX = 10
local rectOffsetY = 10
local btmOfsLargeY = VIRTUAL_HEIGHT - rectOffsetY - FONT_HALF_HEIGHT_LARGE

--[[
    Runs only once; used to initialize the game.
]]
function love.load()
    -- Apply nearest-neighbor filtering on upscaling and downscaling to
    -- prevent blurring of text and graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Define a couple of "retro-looking" font objects to use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    
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
    
    --Draw a 10-pixel margin around the entire screen
    love.graphics.rectangle('line',
        rectOffsetX,
        rectOffsetY,
        VIRTUAL_WIDTH - 2*rectOffsetX,
        VIRTUAL_HEIGHT - 2*rectOffsetY)

    -- Set Love 2D's active font to the small font object
    love.graphics.setFont(smallFont)

    -- Draw a small text at the top center of the screen
    love.graphics.printf(
        'Small font',  -- text to render
        0,             -- X position (0 because it's centered based on width)
        rectOffsetY,   -- Y position (top center of the screen, inside the margin)
        VIRTUAL_WIDTH, -- rectangle width in pixels (the entire screen here)
        'center')      -- alignment mode to the center of the given rectangle 

    -- Set Love 2D's active font to the large font object
    love.graphics.setFont(largeFont)
    
    -- Draw a large text at the bottom center of the screen
    love.graphics.printf(
        'Large font',  -- text to render
        0,             -- X position (0 because it's centered based on width)
        btmOfsLargeY,  -- Y position (bottom center of the screen, inside the margin)
        VIRTUAL_WIDTH, -- rectangle width in pixels (the entire screen here)
        'center')      -- alignment mode to the center of the given rectangle 
    
    -- End rendering at virtual resolution
    push:finish()
end
