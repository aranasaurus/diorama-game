//
//  Stick.swift
//  diorama
//
//  Created by Ryan Arana on 9/19/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

private let max_tilt = CGFloat(M_PI / 12.0)
private let max_velocity_for_tilt = CGFloat(12)
private let tilt_timeout = 0.25
private let tilt_anim_duration = 0.125
private let reset_tilt_anim_duration = 0.25

class Stick: SKSpriteNode {
    var grabbedLocation: CGPoint? {
        didSet {
            guard let grabbedLocation = grabbedLocation else { return }

            anchorPoint = okr_convertPointToUnitPoint(grabbedLocation)
            position = position + grabbedLocation
        }
    }

    var trackingEventID: Int?
    let resetTiltAction = SKAction.rotateToAngle(0, duration: reset_tilt_anim_duration, shortestUnitArc: true)
}

extension Stick: InputHandlerType {

    func beginInput(event: InputEventType) {
        trackingEventID = event.eventID
        grabbedLocation = event.locationInNode(self)
    }

    func handleInput(event: InputEventType) {
        guard event.eventID == trackingEventID else { return }

        // no matter what happens reset the tilt to 0 after not moving for a bit
        defer {
            runAction(SKAction.sequence([
                SKAction.waitForDuration(tilt_timeout),
                resetTiltAction
            ]),
            withKey: "resetTilt")
        }
        position = event.locationInNode(self.parent!)

        // calculate the amount of tilt using the x-distance traveled on a scale of
        // 1-max_velocity_for_tilt and multiply that by the max_tilt.
        var tilt = max_tilt * (event.delta.dx / max_velocity_for_tilt)
        // Keep tilt between -max_tilt and +max_tilt
        if tilt > 0 {
            tilt = -min(tilt, max_tilt)
        } else {
            tilt = -max(tilt, -max_tilt)
        }

        // animate the change in tilt/rotation
        runAction(SKAction.rotateToAngle(tilt, duration: tilt_anim_duration, shortestUnitArc: true))
    }

    func endInput(event: InputEventType) {
        guard event.eventID == trackingEventID else { return }

        trackingEventID = nil
        grabbedLocation = nil
    }
}

