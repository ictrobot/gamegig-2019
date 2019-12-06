local World = require 'code/world'
local Player = require 'code/player'
local Timer = require 'code/timer'
local Score = require 'code/score'

--https://fontlibrary.org/en/font/cmu-typewriter
font = love.graphics.newFont("assets/cmuntb.ttf", 64)

---------------------------------------------------------------------------------------------------

local MainScreen = {}

function MainScreen:load()
    timer = Timer:new(const)
    score = Score:new(const)
    world = World:new(const)
    player = Player:new(world, const)

    love.graphics.setFont(font)
end

function MainScreen:update(dt, controller)
    timer:subtract(dt)
    player:update()
end
 
function MainScreen:draw()
    if timer:timeLeft() and player:onScreen() then
        --play screen
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
                local tile = world:getTile(tileX, tileY)
                love.graphics.draw(tile.image, convertX(tileX), convertY(tileY), 0, const.tile_size / 32, const.tile_size / 32)
            end
        end

        --player
        love.graphics.draw(player:getImage(), convertX(player.x), convertY(player.y), 0, const.tile_size / 32, const.tile_size / 32)

        -- timer & score
        timer:draw()
        score:draw()

    elseif score.score >= score.target then
        --win screen
        love.graphics.print("win\npress space to restart", 0, 0)
        if love.keyboard.isDown('space') then
            love.load()
        end
    else
        --lose screen
        love.graphics.print("lose\npress space to restart", 0, 0)
        if love.keyboard.isDown('space') then
            love.load()
        end
    end
end

---------------------------------------------------------------------------------------------------

local StartScreen = {}

function StartScreen:load()

end

function StartScreen:update(dt, controller)
    if love.keyboard.isDown('space') then
        controller:setScreen(MainScreen)
    end
end

function StartScreen:draw()
    love.graphics.print("Hello", 0, 0)
end

return StartScreen