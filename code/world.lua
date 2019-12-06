local class = require 'code/lib/middleclass'

World = class('World')

function World:initialize(const)
    self.distanceGenerated = 0
    self.tiles = {}
    self.height = const.height_tiles
end

function World:setTile(x, y, tile)
    if y < 0 or y >= self.height then
        error("Invalid set tile position")
    end
    self.tiles[x * self.height + y] = tile
end

function World:getTile(x, y)
    if y < 0 or y >= self.height then
        return nil
    end
    return self.tiles[x * self.height + y]
end

function World:generateColumn()
    --make 1 or 2 tiles per column
    y = math.floor(const.height_tiles * math.random())
    self:setTile(self.distanceGenerated, y, {})
    y = math.floor(const.height_tiles * math.random())
    self:setTile(self.distanceGenerated, y, {})
    self.distanceGenerated = self.distanceGenerated + 1
end

return World