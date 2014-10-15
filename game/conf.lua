require( "ext/cupid" )

function love.conf( t )
    t.window.highdpi = true
    t.window.title = "Diorama"
    t.window.width = 1024
    t.window.height = 768
    t.window.resizable = true
    t.window.borderless = true
    t.accelerometerjoystick = false
    t.window.orientations = {
        landscapeleft = true, landscaperight = true,
        portrait = false, portraitupsidedown = false,
    }
end
