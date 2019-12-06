local class = require 'code/lib/middleclass'

World = class('World')

function World:initialize(const)
    self.distanceGenerated = 0
    self.tiles = {}
    self.height = const.height_tiles

    --draw initial tiles
    for x=1, const.width_tiles do
        self:generateColumn()
    end
end

function World:setTile(x, y, tile)
    self.tiles[x * self.height + y] = tile
end

function World:getTile(x, y)
    return self.tiles[x * self.height + y]
end

function World:generateColumn() 
    --[[self:setTile(self.distanceGenerated, 0, {})
    self.distanceGenerated = self.distanceGenerated + 1]]--
    --make 1 or 2 tiles per column
    y = math.floor(const.height_tiles * math.random())
    self:setTile(self.distanceGenerated, y, {})
    y = math.floor(const.height_tiles * math.random())
    self:setTile(self.distanceGenerated, y, {})
    self.distanceGenerated = self.distanceGenerated + 1
end

return World