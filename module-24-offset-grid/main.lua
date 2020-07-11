--[[
    Game modules

    module-24
    "Offset Grid"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features a 16x16 pixel grid, represented as a class object,
    smaller than the screen and offset by an arbitrary amount.
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

-- The Grid class, which stores the virtual window dimensions, the
-- unit square dimensions, and the logic for rendering the grid
-- object
require 'Grid'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

SQUARE_SIDE = 16

SMALL_GRID_WIDTH = 14*SQUARE_SIDE
SMALL_GRID_HEIGHT = VIRTUAL_HEIGHT - 4*SQUARE_SIDE

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

    -- Initialize the grid object, smaller than the screen
    -- Set the properties of the structure, modifying the specified offset properties
    -- Make it global so that it can be detected by other functions and modules
    grid = Grid(SMALL_GRID_WIDTH, SMALL_GRID_HEIGHT, SQUARE_SIDE, {
        offsetX = 10*SQUARE_SIDE,
        offsetY = 2*SQUARE_SIDE }
    )
end

--[[
    Called by Love 2D after the update action ends; used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    -- Begin rendering at virtual resolution
    push:start()

    -- Render the grid object using its class' render method
    grid:render()

    -- End rendering at virtual resolution
    push:finish()
end
