local class = require 'code/lib/middleclass'


Player = class('Player')

function Player:initialize(world, const)
    self.x = const.width_tiles / 2
    self.y = const.height_tiles / 2
    self.gravity_flipped = false
    self.gravity_acc = 0.003
    self.speedX = 0.05
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
    lower = self.world:getTile(math.floor(self.x - self.speedX), math.floor(self.y)) ~= nil
    upper = self.world:getTile(math.floor(self.x - self.speedX), math.ceil(self.y)) ~= nil
    return lower or upper
end

function Player:rightCollision()
    lower = self.world:getTile(math.floor(self.x + self.speedX +1), math.floor(self.y)) ~= nil
    upper = self.world:getTile(math.floor(self.x + self.speedX +1), math.ceil(self.y)) ~= nil
    return lower or upper
end

function Player:downCollision()
    left = self.world:getTile(math.floor(self.x), math.floor(self.y - self.speedY)) ~= nil
    right = self.world:getTile(math.ceil(self.x), math.floor(self.y - self.speedY)) ~= nil
    return left or right
end

function Player:upCollision()
    left = self.world:getTile(math.floor(self.x), math.floor(self.y + self.speedY +1)) ~= nil
    right = self.world:getTile(math.ceil(self.x), math.floor(self.y + self.speedY +1)) ~= nil
    return left or right
end

function Player:moveX()
    if love.keyboard.isDown('left') then
        if self:leftCollision() then
            self.x = math.floor(self.x + self.speedX)
        else
            self.x = self.x - self.speedX
        end
    elseif love.keyboard.isDown('right') then
        if self:rightCollision() then
            self.x = math.floor(self.x - self.speedX + 1)
        else
            self.x = self.x + self.speedX
        end
    end
end

function Player:moveY()
    if self.gravity_flipped then
        if self:upCollision() then
            self.y = math.floor(self.y + self.speedY) --actually move to tile surface
            self.speedY = 0 --reset fall acceleration
            if love.keyboard.isDown('space') then
                self.gravity_flipped = false
            end
        else
            self.y = self.y + self.speedY --fall
            self.speedY = self.speedY+self.gravity_acc --accelerate
        end
    else
        if self:downCollision() then
            self.y = math.floor(self.y - self.speedY + 1)
            self.speedY = 0
            if love.keyboard.isDown('space') then
                self.gravity_flipped = true
            end
        else
            self.y = self.y - self.speedY
            self.speedY = self.speedY+self.gravity_acc
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