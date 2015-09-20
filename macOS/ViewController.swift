//
//  ViewController.swift
//  Diorama
//
//  Created by Ryan Arana on 9/19/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {

    var scene: GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scene = GameScene(fileNamed: "GameScene")
        scene.scaleMode = .AspectFit

        let skView = self.view as! SKView
        skView.presentScene(scene)
    }
}