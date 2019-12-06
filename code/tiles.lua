local tiles = {}

function loadTile(name, imgName, solid, timeMod, scoreMod, speedMod)
    local tile = {}
    tile.name = name
    tile.image = love.graphics.newImage("assets/tiles/" .. imgName .. ".png")
    tile.solid = solid
    tile.timeMod = timeMod
    tile.scoreMod = scoreMod
    tile.speedMod = speedMod

    tiles[name] = tile
end

loadTile("background", "bookshelves", false, 0, 0, 1)
loadTile("platform", "platform", true,  0, 0, 1)
loadTile("edge", "edge", false, 0, 0, 1)

-- time penalties
loadTile("time_minus_5", "phone", false, -5, 0, 0)
loadTile("time_minus_10", "disco_ball_greyscale", false, -10, 0, 0)

-- time bonuses
loadTile("time_plus_15", "email", false, 15, 0, 0)

-- score increase
loadTile("score_plus_2", "open_book", false, 0, 2, 0)
loadTile("score_plus_3", "computer", false, 0, 3, 0)

-- speed bonus
loadTile("speed_plus_1.25", "coffee", false, 0, 0, 1.25)

return tiles