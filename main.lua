Object = require "classic"
require "tile"

function love.load()
    x = 64
    y = 64
    gridw = 64
    gridh = 64
    mousex = 0
    mousey = 0
    trainTracks = {}
    track_tracker = {}
    for i = 0,15 do
        table.insert(track_tracker, {})
        for j = 0,8 do
            table.insert(track_tracker[i + 1], nil)
        end
    end
end

function love.update(dt)
    mousex, mousey = love.mouse.getPosition()
    mouse_floor_x = math.floor(mousex / 64)
    mouse_floor_y = math.floor(mousey / 64)
    if love.mouse.isDown(1) then
        if not track_tracker[mouse_floor_x + 1][mouse_floor_y + 1] then
            local track = Tile(mouse_floor_x * x, mouse_floor_y * y)
            table.insert(trainTracks, track)
            track_tracker[mouse_floor_x + 1][mouse_floor_y + 1] = track
            print("track added")
        end
    end
end

function love.draw()
    for i = 0,15 do
        for j = 0,8 do
            love.graphics.rectangle("line", x * i, y * j, gridw, gridh)
        end
    end
    love.graphics.rectangle("fill", x * mouse_floor_x, y * mouse_floor_y, gridw, gridh)
    for i,track in ipairs(trainTracks) do
        track:draw()
    end
end
