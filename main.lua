function love.load()
    screen = {}
    screen.tile_size = 64
    screen.width_tiles = 20
    screen.height_tiles = 12
    screen.width_px = screen.width_tiles * screen.tile_size
    screen.height_px = screen.height_tiles * screen.tile_size

    game = {}
    game.dist = screen.width_px / 2
    game.time_left = 60
    game.score = 0
    game.gravity_flipped = false

    player = {}
    player.x = screen.width_px / 2
    player.y = screen.height_px / 2

    tiles = {}
    --add initial tile set
end

function love.update(dt)
    --flip gravity
    --[[if love.keyboard.isDown('space') then
        game.gravity_flipped = not game.gravity_flipped
    end]]--

    --calc new player pos
        --if pressed (left/right) and not touching tile to (left/right)
            --move game.dist (right/left)
        --if not directly on tile
            --fall "down", change
        


    --generate new cols
        --

    --draw cols
end
 
function love.draw()
    love.graphics.setColor(0, 0.4, 0.4)
    love.graphics.rectangle("fill", x, y, w, h)
end