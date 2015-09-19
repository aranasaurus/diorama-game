//
//  GameViewController.swift
//  Diorama
//
//  Created by Ryan Arana on 9/19/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene!
    var lastTouchLocation = CGPoint.zero
    override func viewDidLoad() {
        super.viewDidLoad()

        scene = GameScene(fileNamed: "GameScene")
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouchLocation = touches.first?.locationInNode(scene) ?? CGPoint(x: scene.size.width/2.0, y: scene.size.height/2.0)
    }

    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        scene.tapped(lastTouchLocation)
    }
}
