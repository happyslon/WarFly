//
//  GameScene.swift
//  WarFly
//
//  Created by Сергей Поляновский on 22/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: ParentScene {
    
    var backgroundMusic: SKAudioNode!
    
    // let sceneManager = SceneManager.shared //перенесли в ParentScene
    
    let hud = HUD()
    
    let shot = YellowShot()
    
    var player: PlayerPlane!//заменили SKSpriteNode
    
    let tapRec = UITapGestureRecognizer()
    
    let screen = UIScreen.main.bounds
    
    let screenSize = UIScreen.main.bounds.size
    
    var lives = 3 {
        didSet {
            switch lives {
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 2:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = true
            case 1:
                hud.life1.isHidden = false
                hud.life2.isHidden = true
                hud.life3.isHidden = true
            default:
                break
            }
        }
    }
    
    var pauseNode = SKNode() // нужно поставить на паузу какойто один элемент
    /*
     создаем Node и добавляем в него нужный элемент (которым хотим управлять)
     */
    
    
    override func didMove(to view: SKView) {
        
        gameSetting.loadGameSettings()
        
        if gameSetting.isMusic && backgroundMusic == nil {
            
            if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "m4a"){
                backgroundMusic = SKAudioNode(url: musicURL)
                addChild(backgroundMusic)
            }
            
        }
        

        
        
        //добавляем нод на сцену
        //addChild(pauseNode)
        
        self.scene?.isPaused = false
        
        // checking if scene persists
        guard sceneManager.gameScene == nil else {return}
        sceneManager.gameScene = self
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        // let screen = UIScreen.main.bounds
        
        configureStartScene()
        spawnClouds()
        spawnIslands()
        
        //        for _ in 1...5{
        //            let x: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        //            let y: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height)))
        //
        //            let island = Island.populateSprite(at: CGPoint(x: x, y: y))
        //            self.addChild(island)
        //
        //
        //            let cloud = Cloud.populateSprite(at: CGPoint(x: x, y: y))
        //
        //            self.addChild(cloud)
        //        }
        
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        //задержка на несколько секунд для прогрузки текстур
        //        let deadline = DispatchTime.now() + .nanoseconds(1)
        //        DispatchQueue.main.asyncAfter(deadline: deadline) { [unowned self] in
        //            self.player.performFly()
        //        }
        
        player.performFly()
        
        self.addChild(player)
        
        //Power
        spawnPowerUp()//======
        
        // подгружаем врага
        //spawnEnemy()
        spawnEnemies()//===============
        
        createHUD()
        
        tapRec.addTarget(self, action: #selector(GameScene.tappedView( _:)))
        self.view?.addGestureRecognizer(tapRec)
        
        
        
    }
    
    fileprivate func createHUD(){
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
    }
    
    fileprivate func configureStartScene(){
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        self.addChild(background)
    }
    
    fileprivate func spawnPowerUp(){
        let waitRandom = Double(arc4random_uniform(10))
        let spawnPowerUpWait = SKAction.wait(forDuration: waitRandom)
        let spawnPowerUpAction = SKAction.run { [unowned self] in
            
            
            
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? BluePowerUP() : GreenPowerUp()
            let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
            
            
            powerUp.startMovement()
            //powerUp.performRotation()
            powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
            //self.pauseNode.addChild(powerUp) // добавлем нужный(для управления "пауза") элемент в pauseNode
            self.addChild(powerUp)
        }
        
        let spawnPowerUpSequence = SKAction.sequence([spawnPowerUpWait, spawnPowerUpAction])
        let spawnPowerUpForever = SKAction.repeatForever(spawnPowerUpSequence)
        run(spawnPowerUpForever)
        
        //-----------
        
        //        let powerUpGreen = BluePowerUP()
        //        powerUpGreen.performRotation()
        //        powerUpGreen.position = CGPoint(x: self.size.width / 2 - 100, y: self.size.height / 2)
        //        self.addChild(powerUpGreen)
        
        
        //        let powerUpBlue = GreenPowerUp()
        //        powerUpBlue.performRotation()
        //        powerUpBlue.position = CGPoint(x: self.size.width / 2 + 100, y: self.size.height / 2)
        //        self.addChild(powerUpBlue)
        
    }
    
    fileprivate func spawnEnemies(){
        let wait = SKAction.wait(forDuration: 3.0)
        let spawnAction = SKAction.run {
            self.spawnSpiralOfEnemies()
        }
        self.run(SKAction.repeatForever(SKAction.sequence([wait,spawnAction])))
    }
    
    fileprivate func spawnSpiralOfEnemies(){
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas//SKTextureAtlas(named: "Enemy_1")
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas//SKTextureAtlas(named: "Enemy_2")
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
            
            //Enemy.textureAtlas = enemyTextureAtlas
            let randomN = Int(arc4random_uniform(2))
            let arrayOfAtlasses = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlasses[randomN]
            
            let waitAction = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run { [unowned self] in
                let textureNames = textureAtlas.textureNames.sorted()
                let texture = textureAtlas.textureNamed(textureNames[12])
                
                
                let enemy = Enemy(texture)
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                enemy.flySpiral()
                self.addChild(enemy)
            }
            
            let spawnEnemySequence = SKAction.sequence([waitAction, spawnEnemy])
            let spawnEnemyForever = SKAction.repeat(spawnEnemySequence, count: 3)
            self.run(spawnEnemyForever)
            
        }
        
        
    }
    
    fileprivate func spawnIslands() {
        let spawnIslandWait = SKAction.wait(forDuration: 2)
        let spawnIslandAction = SKAction.run { [unowned self] in
            let island = Island.populateSprite(at: nil)
            self.addChild(island)
        }
        
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        run(spawnIslandForever)
    }
    
    fileprivate func spawnClouds() {
        let spawnCloudWait = SKAction.wait(forDuration: 3)
        let spawnCloudAction = SKAction.run { [unowned self] in
            let cloud = Cloud.populateSprite(at: nil)
            self.addChild(cloud)
        }
        
        let spawnCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        run(spawnCloudForever)
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        //player.checkPosition()
        player.tapCheckPosition()
        
        enumerateChildNodes(withName: "sprite") { (node, stop) in
            if node.position.y < 0 {
                node.removeAllActions()
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "bluePowerUP") { (node, stop) in
            if node.position.y < 0 {
                node.removeAllActions()
                node.removeFromParent()
                //                if node.isKind(of: PowerUp.self){
                //                    print("PowerUp")
                //                }
            }
        }
        
        enumerateChildNodes(withName: "greenPowerUp") { (node, stop) in
            if node.position.y < 0 {
                node.removeAllActions()
                node.removeFromParent()
                //                if node.isKind(of: PowerUp.self){
                //                    print("PowerUp")
                //                }
            }
        }
        
        enumerateChildNodes(withName: "shot") { (node, stop) in
            if node.position.y > self.size.height {
                node.removeAllActions()
                node.removeFromParent()
            }
        }
        
    }
    
    fileprivate func playerFire(){
        let shot = YellowShot()
        shot.position = self.player.position
        shot.startMovement()
        self.addChild(shot)
        
    }
    
    //MARK: Gesture Recognizers
    
    @objc func tappedView(_ sender: UITapGestureRecognizer){
        
        playerFire()
        
        let x = sender.location(in: sender.view).x
        let widthScreen = screen.size.width
        let acceleration = (x - player.position.x) / widthScreen
        player.handleTap(acceleration, x: x)
        
        //        if (screen.size.width / 2) > x {
        //            print("left")
        //            player.handleTap(-0.1)
        //
        //        }else {
        //            print("right")
        //            player.handleTap(0.1)
        //        }
        
        
    }
    
    // отрабатывает прикосновение к экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let location = touches.first?.location(in: self) else { return  }
        let node = self.atPoint(location)
        //  if node.name == "runButton" {
        if node.name == "pause" {
            
            //и в конце нужно поставить на паузу нужный нам pauseNode
            //pauseNode.isPaused = true
            
            let transition = SKTransition.doorway(withDuration: 1.0)//crossFade(withDuration: 1.0)
            let pauseScene = PauseScence(size: self.size)
            pauseScene.scaleMode = .aspectFill
            //пауза
            sceneManager.gameScene = self //сохраним сцену
            scene?.isPaused = true
            
            self.scene?.view?.presentScene(pauseScene, transition: transition)
            
        }
    }
    
}
extension GameScene: SKPhysicsContactDelegate {
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
        let contactPoint = contact.contactPoint
        explosion?.position = contactPoint
        explosion?.zPosition = 25
        let waitExplosionAction = SKAction.wait(forDuration: 1.0)
        
        
        
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        
        switch contactCategory {
            
        case [.enemy, .player]:
            
            if contact.bodyA.node?.name == "sprite" {
                
                if contact.bodyA.node?.parent != nil {
                    contact.bodyA.node?.removeFromParent()
                    lives -= 1
                    overGameScores()
                }
                
                
            }else{
                
                if contact.bodyB.node?.parent != nil {
                    contact.bodyB.node?.removeFromParent()
                    lives -= 1
                    overGameScores()
                }
                
                
            }
   
            addChild(explosion!)
            
            self.run(waitExplosionAction) {
                explosion?.removeFromParent()
            }
            
//            if lives == 0 {
//
//                gameSetting.currentScore = hud.score
//                gameSetting.saveScores()
//
//                let gameOverScence = GameOverScene(size: self.size)
//                let transition = SKTransition.doorsCloseVertical(withDuration: 1.0)
//                gameOverScence.scaleMode = .aspectFill
//                self.scene?.view?.presentScene(gameOverScence, transition: transition)
//            }
            
        //print("1")
        case [.player, .powerUp]:
            
            //            let colorAction = SKAction.colorize(with: .green, colorBlendFactor: 1.0, duration: 0.2)
            //            let uncolorAction = SKAction.colorize(with: .green, colorBlendFactor: 0.0, duration: 0.2)
            //            let sequenceAction = SKAction.sequence([colorAction, uncolorAction])
            //            let repeatAction = SKAction.repeat(sequenceAction, count: 5)
            
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
                if contact.bodyA.node?.name == "bluePowerUP" {
                    contact.bodyA.node?.removeFromParent()
                    lives = 3
                    player.bluePowerUp()
                }else if contact.bodyB.node?.name == "bluePowerUP" {
                    contact.bodyB.node?.removeFromParent()
                    lives = 3
                    player.bluePowerUp()
                }
                
                if contact.bodyA.node?.name == "greenPowerUp"{
                    contact.bodyA.node?.removeFromParent()
                    player.greenPowerUp()
                }else if contact.bodyB.node?.name == "greenPowerUp"{
                    contact.bodyB.node?.removeFromParent()
                    player.greenPowerUp()
                }
                
            }
            
            
            
