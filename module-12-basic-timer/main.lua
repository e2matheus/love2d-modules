--[[
    Game modules

    module-12
    "Basic timer"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

    Features a timer that affects the position of a circle, inside an
    invisible grid, every 2 seconds
]]

-- push is a library that offers a way to draw the game at a virtual
-- resolution, instead of however large the window is.
--
-- Used to provide a more retro aesthetic.
--
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

FONT_HALF_HEIGHT_LARGE = 14

SQUARE_SIDE = 16

-- Timer values
local SECONDS_PER_SWITCH = 2
local currentSecond = 0
local secondTimer = 0

-- Main circle values
local circleCol = 0
local circleRow = 0
local circleAreaX = 0
local circleAreaY = 0
local circleCenterX = 0
local circleCenterY = 0
local circleRadius = SQUARE_SIDE/2

-- Grid values
local gridCol1 = 13
local gridCol2 = 18
local gridCol = gridCol1
local gridRow = 6

--[[
    Runs only once; used to initialize the game.
]]
function love.load()
    -- Apply nearest-neighbor filtering on upscaling and downscaling to
    -- prevent blurring of text and graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Define "retro-looking" font object to use for any text
    largeFont = love.graphics.newFont('font.ttf', 16)

    -- Set Love 2D's active font to the largeFont object
    love.graphics.setFont(largeFont)

    -- Initialize the virtual resolution, which will be rendered within
    -- the actual window no matter its dimensions.
    --
    -- Replace the love.window.setMode call from the first module
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
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
    secondTimer = secondTimer + dt

    -- Increase the number of seconds when the elapsed time is over 1 second
    -- Set the second timer to the remainder of the overhead.
    if secondTimer > 1 then
        currentSecond = currentSecond + 1
        secondTimer = secondTimer % 1

        -- Switch to the other grid column every 2 seconds
        if currentSecond % SECONDS_PER_SWITCH == 0 then
            switchGridCol()
        end
    end

    updateCirclePosition(gridCol, gridRow)
end

--[[
    Called by Love 2D after the update action ends
    Used to draw anything to the screen, even if it's not updated.
]]
function love.draw()
    -- Begin rendering at virtual resolution
    push:start()

    -- Use virtual width and height for the text placement
    love.graphics.printf(
        currentSecond,                                -- text to render
        0,                                            -- X position (0 because it's centered based on width)
        VIRTUAL_HEIGHT / 2 - FONT_HALF_HEIGHT_LARGE,  -- Y position (halfway down the screen)
        VIRTUAL_WIDTH,                                -- rectangle width in pixels (the entire screen here)
        'center')                                     -- alignment mode to the center of the given rectangle 

    -- Draw a circle at its current position
    love.graphics.circle('line', circleCenterX, circleCenterY, circleRadius)
    
    -- End rendering at virtual resolution
    push:finish()
end

--[[
    Set the position of the center of the circle along the x and y axis,
    in the center of the specified grid column and row.
]]
function updateCirclePosition(col, row)
    circleCol = col
    circleRow = row
    circleAreaX = circleCol*SQUARE_SIDE
    circleAreaY = circleRow*SQUARE_SIDE
    circleCenterX = circleAreaX + SQUARE_SIDE/2
    circleCenterY = circleAreaY + SQUARE_SIDE/2
end

--[[
    Set the current grid column as the other column in the pair.
]]
function switchGridCol()
    gridCol = (gridCol == gridCol1) and gridCol2 or gridCol1
end
