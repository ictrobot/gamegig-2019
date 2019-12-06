local class = require 'code/lib/middleclass'
local loadTiles = require 'code/tiles'

World = class('World')

function World:initialize(const)
    self.distanceGenerated = 0
    self.world = {}
    self.height = const.height_tiles
    self.tiles = loadTiles(const)
end

function World:setTile(x, y, tile)
    if y < 0 or y >= self.height then
        error("Invalid set tile position")
    end
    self.world[x * self.height + y] = tile
end

function World:getTile(x, y)
    if y < 0 or y >= self.height then
        return self.tiles["edge"]
    end
    
    local val = self.world[x * self.height + y]
    if val == nil then
        return self.tiles["background"]
    else
        return val
    end
end

function World:generateColumn()
    --make 1 or 2 tiles per column
    y = math.floor(const.height_tiles * math.random())
    self:setTile(self.distanceGenerated, y, tiles["platform"])
    y = math.floor(const.height_tiles * math.random())
    self:setTile(self.distanceGenerated, y, tiles["platform"])
    self.distanceGenerated = self.distanceGenerated + 1
end

return World