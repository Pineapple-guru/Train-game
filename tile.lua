Tile = Object:extend()

function Tile:new(x, y, name, imageFile)
    self.x = x
    self.y = y
    self.name = name
    self.image = love.graphics.newImage(imageFile)
end

function Tile:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
