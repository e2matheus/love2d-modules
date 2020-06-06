--[[
    Game modules

    module-5
    "Circle"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features a circle inside one of the grid cells
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

SQUARE_SIDE = 16

GRID_WIDTH = VIRTUAL_WIDTH/SQUARE_SIDE
GRID_HEIGHT = VIRTUAL_HEIGHT/SQUARE_SIDE

-- Main circle values
local circleAreaX = 4*SQUARE_SIDE
local circleAreaY = 3*SQUARE_SIDE
local circleCenterX = circleAreaX + SQUARE_SIDE/2
local circleCenterY = circleAreaY + SQUARE_SIDE/2
local circleRadius = SQUARE_SIDE/2

-- Circle pivot indicator values
local circlePivotWidth = SQUARE_SIDE/8
local circlePivotX = circleCenterX - circlePivotWidth/2
local circlePivotY = circleCenterY - circlePivotWidth/2

--[[
    Runs only once; used to initialize the game.
]]
function love.load()
    -- Apply nearest-neighbor filtering on upscaling and downscaling to
    -- prevent blurring of text and graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

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

    -- Draw a circle inside one of the grid squares
    love.graphics.circle('line', circleCenterX, circleCenterY, circleRadius)

    -- Draw a square to indicate the center of the circle
    love.graphics.rectangle('fill', circlePivotX, circlePivotY, circlePivotWidth, circlePivotWidth)

    -- End rendering at virtual resolution
    push:finish()
end
