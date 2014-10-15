Ship = {}

function Ship.getVerts( image, w, h )
    if w == nil then
        w = image:getWidth()
    end
    if h == nil then
        h = image:getHeight()
    end

    local coords = {
        left = -w/2,
        right = w/2,
        top = -h/2,
        bottom = h/2,
    }
    local uv = {
        left = 0,
        right = 1,
        top = 0,
        bottom = 1,
    }

    local verts = {
        {
            coords.left, coords.top,
            uv.left, uv.top,
        },
        {
            coords.right, coords.top,
            uv.right, uv.top,
        },
        {
            coords.right, coords.bottom,
            uv.right, uv.bottom,
        },
        {
            coords.left, coords.bottom,
            uv.left, uv.bottom,
        },
    }

    return verts
end

function Ship:newShip( image, verts )
    local s = {}
    setmetatable( s, self )
    self.__index = self

    local verts = verts or Ship.getVerts( image )
    s.mesh = love.graphics.newMesh( verts, image, "fan" )

    return s
end

function Ship:draw()
    love.graphics.draw( self.mesh, 0, 0 )
end

--[[
Ship.colors = {
        { 185, 185, 185 },
        { 255, 185, 185 },
        { 185, 255, 185 },
        { 185, 185, 255 }
}

Ship.activeColors = {
}

function Ship:new( w, h, c )
    local s = {}
    setmetatable( s, self )
    self.__index = self

    s.w, s.h = w, h
    s.dir = 0

    s.body = {
        mode = "fill",
        x = 0, y = 0,
        w = 1, h = 1
    }
    s.colorIndex = 0
    if c then
        s:setColor( c )
    else
        s:setColor( math.random( #Ship.colors ) )
    end

    s.fin = {
        mode = "fill",
        color = { 205, 30, 30 },
        x = 0, y = 0,
        w = 0.25, h = 0.75
    }

    s.wing = {
        mode = "fill",
        color = { 205, 30, 30 },
        w = 0.5, h = 0.125
    }
    s.wing.x = w/2 - s.wing.w * w/2
    s.wing.y = h/2 - s.wing.h * h/2

    s.tape = {
        mode = "fill",
        color = { 255, 255, 255, 255 * 0.5 },
        w = w/2,
        h = 0.33
    }
    s.tape.x = s.w/2 - s.w * s.tape.w/2
    s.tape.y = s.wing.y + s.h * s.wing.h + s.h * s.tape.h/6

    s.wheels = {
        mode = "fill",
        innerColor = { 255, 30, 30 },
        outerColor = { 30, 30, 255 },
        outerRad = h * 0.5,
        innerRad = h * 0.25,
        locations = {
            { x = 0, y = h },
            { x = w, y = h }
        }
    }
    s.wheels.locations[1].x = s.wheels.innerRad
    s.wheels.locations[2].x = w - s.wheels.innerRad
    s.wheels = nil

    s.flames = {
        on = false,
        mode = "fill",
        innerColor = { 255, 200, 55, 255 },
        innerScale = 0.66,
        outerColor = { 255, 0, 0, 255 },
        outerScale = 1.0,
        d = 0.25,
        x = 0,
        y = s.h/2,
        w = 1.0,
        h = 1.25
    }

    return s
end

function Ship:draw()
    love.graphics.push()

    if self.dir < 0 then
        love.graphics.scale( -1, 1 )
    end

    function drawRect( item )
        love.graphics.setColor( item.color )
        love.graphics.rectangle( item.mode, item.x, item.y, item.w * self.w, item.h * self.h )
    end

    if self.dir < 0 then
        drawRect( self.body )
        drawRect( self.wing )
        drawRect( self.tape )
    else
        drawRect( self.body )
        drawRect( self.wing )
    end

    if self.flames.on then
        local flameHeight = self.flames.h * self.h
        local flameWidth = self.flames.w * self.w
        function drawFlame( scale, color )
            love.graphics.push()
            love.graphics.setColor( color )
            love.graphics.translate( self.flames.x - (self.flames.x * scale),
                self.flames.y - (self.flames.y * scale) )
            love.graphics.scale( scale )
            love.graphics.polygon( self.flames.mode,
                self.flames.x, self.flames.y,
                self.flames.x, self.flames.y - flameHeight/4,
                self.flames.x - flameWidth/4, self.flames.y - flameHeight/2,
                self.flames.x - flameWidth/4.7, self.flames.y - flameHeight/3.4,
                self.flames.x - flameWidth/2.15, self.flames.y - flameHeight/2.6,
                self.flames.x - flameWidth/2.7, self.flames.y - flameHeight/5.6,
                self.flames.x - flameWidth, self.flames.y,
                self.flames.x - flameWidth/2.7, self.flames.y + flameHeight/5.6,
                self.flames.x - flameWidth/2.15, self.flames.y + flameHeight/2.6,
                self.flames.x - flameWidth/4.7, self.flames.y + flameHeight/3.4,
                self.flames.x - flameWidth/4, self.flames.y + flameHeight/2,
                self.flames.x, self.flames.y + flameHeight/4
            )
            love.graphics.pop()
        end

        drawFlame( self.flames.outerScale * self.flames.d, self.flames.outerColor )
        drawFlame( self.flames.innerScale * self.flames.d, self.flames.innerColor )
    end

    love.graphics.setColor( self.fin.color )
    love.graphics.polygon( self.fin.mode,
        self.fin.x, self.fin.y,
        self.fin.x + (self.fin.w * self.w), self.fin.y,
        self.fin.x, self.fin.y - (self.fin.h * self.h)
    )

    if self.wheels ~= nil then
        love.graphics.setColor( self.wheels.outerColor )
        love.graphics.circle( self.wheels.mode, self.wheels.locations[1].x, self.wheels.locations[1].y, self.wheels.outerRad, 100 )
        love.graphics.circle( self.wheels.mode, self.wheels.locations[2].x, self.wheels.locations[2].y, self.wheels.outerRad, 100 )

        love.graphics.setColor( self.wheels.innerColor )
        love.graphics.circle( self.wheels.mode, self.wheels.locations[1].x, self.wheels.locations[1].y, self.wheels.innerRad, 100 )
        love.graphics.circle( self.wheels.mode, self.wheels.locations[2].x, self.wheels.locations[2].y, self.wheels.innerRad, 100 )
    end

    love.graphics.pop()
end

function Ship:update( dt )
end

function Ship:changeColor( dir )
    local curIndex = self.colorIndex

    local startIndex = curIndex + dir
    if startIndex > #Ship.colors then
        startIndex = 1
    elseif startIndex < 1 then
        startIndex = #Ship.colors
    end

    local endIndex = #Ship.colors
    if dir < 0 then
        endIndex = 1
    end

    for i = startIndex, endIndex, dir do
        if not Ship.activeColors[i] then
            self:setColor( i )
            break
        end
    end

    if self.colorIndex == curIndex then
        self:setRandomColor()
    end
end

function Ship:setColor( color )
    if type(color) == "number" then
        if self.colorIndex > 0 then
            Ship.activeColors[self.colorIndex] = false
        end
        Ship.activeColors[color] = true
        self.colorIndex = color
        self.body.color = Ship.colors[color]
    elseif type(color) == "table" then
        if self.colorIndex > 0 then
            Ship.activeColors[self.colorIndex] = false
        end
        self.colorIndex = 0
        self.body.color = color
    else
        print( "Tried to set color of ship to '" .. type(color) .. "'" )
    end
end

function Ship:setRandomColor()
    self:setColor( { math.random(255), math.random(255), math.random(255) } )
end
--]]

