//
//  Stick.swift
//  diorama
//
//  Created by Ryan Arana on 9/19/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

class Stick: SKSpriteNode {
    var grabbedLocation: CGPoint? {
        didSet {
            guard let grabbedLocation = grabbedLocation else { return }

            anchorPoint = okr_convertPointToUnitPoint(grabbedLocation)
            position = position + grabbedLocation
        }
    }
}