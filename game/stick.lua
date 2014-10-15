Stick = {}

function Stick:new( x, y )
    local s = {}
    setmetatable( s, self )
    self.__index = self

    s.x = x
    s.y = y
    s.controller = controller
    s.grabbed = false
    s.touchOffset = { 0, 0 }

    return s
end

function Stick.loadMesh()
    local texture = love.graphics.newImage( "gfx/stick.png" )
    local tint = { 244, 225, 175, }
    local size = { 48, 512 }
    local coords = {
        left = 0,
        right = size[1],
        top = 0,
        bottom = size[2],
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
    love.graphics.translate( -self.w/2, -self.h/2 )
    love.graphics.draw( self.mesh, self.x, self.y )
    love.graphics.pop()
end

function Stick:update()
    if self.grabbed then
        self.x = love.mouse.getX() + self.touchOffset[1]
        self.y = love.mouse.getY() - self.touchOffset[2]
    end
end

function Stick:isInside( x, y )
    return math.abs( self.x - x ) <= self.w/2 and math.abs( self.y - y ) <= self.h/2
end

function Stick:mousepressed( x, y, button, isTouch )
    self.grabbed = self:isInside( x, y )
    if self.grabbed then
        self.touchOffset[1] = self.x - x
        self.touchOffset[2] = y - self.y
    end
end

function Stick:mousereleased( x, y, button, isTouch )
    if self.grabbed then
        self.grabbed = false
        self.touchOffset[1] = 0
        self.touchOffset[2] = 0
    end
end

function Stick:touchmoved( id, x, y, pressure )
    if self.grabbed then
        self.x = x + self.touchOffset[1]
        self.y = y + self.touchOffset[2]
    end
end
