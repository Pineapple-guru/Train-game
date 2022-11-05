function love.load()
    x = 64
    y = 64
    gridw = 64
    gridh = 64
    mousex = 0
    mousey = 0
end

function love.update(dt)
    mousex, mousey = love.mouse.getPosition()
    print(math.floor(mousex / 64) + 1, math.floor(mousey / 64) + 1)
    mouse_floor_x = math.floor(mousex / 64)
    mouse_floor_y = math.floor(mousey / 64)
end

function love.draw()
    for i=0,15 do
        for j=0,8 do
            love.graphics.rectangle("line", x * i, y * j, gridw, gridh)
        end
    end
    love.graphics.rectangle("fill", x * mouse_floor_x, y * mouse_floor_y, gridw, gridh)
end
