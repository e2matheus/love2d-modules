--[[
    Game modules

    module-11
    "Random Circle"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features a circle, represented as a class object, inside a
    random grid cell
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

-- The Square class, which stores the position and dimensions for the
-- square object and the logic for rendering it
require 'Square'

-- The Circle class, which stores the center position and radius for the
-- circle object and the logic for rendering it
require 'Circle'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

SQUARE_SIDE = 16

-- Main circle radius
local circleRadius = SQUARE_SIDE/2

--[[
    Runs only once; used to initialize the game.
]]
function love.load()
    -- Apply nearest-neighbor filtering on upscaling and downscaling to
    -- prevent blurring of text and graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Set the seed for the random number generator (RNG), so that calls to random are always
    -- random. Use the current time, since that will vary on startup every time
    math.randomseed(os.time())

    -- Initialize the virtual resolution, which will be rendered within
    -- the actual window no matter its dimensions.
    --
    -- Replace the love.window.setMode call from the first module
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- Initialize the grid object and the circle object
    -- Make them global so that they can be detected by other functions and modules
    --
    -- Don't specify the x and y positions of the center of the circle, so that the
    -- class places the shape inside a pseudo-random grid square
    grid = Grid(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, SQUARE_SIDE)
    circle = Circle('line', nil, nil, circleRadius, grid, true)
end

--[[
    Called by Love 2D after the update action ends; used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    -- Begin rendering at virtual resolution
    push:start()

    -- Render the grid object using its class' render method
    grid:render()

    -- Render the circle object using its class' render method
    circle:render()

    -- End rendering at virtual resolution
    push:finish()
end
