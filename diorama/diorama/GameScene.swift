//
//  GameScene.swift
//  diorama
//
//  Created by Ryan Arana on 8/25/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"stick")
            
            sprite.xScale = 0.15
            sprite.yScale = 0.35
            sprite.position = location
            sprite.color = UIColor(hue: 0.1095, saturation: 0.8329, brightness: 1, alpha: 1)
            sprite.colorBlendFactor = 0.8
            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))

            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
