require( "ship" )

Stick = {}

local DEAD_ZONE = 0
local MAX_TILT = math.pi/16
local TILT_TIMEOUT = 0.08

-- new returns a new Stick object centered at x/y
function Stick:new( x, y )
    local s = {}
    setmetatable( s, self )
    self.__index = self

    s.x = x
    s.y = y
    s.grabbed = false
    s.touchOffset = { 0, 0 }
    s.touchID = -1
    s.dir = 0
    s.t = 0
    s.resetDir = false
    s.resetDirTime = 0

    local shipImage = love.graphics.newImage( "gfx/ship.png" )
    local verts = Ship.getVerts( shipImage, self.w * 5.0, self.h/4 )
    s.ship = Ship:newShip( shipImage, verts )

    return s
end

-- loadMesh creates and stores the mesh used for all Sticks on the Stick "class". It should only
-- be called once and all instances of Stick will be able to access the mesh and w/h properties
-- through self.
function Stick.loadMesh()
    local texture = love.graphics.newImage( "gfx/stick.png" )
    local tint = { 255, 205, 135, }
    local size = { love.graphics.getWidth() * 0.028, love.graphics.getHeight() * 0.5 }
    -- coords assumes the x/y in the draw method will be at the center of the mesh
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

    -- all sticks will use the same mesh and have the same w/h
    Stick.mesh = love.graphics.newMesh( verts, texture, "fan" )
    Stick.w = size[1]
    Stick.h = size[2]
end

function Stick:draw()
    love.graphics.push()
    -- If we're being dragged, grab the touch location and rotate around it
    if self.grabbed and self.dir ~= 0 then
        local touchPoint = {
            self.x + self.touchOffset[1],
            self.y + self.touchOffset[2],
        }
        
        love.graphics.translate( touchPoint[1], touchPoint[2] )
        love.graphics.rotate( self.dir * MAX_TILT )
        love.graphics.translate( -touchPoint[1], -touchPoint[2] )
    end

    love.graphics.draw( self.mesh, self.x, self.y )
    -- draw the ship up top
    love.graphics.translate( self.x, self.y - self.h/2 )
    if self.dir < 0 then
        love.graphics.scale( -1, 1 )
    end
    self.ship:draw()
    love.graphics.pop()
end

function Stick:update( dt )
    self.t = self.t + dt

    local id
    local x
    local y
    local pressure
    local found = false

    -- find our touch
    for i=1, love.touch.getTouchCount() do
        id, x, y, pressure = love.touch.getTouch( i )
        if id == self.touchId then
            found = true
            break
        end
    end

    -- if no touch found use the mouse location (we're on desktop)
    if not found then
        x, y = love.mouse.getX(), love.mouse.getY()
    end

    self:handleMovement( x, y )

    if self.resetDir and self.t > self.resetDirTime then
        self.dir = 0
        self.resetDir = false
    end
end

-- isInside checks if a given world coordinate is inside the stick's hitbox
function Stick:isInside( x, y )
    return math.abs( self.x - x ) <= self.w/2 and math.abs( self.y - y ) <= self.h/2
end

-- handleMovement receives the x and y location of the input device (touch or mouse)
-- and moves the stick an appropriate amount using the touchOffset location. It also
-- sets the dir property as needed based on velocity.
function Stick:handleMovement( x, y )
    -- only move if we're being dragged
    if self.grabbed then
        local prevX = self.x
        self.x = x + self.touchOffset[1]
        self.y = y - self.touchOffset[2]
        local dx = self.x - prevX
        if dx < -DEAD_ZONE then
            self.dir = -1
            self.resetDir = false
        elseif dx > DEAD_ZONE then
            self.dir = 1
            self.resetDir = false
        elseif not self.resetDir and self.dir ~= 0 then
            self.resetDir = true
            self.resetDirTime = self.t + TILT_TIMEOUT
        end
    end
end

function Stick:mousepressed( x, y, button, isTouch )
    self.grabbed = self:isInside( x, y )
    if self.grabbed then
        self.touchOffset[1] = self.x - x
        self.touchOffset[2] = -self.y + y
        self.dir = 0
    end
end

function Stick:mousereleased( x, y, button, isTouch )
    self.grabbed = false
    if self.grabbed then
        self.touchOffset[1] = 0
        self.touchOffset[2] = 0
        self.dir = 0
    end
end

