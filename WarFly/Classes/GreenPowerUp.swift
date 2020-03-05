//
//  GreenPowerUp.swift
//  WarFly
//
//  Created by Сергей Поляновский on 26/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class GreenPowerUp: PowerUp{
    
    init(){
        let textureAtlas = Assets.shared.greenPowerUpAtlas//SKTextureAtlas(named: "GreenPowerUp")
        super.init(textureAtlas: textureAtlas)
        name = "greenPowerUp"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
