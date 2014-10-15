require( "ext/cupid" )

function love.conf( t )
    t.window.highdpi = true
    t.window.title = "Diorama"
    t.window.orientations = {
        landscapeleft = true, landscaperight = true,
        portrait = false, portraitupsidedown = false,
    }
end
