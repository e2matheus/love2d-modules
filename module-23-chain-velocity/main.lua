--[[
    Game modules

    module-23
    "Chain Velocity"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features a chain of filled squares, represented as a class object,
    drawn inside a grid. The game takes input from the user and reduces
    the refresh rate of the chain by 25%, thus increasing the structure's
    velocity. It also gets input from the user to move the chain's head
    in one of four directions to adjacent grid cells, depending on the
    pressed key, as the rest of the squares follow the head's trajectory.
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

-- The Square Chain class, which stores the position and dimensions 
-- for each square chain object and the logic for rendering them
require 'SquareChain'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

SQUARE_SIDE = 16

GRID_NUM_COLS = VIRTUAL_WIDTH/SQUARE_SIDE
GRID_NUM_ROWS = VIRTUAL_HEIGHT/SQUARE_SIDE

-- Square chain length
local TOTAL_SQUARES = 5

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

    -- Grid values
    startGridCol = 10
    startGridRow = 5

    -- Square object start position
    startChainX = startGridCol*SQUARE_SIDE
    startChainY = startGridRow*SQUARE_SIDE

    -- Initialize the square chain object
    -- Make it global so that it can be detected by other functions and modules
    chain = SquareChain(startChainX, startChainY, SQUARE_SIDE, TOTAL_SQUARES)

    -- Move the square chain one grid cell at a time
    chain:setSpeed(SQUARE_SIDE)

    -- Start by updating the square chain's position every second
    chain.secPerUpdate = 1

    -- Set a flag so that the chain's body follows the head's trajectory
    chain.bodyFollowsHead = true

    -- Set the direction of every square of the chain to the left of the screen
    chain:setDirection(-1, 0, true)
end

--[[
    Called every frame by Love 2D, passing in `dt` since the last frame.
    `dt` is short for `deltaTime` and is measured in seconds. Multiplying
    this by any changes made in the game will allow the game to perform
    consistently across all hardware. Otherwise, any changes made will be
    applied as fast as possible and will vary across system hardware.
]]
function love.update(dt)
    chain:move(dt)
end

--[[
    Keyboard handling called by Love 2D each frame; processes key strokes as
    they happen, once. Does not account for keys that are held down, which is
    handled by a separate function (`love.keyboard.isDown`). Useful for
    executing operations right away, just once.

    Keys can be accessed by a string name.

    The `key` argument will be whatever key this callback detected as pressed.

    Arrow keys will determine the chain's head direction, and the space key
    will increase the chain's velocity by 25%.
]]
function love.keypressed(key)
    if (key == 'escape') then
        -- Terminate the application (Love 2D function)
        love.event.quit()
    elseif key == 'left' then
        chain:setDirection(-1, 0)
    elseif key == 'right' then
        chain:setDirection(1, 0)
    elseif key == 'up' then
        chain:setDirection(0, -1)
    elseif key == 'down' then
        chain:setDirection(0, 1)
    elseif key == 'space' then
        chain:increaseVelocity(0.25)
    end
end

--[[
    Called by Love 2D after the update action ends; used to draw anything
    to the screen, updated or otherwise.
]]
function love.draw()
    -- Begin rendering at virtual resolution
    push:start()

    -- Reduce the grid opacity by half
    clrMapper:setColor(255, 255, 255, 128)
    
    -- Draw a pixel grid using the unit square dimensions
    -- Make sure not to draw cells out of the screen
    for j = 0, GRID_NUM_ROWS-1 do
        for i = 0, GRID_NUM_COLS-1 do
            love.graphics.rectangle('line', i*SQUARE_SIDE, j*SQUARE_SIDE, SQUARE_SIDE, SQUARE_SIDE)
        end
    end

    -- Render the square chain object using its class' render method
    chain:render()

    -- Set the drawing color to white, as completely opaque
    clrMapper:setColor(255, 255, 255, 255)

    -- End rendering at virtual resolution
    push:finish()
end
