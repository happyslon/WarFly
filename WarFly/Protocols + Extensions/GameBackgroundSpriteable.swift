//
//  GameBackgroundSpriteable.swift
//  WarFly
//
//  Created by Сергей Поляновский on 23/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//
import SpriteKit
import GameplayKit

protocol GameBackgroundSpriteable {
    static func populateSprite(at point: CGPoint?) -> Self
}
extension GameBackgroundSpriteable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 400, highestValue: Int(screen.size.height) + 500)
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y)
    }
}
