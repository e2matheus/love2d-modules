--[[
    Game modules

    module-18
    "Quit game"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Features a message at the center of the screen that indicates
    the user what key to press to quit the game, and exits the
    game when that key is pressed.
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

FONT_HALF_HEIGHT_SMALL = 6

--[[
    Runs only once; used to initialize the game.
]]
function love.load()
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
    Keyboard handling called by Love 2D each frame; processes key strokes as they happen,
    once. Does not account for keys that are held down, which is handled by a separate
    function (`love.keyboard.isDown`). Useful for executing operations right away, just once,
    like in this case.
]]
function love.keypressed(key)
    -- The `key` argument will be whatever key this callback detected as pressed
    -- Access the 'escape' key by a string name, and check if that key originated the callback
    if (key == 'escape') then
        -- Terminate the application (Love 2D function)
        love.event.quit()
    end
end

--[[
    Called by Love 2D after the update action ends; used to draw anything to the screen, updated
    or otherwise.
]]
function love.draw()
    -- Begin rendering at virtual resolution
    push:start()

    -- Use virtual width and height now for the text placement
    love.graphics.printf(
        'Press Escape to quit',                       -- text to render
        0,                                            -- X position (0 because it's centered based on width)
        VIRTUAL_HEIGHT / 2 - FONT_HALF_HEIGHT_SMALL,  -- Y position (halfway down the screen)
        VIRTUAL_WIDTH,                                -- rectangle width in pixels (the entire screen here)
        'center')                                     -- alignment mode to the center of the given rectangle 

    -- End rendering at virtual resolution
    push:finish()
end