//
//  MenuScene.swift
//  WarFly
//
//  Created by Сергей Поляновский on 27/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class MenuScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
        if !Assets.shared.isLoaded {
        
            Assets.shared.preloadAssets()
            Assets.shared.isLoaded = true
        }
        // перенесли 
       // self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        setHeader(withName: nil, andBackground: "header1")
        
        // перенесли в ParentScene
        
//        let texture = SKTexture(imageNamed: "header1")
//        let header = SKSpriteNode(texture: texture)
//        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 250)
//        //header.name = "runButton"
//        self.addChild(header)
        
        let button1 = ButtonNode(titled: "play", backgroundName: "button_background")
        button1.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        button1.name = "play"
        button1.label.name = "play"
        addChild(button1)
        ////
        let button2 = ButtonNode(titled: "options", backgroundName: "button_background")
        button2.position = CGPoint(x: self.frame.midX, y: self.frame.midY )
        button2.name = "options"
        button2.label.name = "options"
        addChild(button2)
        ///
        let button3 = ButtonNode(titled: "best", backgroundName: "button_background")
        button3.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        button3.name = "best"
        button3.label.name = "best"
        addChild(button3)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return  }
        let node = self.atPoint(location)
      //  if node.name == "runButton" {
        if node.name == "play" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
            
        } else if node.name == "options" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(optionsScene, transition: transition)
            
        }else if node.name == "best" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(bestScene, transition: transition)
            
        }
    }

}
