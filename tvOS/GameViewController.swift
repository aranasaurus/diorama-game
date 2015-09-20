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
    override func viewDidLoad() {
        super.viewDidLoad()

        scene = GameScene(fileNamed: "GameScene")
        scene.scaleMode = .AspectFit

        let skView = self.view as! SKView
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
