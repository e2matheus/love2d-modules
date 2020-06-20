--[[
    Game modules

    module-16
    "Square Chain"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features a chain of filled squares, represented as class objects,
    drawn inside a grid.
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

GRID_COLS = VIRTUAL_WIDTH/SQUARE_SIDE
GRID_ROWS = VIRTUAL_HEIGHT/SQUARE_SIDE

-- Square chain values
local squares = {}
local startX = 10*SQUARE_SIDE
local startY = 5*SQUARE_SIDE
local TOTAL_SQUARES = 4

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

    -- Initialize the square object chain
    -- Make it global so that it can be detected by other functions and modules
    -- Place the shapes from left to right
    squareX = startX
    squareY = startY
    for i = 1, TOTAL_SQUARES do        
        table.insert(squares, Square(squareX, squareY, SQUARE_SIDE))
        squareX = squareX + SQUARE_SIDE
    end
end

--[[
    Called by Love 2D after the update action ends; used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    -- Begin rendering at virtual resolution
    push:start()

    -- Reduce the grid opacity by half
    clrMapper:setColor(255, 255, 255, 128)
    
    -- Draw a pixel grid using the unit square dimensions
    -- Make sure not to draw cells out of the screen
    for j = 0, GRID_ROWS-1 do
        for i = 0, GRID_COLS-1 do
            love.graphics.rectangle('line', i*SQUARE_SIDE, j*SQUARE_SIDE, SQUARE_SIDE, SQUARE_SIDE)
        end
    end

    -- Render the square chain, inside the grid, using each of its squares render method
    for i , square in pairs(squares) do
        -- Use 3 different colors to highlight the head and the tail of the chain 
        if i == 1 then
            clrMapper:setColor(192, 192, 192, 255)
        elseif i ~= TOTAL_SQUARES then
            clrMapper:setColor(192, 192, 192, 200)
        else
            clrMapper:setColor(0, 192, 192, 180)
        end

        square:render()
    end

    -- Set the drawing color to white, as completely opaque
    clrMapper:setColor(255, 255, 255, 255)

    -- End rendering at virtual resolution
    push:finish()
end
