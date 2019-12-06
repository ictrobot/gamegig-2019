local World = require 'code/world'
local Player = require 'code/player'

function love.load()
    const = {}
    const.tile_size = 64
    const.width_tiles = 20
    const.height_tiles = 12
    const.width_px = const.width_tiles * const.tile_size
    const.height_px = const.height_tiles * const.tile_size

    game = {}
    game.time_left = 60
    game.score = 0

    world = World:new(const)
    player = Player:new(world, const)
end

function love.update(dt)
    game.time_left = game.time_left - dt

    player:update()
end
 
function love.draw()
    love.graphics.setColor(0, 0.4, 0.4)
    for tileX=player:drawMinTileX(), player:drawMaxTileX() do
        for tileY=1, const.height_tiles do
            if world:getTile(tileX, tileY) ~= nil then
                love.graphics.rectangle("fill",
                    tileX * const.tile_size,
                    const.height_px - (tileY * const.tile_size),
                    const.tile_size, const.tile_size)
            end
        end
    end
end