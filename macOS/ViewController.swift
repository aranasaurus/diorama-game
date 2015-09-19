//
//  ViewController.swift
//  Diorama
//
//  Created by Ryan Arana on 9/19/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController, GameViewDelegate {

    var scene: GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scene = GameScene(fileNamed: "GameScene")
        scene.scaleMode = .AspectFill

        let skView = self.view as! GameView
        skView.delegate = self
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }

    override func mouseDown(event: NSEvent) {
        scene.tapped(event.locationInNode(scene))
    }
}

/*
 * Apparently SKView eats up all the mouse events, so this delegate protocol and SKView subclass fix that :P
 */
protocol GameViewDelegate {
    func mouseDown(theEvent: NSEvent)
}

class GameView: SKView {
    var delegate: GameViewDelegate?
    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
        delegate?.mouseDown(theEvent)
    }
}

