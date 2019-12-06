local class = require 'code/lib/middleclass'
local tiles = require 'code/tiles'

World = class('World')

function World:initialize(const)
    self.distanceGenerated = 0
    self.world = {}
    self.height = const.height_tiles
end

function World:setTile(x, y, tile)
    if y < 0 or y >= self.height then
        error("Invalid set tile position")
    end
    self.world[x * self.height + y] = tile
end

function World:getTile(x, y)
    if y < 0 or y >= self.height then
        return tiles["edge"]
    end

    local val = self.world[x * self.height + y]
    if val == nil then
        return tiles["background"]
    else
        return val
    end
end

function World:generatePlatform()
    local y = math.random(0, const.height_tiles - 1)
    local length = math.random(-3, 5)

    for i=0, length do
        self:setTile(self.distanceGenerated + i, y, tiles["platform"])
    end
end

function World:generatePowerups()
    for y=1, const.height_tiles - 2 do
        if not self:getTile(self.distanceGenerated, y).solid and (self:getTile(self.distanceGenerated, y - 1).solid or self:getTile(self.distanceGenerated, y + 1)) then
            for tileName, tile in pairs(tiles) do
                if math.random() <= tile.rarity then
                    self:setTile(self.distanceGenerated, y, tile)
                end
            end
        end
    end
end

function World:generateColumn()
    self:generatePlatform()
    self:generatePowerups()
    self.distanceGenerated = self.distanceGenerated + 1
end

return World