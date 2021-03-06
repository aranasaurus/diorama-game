//
//  GameScene.swift
//  diorama
//
//  Created by Ryan Arana on 8/25/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var stick: Stick? {
        return childNodeWithName("stick") as? Stick
    }

    override func didMoveToView(view: SKView) {
        #if DEBUG
            view.showsFPS = true
            view.showsNodeCount = true
            view.ignoresSiblingOrder = true
        #endif

        /* Setup your scene here */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

extension GameScene: InputHandlerType {
    func beginInput(event: InputEventType) {
        guard let stick = stick where stick.containsPoint(event.locationInNode(self)) else { return }
        stick.beginInput(event)
    }

    func handleInput(event: InputEventType) {
        stick?.handleInput(event)
    }

    func endInput(event: InputEventType) {
        stick?.endInput(event)
    }
}

