//
//  GameOverScene.swift
//  WarFly
//
//  Created by Сергей Поляновский on 05/03/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class GameOverScene: ParentScene {
    

        override func didMove(to view: SKView) {
            
      
            setHeader(withName: "game over", andBackground: "header_background")
            
            
            let button1 = ButtonNode(titled: "restart", backgroundName: "button_background")
            button1.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
            button1.name = "restart"
            button1.label.name = "restart"
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
            
            
            if node.name == "restart" {
                
                sceneManager.gameScene = nil//!!!!
                
                let transition = SKTransition.crossFade(withDuration: 1.0)
                let gameScene = GameScene(size: self.size)
                gameScene.scaleMode = .aspectFill
                self.scene?.view?.presentScene(gameScene, transition: transition)
                
            }else if node.name == "options"{
                
                let transition = SKTransition.crossFade(withDuration: 1.0)
                let optionsScence = OptionsScene(size: self.size)
                optionsScence.backScene = self
                
                optionsScence.scaleMode = .aspectFill
                self.scene?.view?.presentScene(optionsScence, transition: transition)
                
            }else if node.name == "best" {
                let transition = SKTransition.crossFade(withDuration: 1.0)
                let bestScene = BestScene(size: self.size)
                bestScene.backScene = self
                bestScene.scaleMode = .aspectFill
                self.scene?.view?.presentScene(bestScene, transition: transition)
                
            }
        }

}
