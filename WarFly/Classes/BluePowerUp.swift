//
//  BluePowerUp.swift
//  WarFly
//
//  Created by Сергей Поляновский on 26/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class BluePowerUP: PowerUp{
    
    init(){
        let textureAtlas = Assets.shared.bluePowerUpAtlas//SKTextureAtlas(named: "BluePowerUp")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
