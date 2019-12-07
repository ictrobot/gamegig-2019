local class = require 'code/lib/middleclass'

local Timer = class('Timer')

function Timer:initialize()
    self.current_time = 60
end

function Timer:draw()
    love.graphics.print(self.current_time - (self.current_time % 0.1), 0, 0)
end

function Timer:add(score_to_add)
    self.current_time = math.max(0, self.current_time + score_to_add)
end

function Timer:subtract(score_to_subtract)
    self.current_time = math.max(0, self.current_time - score_to_subtract)
end

function Timer:timeLeft()
    return self.current_time > 0
end

return Timer