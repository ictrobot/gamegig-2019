local Controller = require 'code/controller'
local StartScreen = require 'code/screens'

function love.load()
    const = {}
    const.img_size = 32
    const.tile_size = 64
    const.img_sf = const.tile_size / const.img_size
    const.width_tiles = 20
    const.height_tiles = 12
    const.width_px = const.width_tiles * const.tile_size
    const.height_px = const.height_tiles * const.tile_size

    love.window.setMode(const.width_px, const.height_px)

    controller = Controller:new()
    controller:setScreen(StartScreen)
end

function love.update(dt)
    controller:update(dt)
end
 
function love.draw()
    controller:draw()
end