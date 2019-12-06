local class = require 'code/lib/middleclass'

Tile = class('Tile')

function Tile:initialize(const, imgFile)
    self.width = const.tile_size
    self.height = const.tile_size
    self.image = love.graphics.newImage(imgFile)
end

function Tile:draw()
    love.graphics.draw(self.image)
end

return Tile