        //print("2")
        case [.shot, .enemy]:
            
            if contact.bodyA.node?.parent != nil {
                
                hud.score += 5
                
                
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                
                if gameSetting.isSound{
                   self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
                }
                
                
                addChild(explosion!)
                
                self.run(waitExplosionAction) {
                    explosion?.removeFromParent()
                }
            }
            
            
            
            
            
        //print("3")
        default: break
            //print("!!!!!")
        }
        
        /*       let bodyA = contact.bodyA.categoryBitMask
         let bodyB = contact.bodyB.categoryBitMask
         
         let player = BitMaskCategory.player
         let enemy = BitMaskCategory.enemy
         let shot = BitMaskCategory.shot
         let powerUp = BitMaskCategory.powerUp
         
         if bodyA == player && bodyB == enemy || bodyA == enemy && bodyB == player {
         print("1 ")
         }else if bodyA == player && bodyB == powerUp || bodyA == powerUp && bodyB == player {
         print("2")
         }else if bodyA == shot && bodyB == enemy || bodyA == enemy && bodyB == shot {
         print("3")
         }*/
        
    }
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
    func overGameScores(){
        
        if lives == 0 {
              
              gameSetting.currentScore = hud.score
              gameSetting.saveScores()
              
              let gameOverScence = GameOverScene(size: self.size)
              let transition = SKTransition.doorsCloseVertical(withDuration: 1.0)
              gameOverScence.scaleMode = .aspectFill
              self.scene?.view?.presentScene(gameOverScence, transition: transition)
          }
    }
    
}
