//
//  Controls.swift
//  diorama
//
//  Created by Ryan Arana on 9/19/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

extension GameScene {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard
            let touch = touches.first,
            stick = stick
            where stick.containsPoint(touch.locationInNode(self))
            else { return }

        stick.grabbedLocation = touch.locationInNode(stick)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard
            let stick = stick,
            let _ = stick.grabbedLocation,
            let location = touches.first?.locationInNode(self)
            else { return }

        stick.position = location
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        stick?.grabbedLocation = nil
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        stick?.grabbedLocation = nil
    }
}