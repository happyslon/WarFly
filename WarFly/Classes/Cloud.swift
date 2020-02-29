//
//  Cloud.swift
//  WarFly
//
//  Created by Сергей Поляновский on 23/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    static func populateSprite(at point: CGPoint?) -> Cloud {
        
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point ?? randomPoint()
        cloud.zPosition = 10
        cloud.name = "sprite"
        cloud.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        cloud.run(move(from: cloud.position))
        return cloud
    }
    
 

    
    fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNumder = distribution.nextInt()
        let imageName = "cl" + "\(randomNumder)"
        
        return imageName
        
    }
    
    fileprivate static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 10, highestValue: 30)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    fileprivate static func move(from point: CGPoint) -> SKAction {
        
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 100.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }


}
