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
        local offsetX = self.x + self.touchOffset[1]
        local offsetY = self.y + self.touchOffset[2]
        love.graphics.translate( offsetX, offsetY )
        love.graphics.rotate( self.dir * math.pi/16 )
        love.graphics.translate( -offsetX, -offsetY )
        love.graphics.translate( -self.dir * (self.touchOffset[2]/(self.h/2)) * 100, 0 )
    end
    love.graphics.draw( self.mesh, self.x, self.y )
    love.graphics.pop()
end

function Stick:update()
    if self.grabbed then
        local prevX = self.x
        self.x = love.mouse.getX() + self.touchOffset[1]
        self.y = love.mouse.getY() + self.touchOffset[2]
        if self.x - prevX < -2 then
            self.dir = -1
        elseif self.x - prevX > 2 then
            self.dir = 1
        end
    end
end

function Stick:isInside( x, y )
    return math.abs( self.x - x ) <= self.w/2 and math.abs( self.y - y ) <= self.h/2
end

function Stick:mousepressed( x, y, button, isTouch )
    self.grabbed = self:isInside( x, y )
    if self.grabbed then
        self.touchOffset[1] = self.x - x
        self.touchOffset[2] = self.y - y
        self.dir = 0
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
