local class = require 'code/lib/world.lua'

World = class('World')

function World:initialize()
    self.distanceGenerated = -1
    self.tiles = {}
    self.height = 12
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