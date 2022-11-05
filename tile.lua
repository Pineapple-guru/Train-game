Tile = Object:extend()

function Tile:new(x, y)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage("train_track.png")
end

function Tile:draw()
    love.graphics.draw(self.image, self.x, self.y)
end