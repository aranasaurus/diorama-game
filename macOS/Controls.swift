//
//  Controls.swift
//  diorama
//
//  Created by Ryan Arana on 9/19/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

extension GameScene {
    override func mouseDown(event: NSEvent) {
        guard let stick = stick where stick.containsPoint(event.locationInNode(self)) else { return }

        stick.grabbedLocation = event.locationInNode(stick)
    }

    override func mouseDragged(event: NSEvent) {
        guard let stick = stick where stick.grabbedLocation != nil else { return }

        stick.position = event.locationInNode(self)
    }

    override func mouseUp(event: NSEvent) {
        stick?.grabbedLocation = nil
    }
}
