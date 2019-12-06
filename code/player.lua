local class = require 'code/lib/middleclass'


Player = class('Player')

function Player:initialize(world, const)
    self.x = const.width_tiles / 2
    self.y = const.height_tiles / 2
    self.gravity = false
    self.speed = 0.01
    self.gravity = 0.02

    self.world = world
    self.const = const
end

function Player:minTileX()
    return math.floor(self.x - (const.width_tiles / 2) - 1)
end

function Player:maxTileX()
    return math.ceil(self.x + (const.width_tiles / 2) + 1)
end

function Player:leftCollision()
    lower = self.world:getTile(math.floor(self.x - self.speed), math.floor(self.y)) ~= nil
    upper = self.world:getTile(math.floor(self.x - self.speed), math.ceil(self.y)) ~= nil
    return lower or upper
end

function Player:rightCollision()
    lower = self.world:getTile(math.floor(self.x + self.speed +1), math.floor(self.y)) ~= nil
    upper = self.world:getTile(math.floor(self.x + self.speed +1), math.ceil(self.y)) ~= nil
    return lower or upper
end

function Player:downCollision()
    left = self.world:getTile(math.floor(self.x), math.floor(self.y - self.gravity)) ~= nil
    right = self.world:getTile(math.ceil(self.x), math.floor(self.y - self.gravity)) ~= nil
    return left or right
end

function Player:upCollision()
    left = self.world:getTile(math.floor(self.x), math.floor(self.y + self.gravity +1)) ~= nil
    right = self.world:getTile(math.ceil(self.x), math.floor(self.y + self.gravity +1)) ~= nil
    return left or right
end

function Player:moveX()
    if love.keyboard.isDown('left') then
        if not self:leftCollision() then
            self.x = self.x - self.speed
        end
    elseif love.keyboard.isDown('right') then
        if not self:rightCollision() then
            self.x = self.x + self.speed
        end
    end
end

function Player:moveY()
    gravity_flipped = love.keyboard.isDown('space')
    if gravity_flipped then
        if not self:upCollision() then
            self.y = self.y + self.gravity
        end
    else
        if not self:downCollision() then
            self.y = self.y - self.gravity
        end
    end
end

function Player:update()
    self:moveX()
    self:moveY()

    --generate new cols
    while self:maxTileX() > self.world.distanceGenerated do
        self.world:generateColumn()
    end 
end

return Player