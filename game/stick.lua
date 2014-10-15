Stick = {}

local DEAD_ZONE = 2

function Stick:new( x, y )
    local s = {}
    setmetatable( s, self )
    self.__index = self

    s.x = x
    s.y = y
    s.controller = controller
    s.grabbed = false
    s.touchOffset = { 0, 0 }
    s.touchID = -1
    s.dir = 1

    return s
end

function Stick.loadMesh()
    local texture = love.graphics.newImage( "gfx/stick.png" )
    local tint = { 255, 205, 135, }
    local size = { love.graphics.getWidth() * 0.046875, love.graphics.getHeight() * 0.66667 }
    local coords = {
        left = -size[1]/2,
        right = size[1]/2,
        top = -size[2]/2,
        bottom = size[2]/2,
    }
    local uv = {
        left = 0.0,
        right = 1,
        top = 0.0,
        bottom = 1,
    }

    local verts = {
        {
            coords.left, coords.top,
            uv.left, uv.top,
            unpack(tint),
        },
        {
            coords.right, coords.top,
            uv.right, uv.top,
            unpack(tint),
        },
        {
            coords.right, coords.bottom,
            uv.right, uv.bottom,
            unpack(tint),
        },
        {
            coords.left, coords.bottom,
            uv.left, uv.bottom,
            unpack(tint),
        },
    }
    Stick.mesh = love.graphics.newMesh( verts, texture, "fan" )
    Stick.w = size[1]
    Stick.h = size[2]
end

function Stick:draw()
    love.graphics.push()
    if self.grabbed then
        local touchPoint = {
            self.x + self.touchOffset[1],
            self.y + self.touchOffset[2],
        }
        love.graphics.translate( touchPoint[1], touchPoint[2] )
        love.graphics.rotate( self.dir * math.pi/16 )
        love.graphics.translate( -touchPoint[1], -touchPoint[2] )
    end
    love.graphics.draw( self.mesh, self.x, self.y )
    love.graphics.pop()
end

function Stick:update()
    local id
    local x
    local y
    local pressure
    local found = false

    for i=1, love.touch.getTouchCount() do
        id, x, y, pressure = love.touch.getTouch( i )
        if id == self.touchId then
            found = true
            break
        end
    end

    if not found then
        x, y = love.mouse.getX(), love.mouse.getY()
    end

    self:handleMovement( x, y )
end

function Stick:isInside( x, y )
    return math.abs( self.x - x ) <= self.w/2 and math.abs( self.y - y ) <= self.h/2
end

function Stick:handleMovement( x, y )
    if self.grabbed then
        local prevX = self.x
        self.x = x + self.touchOffset[1]
        self.y = y - self.touchOffset[2]
        if self.x - prevX < -DEAD_ZONE then
            self.dir = -1
        elseif self.x - prevX > DEAD_ZONE then
            self.dir = 1
        end
    end
end

function Stick:mousepressed( x, y, button, isTouch )
    self.grabbed = self:isInside( x, y )
    if self.grabbed then
        self.touchOffset[1] = (self.x - x)
        self.touchOffset[2] = (-self.y + y)
        self.dir = 0
    end
    self.debugText = "offsetX: " .. self.touchOffset[1] .. "\noffsetY: " .. self.touchOffset[2]
end

function Stick:mousereleased( x, y, button, isTouch )
    if self.grabbed then
        self.grabbed = false
        self.touchOffset[1] = 0
        self.touchOffset[2] = 0
    end
end

