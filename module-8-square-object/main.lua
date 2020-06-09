--[[
    Game modules

    module-8
    "Square Object"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features a filled square, represented as a class object, drawn
    inside one of the grid cells.
]]

-- push is a library that offers a way to draw the game at a virtual
-- resolution, instead of however large the window is.

-- Used to provide a more retro aesthetic.
--
-- https://github.com/Ulydev/push
push = require 'push'

-- Class is a library that has the ability to represent anything in
-- the game as code, rather than keeping track of many disparate
-- variables and methods.
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

-- The Square class, which stores the position and dimensions for the
-- square object and the logic for rendering it
require 'Square'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

SQUARE_SIDE = 16

GRID_WIDTH = VIRTUAL_WIDTH/SQUARE_SIDE
GRID_HEIGHT = VIRTUAL_HEIGHT/SQUARE_SIDE

-- Square object position
local squareX = 10*SQUARE_SIDE
local squareY = 3*SQUARE_SIDE

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

    -- Initialize the square object
    -- Make it global so that it can be detected by other functions and modules
    square = Square(squareX, squareY, SQUARE_SIDE)
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

    -- Render the square object, inside one of the grid squares, using its class' render method
    square:render()

    -- End rendering at virtual resolution
    push:finish()
end
