require( "stick" )

local sticks = {}

function love.load( arg )
    if love.window.isTouchScreen( 0 ) then
        love.window.setMode( 0, 0, {
            fullscreen = true,
        } )
    else
        love.window.setMode( 1024, 768, {
            resizable = true
        } ) 
    end
    Stick.loadMesh()
    table.insert(sticks, Stick:new( love.graphics.getWidth()/2, love.graphics.getHeight()/2 ) )
end

function love.update( dt )
    for _, stick in pairs(sticks) do
        stick:update()
    end
end

function love.draw()
    for _, stick in pairs(sticks) do
        stick:draw()
    end
end

function love.resize( w, h )
    print( "Resized: " .. w .. ", " .. h )
end

function love.mousepressed( x, y, button, isTouch )
    for _, stick in pairs(sticks) do
        stick:mousepressed( x, y, button, isTouch )
    end
end

function love.mousereleased( x, y, button, isTouch )
    for _, stick in pairs(sticks) do
        stick:mousereleased( x, y, button, isTouch )
    end
end

