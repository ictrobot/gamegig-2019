local World = require 'code/world'
local Player = require 'code/player'
local Timer = require 'code/timer'
local Score = require 'code/score'

function love.load()
    const = {}
    const.tile_size = 64
    const.width_tiles = 20
    const.height_tiles = 12
    const.width_px = const.width_tiles * const.tile_size
    const.height_px = const.height_tiles * const.tile_size

    love.window.setMode(const.width_px, const.height_px)

    timer = Timer:new(const)
    score = Score:new(const)
    world = World:new(const)
    player = Player:new(world, const)
end

function love.update(dt)
    timer:subtract(dt)
    player:update()
end
 
function love.draw()
    if timer:timeLeft() then
        love.graphics.setColor(0, 0.4, 0.4)
        worldOffset = (player.x - (const.width_tiles / 2)) * const.tile_size

        function convertX(tileX)
            return (tileX * const.tile_size) - worldOffset
        end
        
        function convertY(tileY)
            return const.height_px - ((tileY + 1) * const.tile_size)
        end

        --tiles
        love.graphics.setColor(1, 1, 1)
        for tileX=player:minTileX(), player:maxTileX() do
            for tileY=0, const.height_tiles - 1 do
                local tile = world:getTile(tileX, tileY)
                love.graphics.draw(tile.image, convertX(tileX), convertY(tileY), 0, const.tile_size / 32, const.tile_size / 32)
            end
        end

        --player
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", convertX(player.x), convertY(player.y), const.tile_size, const.tile_size)

        -- timer & score
        timer:draw()
        score:draw()
    else
        --end screen
        love.graphics.print("game over", const.width_px / 2, const.height_px / 2)
    end
end