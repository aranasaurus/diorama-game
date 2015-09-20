//
//  GameViewController.swift
//  diorama
//
//  Created by Ryan Arana on 8/25/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()

        scene = GameScene(fileNamed: "GameScene")
        scene.scaleMode = .AspectFit

        let skView = self.view as! SKView
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Landscape
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
