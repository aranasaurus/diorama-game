//
//  TouchEvent.swift
//  diorama
//
//  Created by Ryan Arana on 10/3/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import Foundation
import SpriteKit

struct TouchEvent: InputEventType {
    let eventID: Int = 0
    let originatingNode: SKNode
    let location: CGPoint
    let previousLocation: CGPoint

    var delta: CGVector {
        let d = location - previousLocation
        return CGVector(dx: d.x, dy: d.y)
    }

    init(_ touch: UITouch, originatingNode: SKNode) {
        self.originatingNode = originatingNode
        self.location = touch.locationInNode(originatingNode)
        self.previousLocation = touch.previousLocationInNode(originatingNode)
    }

    func locationInNode(node: SKNode) -> CGPoint {
        return self.originatingNode.convertPoint(location, toNode: node)
    }

    func previousLocationInNode(node: SKNode) -> CGPoint {
        return self.originatingNode.convertPoint(previousLocation, toNode: node)
    }
}