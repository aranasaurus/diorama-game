//
//  GameScene.swift
//  diorama
//
//  Created by Ryan Arana on 8/25/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let stickTexture = SKTexture(image: R.image.stick!)
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(texture: stickTexture)
            sprite.position = location
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
