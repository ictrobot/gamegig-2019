local class = require 'code/lib/middleclass'


Score = class('Score')

function Score:initialize(const)
    self.score = 0
    self.target = 100
    self.const = const
end

function Score:draw()
    love.graphics.setColor(0.1, 0.8, 0.1)
    love.graphics.rectangle("fill", 20, 100, 50, 200)
    love.graphics.setColor(1,1,1)
    local fraction = math.max(self.score/self.target, 0.01)
    love.graphics.rectangle("fill", 20, 100, 50, 200 - 200*fraction)
end

function Score:add(score_to_add)
    self.score = math.max(0, math.min(self.target,self.score + score_to_add))
end

function Score:subtract(score_to_subtract)
    self.score = math.max(0, math.min(self.score - score_to_subtract))
end


return Score