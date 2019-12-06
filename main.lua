local World = require 'code/world'
local Player = require 'code/player'

function love.load()
    const = {}
    const.tile_size = 64
    const.width_tiles = 20
    const.height_tiles = 12
    const.width_px = const.width_tiles * const.tile_size
    const.height_px = const.height_tiles * const.tile_size

    love.window.setMode(const.width_px, const.height_px)

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
    if game.time_left >= 0 then
        love.graphics.setColor(0, 0.4, 0.4)
        worldOffset = (player.x - (const.width_tiles / 2)) * const.tile_size

        function convertX(tileX)
            return (tileX * const.tile_size) - worldOffset
        end
        
        function convertY(tileY)
            return const.height_px - ((tileY + 1) * const.tile_size)
        end

        --tiles
        for tileX=player:minTileX(), player:maxTileX() do
            for tileY=0, const.height_tiles - 1 do
                if world:getTile(tileX, tileY) ~= nil then
                    love.graphics.rectangle("fill", convertX(tileX), convertY(tileY), const.tile_size, const.tile_size)
                end
            end
        end

        --player
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", convertX(player.x), convertY(player.y), const.tile_size, const.tile_size)

        --timer
        love.graphics.print(game.time_left - (game.time_left % 0.1), 0, 0)
    else
        --end screen
        love.graphics.print("game over", const.width_px / 2, const.height_px / 2)
    end
end