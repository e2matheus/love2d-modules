--[[
    Game modules

    -- Timer Class --

    Author: Eleazar Matheus
    eleazar.matt7@gmail.com

    Represents a timer which will store a callback action, the amount
    of seconds per callback, the current second, the elapsed time, and
    the logic for affecting an output on the screen at certain
    intervals, by executing the callback.
]]

Timer = Class{}

function Timer:init(interval, callback)
    self.secPerCallback = interval
    self.callback = callback
    self.timeBeforeCallback = 0
end

--[[
    Perform the given callback action when the specified amount of
    seconds have passed, and set the update timer to the remainder
    of the overhead.
]]
function Timer:update(dt)
    self.timeBeforeCallback = self.timeBeforeCallback + dt

    if self.timeBeforeCallback > self.secPerCallback then
        self.callback()

        self.timeBeforeCallback = self.timeBeforeCallback % self.secPerCallback
    end
end
