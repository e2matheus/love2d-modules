--[[
    Game modules

    module-6
    "Current time"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features the current time in 12 hour format, at the center of
    the screen.
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

FONT_HALF_HEIGHT_SMALL = 6

-- Containers to store the time information
local gameStartTime = 0
local computerTime = "00:00:00 AM"

--[[
    Runs only once; used to initialize the game.
]]
function love.load()
    -- Get the current time in seconds, at the very start of the game
    gameStartTime = os.time()

    -- Apply nearest-neighbor filtering on upscaling and downscaling to
    -- prevent blurring of text and graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Define "retro-looking" font object to use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- Set Love 2D's active font to the smallFont object
    love.graphics.setFont(smallFont)

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
    Called every frame by Love 2D, passing in 'dt' since the last
    frame. 'dt' is short for 'deltaTime' and is measured in seconds.
    Multiplying this by any changes made in the game will allow the
    game to perform consistently across all hardware. Otherwise, any
    changes made will be applied as fast as possible and will vary
    across system hardware.
]]
function love.update(dt)
    computerTime = tostring(os.date("%I:%M:%S %p", os.time()))
end

--[[
    Called by Love 2D after the update action ends
    Used to draw anything to the screen, even if it's not updated.
]]
function love.draw()
    -- Begin rendering at virtual resolution
    push:start()

    -- Use virtual width and height now for the text placement
    love.graphics.printf(
        computerTime,                                -- text to render
        0,                                           -- X position (0 because it's centered based on width)
        VIRTUAL_HEIGHT / 2 - FONT_HALF_HEIGHT_SMALL,  -- Y position (halfway down the screen, )
        VIRTUAL_WIDTH,                                -- rectangle width in pixels (the entire screen here)
        'center')                                    -- alignment mode to the center of the given rectangle 
    
    -- End rendering at virtual resolution
    push:finish()
end
