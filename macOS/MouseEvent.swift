//
//  MouseEvent.swift
//  diorama
//
//  Created by Ryan Arana on 10/4/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import Foundation
import SpriteKit

struct MouseEvent: InputEventType {
    var event: NSEvent
    var eventID: Int { return event.eventNumber }

    var delta: CGVector {
        return CGVector(dx: event.deltaX, dy: event.deltaY)
    }

    init(_ event: NSEvent) {
        self.event = event
    }

    func locationInNode(node: SKNode) -> CGPoint {
        return event.locationInNode(node)
    }

    func previousLocationInNode(node: SKNode) -> CGPoint {
        let location = locationInNode(node)
        return CGPoint(x: location.x - event.deltaX, y: location.y - event.deltaY)
    }
}