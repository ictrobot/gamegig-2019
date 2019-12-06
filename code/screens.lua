local World = require 'code/world'
local Player = require 'code/player'
local Timer = require 'code/timer'
local Score = require 'code/score'
local tiles = require 'code/tiles'

--https://fontlibrary.org/en/font/cmu-typewriter
font = love.graphics.newFont("assets/cmuntb.ttf", 64)
love.graphics.setFont(font)

---------------------------------------------------------------------------------------------------

StartScreen = {}

function StartScreen:load()

end

function StartScreen:update(dt, controller)
    if love.keyboard.isDown('space') then
        controller:setScreen(MainScreen)
    end
end

function StartScreen:draw()
    love.graphics.print("Deadline Dash", 10, 10)

    helpY = 90

    function help(tilename, description, y)
        love.graphics.draw(tiles[tilename].rawImage, 50, helpY, 0, 2, 2)
        love.graphics.print(description, 200, helpY)
        helpY = helpY + 75
    end

    helpY = helpY + 25
    help("time_minus_5", "Lose 5 seconds")
    help("time_minus_10", "Lose 10 seconds")

    helpY = helpY + 25
    help("time_plus_15", "Gain 15 seconds")

    helpY = helpY + 25
    help("score_plus_2", "Gain 2 score")
    help("score_plus_3", "Gain 3 score")

    helpY = helpY + 25
    help("speed_plus_1.25", "Increases your speed!")

    love.graphics.print("Press space to start", 10, const.height_px - 100)
end

---------------------------------------------------------------------------------------------------

LossScreen = {}

function LossScreen:load()

end

function LossScreen:update(dt, controller)
    if love.keyboard.isDown('space') then
        controller:setScreen(StartScreen)
    end
end

function LossScreen:draw()
    love.graphics.print("DEADLINE MISSED", math.floor(0.3 * const.width_px), math.floor(const.height_px / 4))
    love.graphics.print("press space to restart", math.floor(0.2 * const.width_px), math.floor(const.height_px / 2))
    local tile = tiles['background']
    for i=0, const.width_tiles -1 do
        love.graphics.draw(tile.image, i*const.tile_size, 0, 0, const.tile_size / 32, const.tile_size / 32)
        love.graphics.draw(tile.image, i*const.tile_size, 11*const.tile_size, 0, const.tile_size / 32, const.tile_size / 32)
    end
end

---------------------------------------------------------------------------------------------------

WinScreen = {}

function WinScreen:load()

end

function WinScreen:update(dt, controller)
    if love.keyboard.isDown('space') then
        controller:setScreen(StartScreen)
    end
end

function WinScreen:draw()
    love.graphics.print("WORK COMPLETED", math.floor(0.3 * const.width_px), math.floor(const.height_px / 4))
    love.graphics.print("press space to restart", math.floor(0.2 * const.width_px), math.floor(const.height_px / 2))
    local tile = tiles['background']
    for i=0, const.width_tiles -1 do
        love.graphics.draw(tile.image, i*const.tile_size, 0, 0, const.tile_size / 32, const.tile_size / 32)
        love.graphics.draw(tile.image, i*const.tile_size, 11*const.tile_size, 0, const.tile_size / 32, const.tile_size / 32)
    end
    local disco = tiles['time_minus_10']
    for i=0, const.height_tiles -1 do
        love.graphics.draw(disco.image, 0, i*const.tile_size, 0, const.tile_size / 32, const.tile_size / 32)
        love.graphics.draw(disco.image, 19*const.tile_size, i*const.tile_size, 0, const.tile_size / 32, const.tile_size / 32)
    end
end

---------------------------------------------------------------------------------------------------

MainScreen = {}

function MainScreen:load()
    timer = Timer:new(const)
    score = Score:new(const)
    world = World:new(const)
    player = Player:new(world, const)
end

function MainScreen:update(dt, controller)
    if score.score >= score.target then
        controller:setScreen(WinScreen)
    elseif timer:timeLeft() and player:onScreen() then
        timer:subtract(dt)
        player:update()
    else
        controller:setScreen(LossScreen)
    end
end
 
function MainScreen:draw()
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
end

return StartScreen