tiles = {}

function loadTile(name, solid, timeMod, scoreMod, speedMod)
    local tile = {}
    tile.name = name
    tile.image = love.graphics.newImage("assets/tiles/" .. name .. ".png")
    tile.solid = solid
    tile.timeMod = timeMod
    tile.scoreMod = scoreMod
    tile.speedMod = speedMod

    function tile:isSolid()
        return self.solid
    end

    tiles[name] = tile
end

loadTile("background", false, 0, 0, 1)
loadTile("platform",   true,  0, 0, 1)
loadTile("edge",       false, 0, 0, 1)

return tiles