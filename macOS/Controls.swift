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
        beginInput(MouseEvent(event))
    }

    override func mouseDragged(event: NSEvent) {
        handleInput(MouseEvent(event))
    }

    override func mouseUp(event: NSEvent) {
        endInput(MouseEvent(event))
    }
}

