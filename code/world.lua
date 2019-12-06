local class = require 'code/lib/middleclass'

World = class('World')

function World:initialize(const)
    self.distanceGenerated = -1
    self.tiles = {}
    self.height = const.height_tiles
end

function World:setTile(x, y, tile)
    self.tiles[x * self.height + y] = tile
end

function World:getTile(x, y)
    return self.tiles[x * self.height + y]
end

function World:generateColumn()
    self.distanceGenerated = self.distanceGenerated + 1
    
    self:setTile(self.distanceGenerated, 0, {})
end

return World