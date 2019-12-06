local class = require 'code/lib/middleclass'


Player = class('Player')

function Player:initialize(world, const)
    self.x = const.width_tiles / 2
    self.y = 1
    self.gravity = false

    self.world = world
    self.const = const
end

function Player:drawMinTileX()
    return math.floor(self.x - (const.width_tiles / 2) - 1)
end

function Player:drawMaxTileX()
    return math.ceil(self.x + (const.width_tiles / 2) + 1)
end

function Player:update()
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
    while self:drawMaxTileX() > world.distanceGenerated do
        world:generateColumn()
    end 
end

return Player