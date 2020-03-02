//
//  Shot.swift
//  WarFly
//
//  Created by Сергей Поляновский on 27/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {
    
    let screenSize = UIScreen.main.bounds
    
    let initialSize = CGSize(width: 187, height: 237)
    // let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")
     let textureAtlas: SKTextureAtlas!
     var animationSpriteArray = [SKTexture]()
     var textureNameBeginsWith = ""
     
     init(textureAtlas: SKTextureAtlas){
         self.textureAtlas = textureAtlas
         let textureName = textureAtlas.textureNames.sorted()[0]
         
         let texture = textureAtlas.textureNamed(textureName)
         textureNameBeginsWith = String(textureName.dropLast(6)) //   откидываем в названии 01.png
         super.init(texture: texture,color: .clear, size: initialSize)
         self.setScale(0.1)
         self.name = "shot"
         self.zPosition = 30
        
         self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
         self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = BitMaskCategory.shot.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue
        
     }
     
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func startMovement(){
         performRotation()
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2)
         run(moveForward)
     }
     
     func performRotation(){
         for i in 1...32{
             let number = String(format: "%02d", i)
             animationSpriteArray.append(SKTexture(imageNamed: textureNameBeginsWith + number.description))
             
         }
         SKTexture.preload(animationSpriteArray){
             let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
             let rotationForever = SKAction.repeatForever(rotation)
             self.run(rotationForever)
         }
     }

}
