local class = require 'code/lib/middleclass'


Time = class('Time')

function Time:initialize(const)
    self.current_time = 60
end

function Time:draw()
    love.graphics.print(self.current_time - (self.current_time % 0.1), 0, 0)
end

function Time:add(score_to_add)
    self.current_time = math.max(0, self.current_time + score_to_add)
end

function Time:subtract(score_to_subtract)
    self.current_time = math.max(0, self.current_time - score_to_subtract)
end

function Time:timeLeft()
    return self.current_time > 0
end

return Time