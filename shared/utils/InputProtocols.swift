//
//  InputProtocols.swift
//  diorama
//
//  Created by Ryan Arana on 9/29/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

protocol InputEventType {
    var eventID: Int { get }
    var delta: CGVector { get }
    
    func locationInNode(node: SKNode) -> CGPoint
    func previousLocationInNode(node: SKNode) -> CGPoint
}

protocol InputHandlerType {
    func beginInput(event: InputEventType)
    func handleInput(event: InputEventType)
    func endInput(event: InputEventType)
}
