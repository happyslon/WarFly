//
//  Enemy.swift
//  WarFly
//
//  Created by Сергей Поляновский on 26/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    static var textureAtlas: SKTextureAtlas?
    var enemyTexture: SKTexture!
    
    init(_ enemyTexture: SKTexture){
        
        //let texture = Enemy.textureAtlas?.textureNamed("airplane_4ver2_13")
        super.init(texture: enemyTexture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.3
        self.yScale = -0.3
        self.zPosition = 30
        self.name = "sprite"
        
        self.physicsBody = SKPhysicsBody(texture: enemyTexture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy.rawValue
        //self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.none.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
        
    }
    func flySpiral()  {
        
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 3
        let timeVertical: Double = 5
        let moveLetf = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLetf.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        
        let randomNumber = Int(arc4random_uniform(2))
        
        let asideMovementSequence = randomNumber == EnemyDirection.left.rawValue ? SKAction.sequence([moveLetf, moveRight]) :
        SKAction.sequence([moveRight, moveLetf])
        
  //      let asideMovementSequence = SKAction.sequence([moveLetf,moveRight])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement,forwardMovement])
        self.run(groupMovement)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum EnemyDirection: Int{
    case left = 0
    case right
}
