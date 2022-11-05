Object = require "classic"
require "tile"

function love.load()
    x = 64
    y = 64
    gridw = 64
    gridh = 64
    mousex = 0
    mousey = 0
    mouse_floor_x = 0
    mouse_floor_y = 0
    trainTracks = {}
    object_tracker = {}
    for i = 0,15 do
        table.insert(object_tracker, {})
        for j = 0,8 do
            local empty_tile = Tile(mouse_floor_x * x, mouse_floor_y * y, "empty", "empty_tile.png")
            table.insert(object_tracker[i + 1], empty_tile)
        end
    end
    local start_tile = Tile(mouse_floor_x * x, mouse_floor_y * y, "start", "start_tile.png")
    object_tracker[3][6] = start_tile
    local end_tile = Tile(mouse_floor_x * x, mouse_floor_y * y, "end", "end_tile.png")
    object_tracker[13][2] = end_tile
    current_tile = {2, 5}
end

function love.update(dt)
    mousex, mousey = love.mouse.getPosition()
    mouse_floor_x = math.floor(mousex / 64)
    mouse_floor_y = math.floor(mousey / 64)
    if love.mouse.isDown(1) then
        --if object_tracker[mouse_floor_x + 1][mouse_floor_y + 1].name == "empty" then
        if ((mouse_floor_x == current_tile[1] - 1 and mouse_floor_y == current_tile[2]) or (mouse_floor_x == current_tile[1] + 1 and mouse_floor_y == current_tile[2]) or (mouse_floor_x == current_tile[1] and mouse_floor_y == current_tile[2] - 1) or (mouse_floor_x == current_tile[1] and mouse_floor_y == current_tile[2] + 1)) and check_square(mouse_floor_x, mouse_floor_y) then
            local track = Tile(mouse_floor_x * x, mouse_floor_y * y, "track", "track_tile.png")
            table.insert(trainTracks, track)
            object_tracker[mouse_floor_x + 1][mouse_floor_y + 1] = track
            current_tile = {mouse_floor_x, mouse_floor_y}
        end
    end
end

function love.draw()
    for i = 0,15 do
        for j = 0,8 do
            love.graphics.rectangle("line", x * i, y * j, gridw, gridh)
        end
    end
    love.graphics.print("start", x * 2, y * 5)
    love.graphics.print("end", x * 12, y * 1)
    love.graphics.rectangle("fill", x * mouse_floor_x, y * mouse_floor_y, gridw, gridh)
    for i,track in ipairs(trainTracks) do
        track:draw()
    end
end

function check_square(x, y)
    if x >= 0 and x <= 15 and y >= 0 and y <= 8 then
        return object_tracker[x + 1][y + 1].name == "empty"
    end
end
    
function available_tiles_finder(x, y)
    option_table = {}
    if check_square(x + 1, y) then
        table.insert(option_table, {x + 1, y})
    end
    if check_square(x - 1, y) then
        table.insert(option_table, {x - 1, y})
    end
    if check_square(x, y + 1) then
        table.insert(option_table, {x, y + 1})
    end
    if check_square(x, y - 1) then
        table.insert(option_table, {x, y - 1})
    end
end
