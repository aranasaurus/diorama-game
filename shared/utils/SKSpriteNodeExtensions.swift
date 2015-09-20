//
//  SKSpriteNodeExtensions.swift
//  diorama
//
//  Created by Ryan Arana on 9/19/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

// TODO: Write tests for these!
extension SKSpriteNode {
    func okr_convertUnitPointToRootPoint(point: CGPoint) -> CGPoint {
        return CGPoint(x: size.width * xScale * point.x, y: size.height * yScale * point.y)
    }

    func okr_convertPointToRootPoint(point: CGPoint) -> CGPoint {
        let anchorPos = okr_convertUnitPointToRootPoint(anchorPoint)

        return anchorPos + point
    }

    func okr_convertPointToUnitPoint(point: CGPoint) -> CGPoint {
        let convertedPoint = okr_convertPointToRootPoint(point)
        let unitPoint = CGPoint(x: convertedPoint.x / (size.width * xScale), y: convertedPoint.y / (size.height * yScale))
        return unitPoint
    }

    func okr_convertUnitPointToAnchoredPoint(point: CGPoint) -> CGPoint {
        let pos = okr_convertUnitPointToRootPoint(point)
        let anchorPos = okr_convertUnitPointToRootPoint(anchorPoint)
        let relativePos = pos - anchorPos
        return relativePos
    }
}