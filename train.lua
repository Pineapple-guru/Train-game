Train = Object:extend()

function Train:new(line_stack)
    self.line_stack = line_stack
    self.current_index = 1
    self.x_ratio = 0
    self.y_ratio = 0
    self.switch = 0
    self.x = line_stack[self.current_index][1] * 64
    self.y = line_stack[self.current_index][2] * 64
    self.reverse_line_stack = {}
    for i, track in ipairs(self.line_stack) do
        table.insert(self.reverse_line_stack, 1, track)
    end
    self.train_up = love.graphics.newImage("TrainUp.png")
    self.train_down = love.graphics.newImage("TrainDown.png")
    self.train_left = love.graphics.newImage("TrainLeft.png")
    self.train_right = love.graphics.newImage("TrainRight.png")
    self.image = love.graphics.newImage("TrainUp.png")
end

function Train:update(dt)
    distance = 150 * dt
    if self.switch == 0 then
        self.current_stack = self.line_stack
    else
        self.current_stack = self.reverse_line_stack
    end
    if self.current_stack[self.current_index][1] ~= self.current_stack[self.current_index + 1][1] then
        if self.current_stack[self.current_index][1] == self.current_stack[self.current_index + 1][1] + 1 then
            self.x_ratio = self.x_ratio - (distance / 64)
            self.x = self.x - distance
            self.image = self.train_left
        end
        if self.current_stack[self.current_index][1] == self.current_stack[self.current_index + 1][1] - 1 then
            self.x_ratio = self.x_ratio + (distance / 64)
            self.x = self.x + distance
            self.image = self.train_right
        end
    else
        if self.current_stack[self.current_index][2] == self.current_stack[self.current_index + 1][2] + 1 then
            self.y_ratio = self.y_ratio - (distance / 64)
            self.y = self.y - distance
            self.image = self.train_up
        end
        if self.current_stack[self.current_index][2] == self.current_stack[self.current_index + 1][2] - 1 then
            self.y_ratio = self.y_ratio + (distance / 64)
            self.y = self.y + distance
            self.image = self.train_down
        end
    end
    if self.x_ratio >= 1 then
        self.x_ratio = self.x_ratio - 1
        self.current_index = self.current_index + 1
    elseif self.x_ratio <= -1 then
        self.x_ratio = self.x_ratio + 1
        self.current_index = self.current_index + 1
    elseif self.y_ratio >= 1 then
        self.y_ratio = self.y_ratio - 1
        self.current_index = self.current_index + 1
    elseif self.y_ratio <= -1 then
        self.y_ratio = self.y_ratio + 1
        self.current_index = self.current_index + 1    
    end
    if self.current_index >= table.maxn(self.current_stack) then
        self.current_index = 1
        if self.switch == 0 then
            self.switch = 1
        else
            self.switch = 0
        end
    end
end

function Train:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
