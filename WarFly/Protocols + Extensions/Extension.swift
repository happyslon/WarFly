//
//  Extension.swift
//  WarFly
//
//  Created by Сергей Поляновский on 28/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

extension SKPhysicsBody{
    var category: BitMaskCategory{
        get{
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        
        set{
            self.categoryBitMask = newValue.rawValue
        }
    }
}
