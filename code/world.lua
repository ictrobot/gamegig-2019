local class = require 'code/lib/world.lua'

World = class('World')

function World:initialize()
    self.distanceGenerated = 0
    self.tiles = {}
    self.height = 12
end

function World:setTile(x, y, tile)
    self.tiles[x * self.height + y] = tile
end

function World:getTile(x, y, tile)
    return self.tiles[x * self.height + y]
end

return World