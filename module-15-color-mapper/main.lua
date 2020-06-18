--[[
    Game modules

    module-15
    "Color Mapper"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features a color mapper, represented as a class object, that 
    calls color related operations and modifies component values
    to maintain cross-version consistency.

    Draws 2 colored squares inside different grid cells, and
    applies the same color for both shapes, one with component
    values within the range of 0 to 255, and the other with
    component values ranging from 0 to 1.
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

-- ColorMapper is a library that offers a way to apply colors to the
-- game independently of the current Love 2D version
clrMapper = require 'ColorMapper'

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

-- Square objects positions
local squareX1 = 10*SQUARE_SIDE
local squareY1 = 3*SQUARE_SIDE
local squareX2 = 12*SQUARE_SIDE
local squareY2 = 5*SQUARE_SIDE

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

    -- Initialize the square objects
    -- Make them global so that they can be detected by other functions and modules
    square1 = Square(squareX1, squareY1, SQUARE_SIDE)
    square2 = Square(squareX2, squareY2, SQUARE_SIDE)
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

    -- Replace a love.graphics.setColor call to set the color used for drawing the first square
    -- Set the color component values within the range of 0 to 255 (LÖVE version prior to 11.0)
    clrMapper:setColor(63.75, 63.75, 191.25, 191.25)
    
    -- Render the first square object, inside one of the grid squares, using its class'
    -- render method
    square1:render()

    -- Repeat the same process to draw the second square, but with a variant in the arguments
    -- Set the color component values within the range of 0 to 1 (LÖVE version 11.0 and newer)
    clrMapper:setColor(0.25, 0.25, 0.75, 0.75)
    square2:render()
    
    -- End rendering at virtual resolution
    push:finish()
end
