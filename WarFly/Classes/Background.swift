//
//  Background.swift
//  WarFly
//
//  Created by Сергей Поляновский on 22/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
    
    static func populateBackground(at point: CGPoint) -> Background{
        let background = Background(imageNamed: "background")
        background.position = point
        background.zPosition = 0
       
        
        return background
    }
}
