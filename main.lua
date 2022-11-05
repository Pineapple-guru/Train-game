function love.load()
  x = 64
  y = 64
  gridw = 64
  gridh = 64
end

function love.update(dt)
end

function love.draw()
  for i=0,15 do
    for j=0,8 do
      love.graphics.rectangle('line', x * i, y * j, gridw, gridh)
    end
  end
end
