require( "stick" )

local stick = {}
local t = 0
local lastUpdate = 0
local updateInterval = 0.25
local statsFmt = "FPS: %d\n MEM: %.1fKB"
local memCount = collectgarbage( "count" )

function love.load( arg )
    Stick.loadMesh()
    stick = Stick:new( love.graphics.getWidth()/2, love.graphics.getHeight()/2 )
end

function love.update( dt )
    t = t + dt
    stick:update( dt )
end

function love.draw()
    stick:draw()
    local w, h = love.graphics.getDimensions()
    local f = love.graphics.getFont()
    if stick.debugText ~= nil then
        local scl = 2 * love.window.getPixelScale()
        local lines = 4
        love.graphics.setColor( 255, 255, 255, 255 * 0.66 )
        love.graphics.printf( stick.debugText, 10, h - f:getHeight()*lines*scl, w/scl, "left", 0, scl, scl )
    end

    if t - lastUpdate > updateInterval then
        lastUpdate = t
        memCount = collectgarbage( "count" )
    end
    local stats = string.format(statsFmt, love.timer.getFPS(), memCount )
    love.graphics.printf( stats, 10, 10, w - 20, "left", 0, love.window.getPixelScale(), love.window.getPixelScale() )
end

function love.mousepressed( x, y, button, isTouch )
    stick:mousepressed( x, y, button, isTouch )
end

function love.mousereleased( x, y, button, isTouch )
    stick:mousereleased( x, y, button, isTouch )
end

