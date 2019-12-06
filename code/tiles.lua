local tiles = {}

local canvas = love.graphics.newCanvas(32, 32)
local background = love.graphics.newImage("assets/tiles/bookshelves.png")

function loadImage(imgName)
    local image = love.graphics.newImage("assets/tiles/" .. imgName .. ".png")

    love.graphics.setCanvas(canvas)
    love.graphics.draw(background)
    love.graphics.draw(image)
    love.graphics.setCanvas(nil)

    return love.graphics.newImage(canvas:newImageData())
end

function loadTile(name, imgName, solid, timeMod, scoreMod, speedMod, rarity)
    local tile = {}
    tile.name = name
    tile.image = loadImage(imgName)
    tile.solid = solid
    tile.timeMod = timeMod
    tile.scoreMod = scoreMod
    tile.speedMod = speedMod
    tile.rarity = rarity

    tiles[name] = tile
end

loadTile("background", "bookshelves", false, 0, 0, 1, 0)
loadTile("platform", "platform", true,  0, 0, 1, 0)
loadTile("edge", "edge", false, 0, 0, 1, 0)

-- time penalties
loadTile("time_minus_5", "phone", false, -5, 0, 1, 0.01)
loadTile("time_minus_10", "disco_ball_greyscale", false, -10, 0, 1, 0.005)

-- time bonuses
loadTile("time_plus_15", "email", false, 15, 0, 1, 0.005)

-- score increase
loadTile("score_plus_2", "open_book", false, 0, 2, 1, 0.01)
loadTile("score_plus_3", "computer", false, 0, 3, 1, 0.01)

-- speed bonus
loadTile("speed_plus_1.25", "coffee", false, 0, 0, 1.25, 0.005)

return tiles