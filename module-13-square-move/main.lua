--[[
    Game modules

    module-13
    "Square Move"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features a filled square, represented as a class object, drawn
    inside one of the grid cells. The game takes input from the user
    and moves the square in one of four directions to adjacent grid
    cells, depending on the pressed key.
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
    startGridRow = 3

    -- Square object start position
    startSquareX = startGridCol*SQUARE_SIDE
    startSquareY = startGridRow*SQUARE_SIDE

    -- Initialize the square object
    -- Make it global so that it can be detected by other functions and modules
    square = Square(startSquareX, startSquareY, SQUARE_SIDE)

    -- Move the square one grid cell at a time
    square.speed = SQUARE_SIDE

    -- Update the square position every second
    square.secPerUpdate = 1
end

--[[
    Called every frame by Love 2D, passing in 'dt' since the last
    frame. 'dt' is short for 'deltaTime' and is measured in seconds.
    Multiplying this by any changes made in the game will allow the
    game to perform consistently across all hardware. Otherwise, any
    changes made will be applied as fast as possible and will vary
    across system hardware.
]]
function love.update(dt)
    square:move(dt)
end

--[[
    Handles the keyboard. Called by Love 2D each frame; 
    passes in the key the user pressed so it can be 
    accessed by the game.

    Keys can be accessed by a string name.
]]
function love.keypressed(key)
    if key == 'left' then
        square:setDirection(-1, 0)
    elseif key == 'right' then
        square:setDirection(1, 0)
    elseif key == 'up' then
        square:setDirection(0, -1)
    elseif key == 'down' then
        square:setDirection(0, 1)
    end
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
