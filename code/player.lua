local class = require 'code/lib/middleclass'


Player = class('Player')

function Player:initialize(world, const)
    self.x = const.width_tiles / 2
    self.y = const.height_tiles / 2
    self.gravity_flipped = false
    self.gravity_acc = 0.0001
    self.speedX = 0.1
    self.speedY = 0

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
    if love.keyboard.isDown('space') then
        self:toggleGravity()
    end

    if gravity_flipped then
        if self:upCollision() then
            self.speedY = 0 --reset fall acc
        else
            self.y = self.y + self.speedY --fall
            self.speedY = self.speedY+self.gravity_acc
        end
    else
        if self:downCollision() then
            self.speedY = 0 --reset fall acc
        else
            self.y = self.y - self.speedY
            self.speedY = self.speedY+self.gravity_acc
        end
    end
end

function Player:toggleGravity()
    if gravity_flipped and self:upCollision() then
        gravity_flipped = false
    elseif self:downCollision() then
        gravity_flipped = true
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