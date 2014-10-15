require( "stick" )

local stick = {}

function love.load( arg )
    Stick.loadMesh()
    stick = Stick:new( love.graphics.getWidth()/2, love.graphics.getHeight()/2 )
end

function love.update( dt )
    stick:update( dt )
end

function love.draw()
    stick:draw()
    if stick.debugText ~= nil then
        local w, h = love.graphics.getDimensions()
        local f = love.graphics.getFont()
        local scl = 2 * love.window.getPixelScale()
        local lines = 4
        love.graphics.setColor( 255, 255, 255, 255 * 0.66 )
        love.graphics.printf( stick.debugText, 0, h - f:getHeight()*lines*scl, w/scl, "left", 0, scl, scl )
    end
end

function love.mousepressed( x, y, button, isTouch )
    stick:mousepressed( x, y, button, isTouch )
end

function love.mousereleased( x, y, button, isTouch )
    stick:mousereleased( x, y, button, isTouch )
end

