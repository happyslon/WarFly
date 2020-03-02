//
//  Assets.swift
//  WarFly
//
//  Created by Сергей Поляновский on 27/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class Assets{
    
    static let shared = Assets()
    var isLoaded = false
    let yellowShotAtlas = SKTextureAtlas(named: "YellowAmmo")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named:  "BluePowerUp")
    let playerPlaneUpAtlas = SKTextureAtlas(named: "PlayerPlane")
    
    func preloadAssets(){
        
        yellowShotAtlas.preload {
            
        }
        enemy_1Atlas.preload {
            
        }
        enemy_2Atlas.preload {
            
        }
        greenPowerUpAtlas.preload {
            
        }
        bluePowerUpAtlas.preload {
            
        }
        playerPlaneUpAtlas.preload {
            
        }
        
    }
    

}
