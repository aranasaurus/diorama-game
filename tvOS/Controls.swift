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
        stick?.grabbedLocation = stick?.okr_convertUnitPointToAnchoredPoint(CGPoint(x: 0.5, y: 0.2))
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard
            let stick = stick,
            let _ = stick.grabbedLocation,
            let touch = touches.first
            else { return }

        stick.position = stick.position + (touch.locationInNode(self) - touch.previousLocationInNode(self))
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let stick = stick else { return }

        stick.grabbedLocation = nil
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard let stick = stick else { return }

        stick.grabbedLocation = nil
    }
}

