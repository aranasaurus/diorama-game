require( "ext/cupid" )

function love.conf( t )
    t.identity = "diorama-game"
    t.version = "0.9.2-iOS"
    t.author = "@aranasaurus"

    t.window.highdpi = true
    t.window.title = "Diorama"
    t.window.width = 1024
    t.window.height = 768
    t.window.resizable = true
    t.window.borderless = true
    t.window.msaa = 16
    t.accelerometerjoystick = false
    t.window.orientations = {
        landscapeleft = true, landscaperight = true,
        portrait = false, portraitupsidedown = false,
    }

    t.modules.joystick = false
    t.modules.physics = false
end
