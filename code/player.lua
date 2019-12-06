local class = require 'code/lib/middleclass'


Player = class('Player')

function Player:initialize(world, const)
    self.x = const.width_tiles / 2
    self.y = const.height_tiles / 2
    self.gravity = false
    self.speed = 0.01
    self.gravity = 0.005

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

    if love.keyboard.isDown('left') then
        if self.world:getTile(math.floor(self.x - self.speed), math.floor(self.y)) == nil then
            self.x = self.x - self.speed
        end
    elseif love.keyboard.isDown('right') then
        if self.world:getTile(math.floor(self.x + self.speed +1), math.floor(self.y)) == nil then
            self.x = self.x + self.speed
        end
    end

    if gravity_flipped then
        if self.world:getTile(math.floor(self.x), math.floor(self.y + self.gravity +1)) == nil then
            self.y = self.y + self.gravity
        end
    else
        if self.world:getTile(math.floor(self.x), math.floor(self.y - self.gravity)) == nil then
            self.y = self.y - self.gravity
        end
    end
    
    --generate new cols
    while self:drawMaxTileX() > world.distanceGenerated do
        self.world:generateColumn()
    end 
end

return Player