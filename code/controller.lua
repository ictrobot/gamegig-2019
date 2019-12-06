local class = require 'code/lib/middleclass'


Controller = class('Controller')

function Controller:initialize()
    self.screen = nil
end

function Controller:setScreen(screen)
    screen:load()
    self.screen = screen
end

function Controller:update(dt)
    self.screen:update(dt, self)
end

function Controller:draw()
    self.screen:draw()
end

return Controller