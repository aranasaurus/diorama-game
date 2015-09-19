//
//  GameScene.swift
//  diorama
//
//  Created by Ryan Arana on 8/25/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let stickTexture = SKTexture(imageNamed: "stick")
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

    func tapped(location: CGPoint) {
        let sprite = SKSpriteNode(texture: stickTexture)
        sprite.position = location
        self.addChild(sprite)
    }
}
