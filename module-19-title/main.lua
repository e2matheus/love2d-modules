--[[
    Game modules

    module-19
    "Title"

    -- Main Program --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com
    
    Sets the title of the game window as 'Game title'.
]]

--[[
    Runs only once; used to initialize the game.
]]
function love.load()
    -- Set the title of the application window
    love.window.setTitle('Game title')
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
