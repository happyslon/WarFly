//
//  YellowShot.swift
//  WarFly
//
//  Created by Сергей Поляновский on 27/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class YellowShot: Shot{
    
    init(){
        let textureAtlas = Assets.shared.yellowShotAtlas// SKTextureAtlas(named: "YellowAmmo")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
