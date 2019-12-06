local class = require 'code/lib/middleclass'

Tile = class('Tile')
tiles = {}

function Tile:initialize(const, name)
    self.width = const.tile_size
    self.height = const.tile_size
    self.image = love.graphics.newImage("assets/tiles/" .. name .. ".png")
    tiles[name] = self
end

function Tile:isSolid()
    return false
end

SolidTile = class('SolidTile', Tile)

function SolidTile:isSolid()
    return true
end

function loadTiles(const)
    tiles = {}

    Tile:new(const, "background")
    SolidTile:new(const, "platform")
    Tile:new(const, "edge")

    return tiles
end

return loadTiles