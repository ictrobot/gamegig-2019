local World = require 'code/world'
local Player = require 'code/player'
local Timer = require 'code/timer'
local Score = require 'code/score'
local tiles = require 'code/tiles'

-- https://fontlibrary.org/en/font/cmu-typewriter
local font = love.graphics.newFont("assets/cmuntb.ttf", 64)
love.graphics.setFont(font)

local backgroundMusic = love.audio.newSource("assets/sounds/background.wav", "static")

local StartScreen = {}
local MainScreen = {}
local WinScreen = {}
local LossScreen = {}

---------------------------------------------------------------------------------------------------

function StartScreen:load()

end

function StartScreen:update(dt, controller)
    if love.keyboard.isDown('space') then
        controller:setScreen(MainScreen)
    end
end

function StartScreen:draw()
    love.graphics.print("Deadline Dash", 10, 10)

    local helpY = 90

    local function help(tilename, description, y)
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
        love.graphics.draw(tile.image, i*const.tile_size, 0, 0, const.img_sf, const.img_sf)
        love.graphics.draw(tile.image, i*const.tile_size, 11*const.tile_size, 0, const.img_sf, const.img_sf)
    end
end

---------------------------------------------------------------------------------------------------

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
        love.graphics.draw(tile.image, i*const.tile_size, 0, 0, const.img_sf, const.img_sf)
        love.graphics.draw(tile.image, i*const.tile_size, 11*const.tile_size, 0, const.img_sf, const.img_sf)
    end
    local disco = tiles['time_minus_10']
    for i=1, const.height_tiles - 2 do
        love.graphics.draw(disco.rawImage, 0, i*const.tile_size, 0, const.img_sf, const.img_sf)
        love.graphics.draw(disco.rawImage, 19*const.tile_size, i*const.tile_size, 0, const.img_sf, const.img_sf)
    end
end

---------------------------------------------------------------------------------------------------

function MainScreen:load()
    timer = Timer:new()
    score = Score:new()
    self.world = World:new()
    self.player = Player:new(self.world)

    backgroundMusic:stop()
    backgroundMusic:play()
end

function MainScreen:update(dt, controller)
    if score.score >= score.target then
        backgroundMusic:stop()
        controller:setScreen(WinScreen)
    elseif timer:timeLeft() and self.player:onScreen() then
        timer:subtract(dt)
        self.player:update()
    else
        backgroundMusic:stop()
        controller:setScreen(LossScreen)
    end
end

function MainScreen:draw()
    --play screen
    local worldOffset = (self.player.x - (const.width_tiles / 2)) * const.tile_size

    local function convertX(tileX)
        return (tileX * const.tile_size) - worldOffset
    end

    local function convertY(tileY)
        return const.height_px - ((tileY + 1) * const.tile_size)
    end

    --tiles
    for tileX=self.player:minTileX(), self.player:maxTileX() do
        for tileY=0, const.height_tiles - 1 do
            local tile = self.world:getTile(tileX, tileY)
            love.graphics.draw(tile.image, convertX(tileX), convertY(tileY), 0, const.img_sf, const.img_sf)
        end
    end

    --player
    love.graphics.draw(self.player:getImage(), convertX(self.player.x), convertY(self.player.y), 0, const.img_sf, const.img_sf)

    -- timer & score
    timer:draw()
    score:draw()
end

return StartScreen