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
        guard let touch = touches.first else { return }
        beginInput(TouchEvent(touch, originatingNode: self))
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        handleInput(TouchEvent(touch, originatingNode: self))
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        endInput(TouchEvent(touch, originatingNode: self))
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard let touch = touches?.first else { return }
        endInput(TouchEvent(touch, originatingNode: self))
    }
}

