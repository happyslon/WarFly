//
//  PauseScence.swift
//  WarFly
//
//  Created by Сергей Поляновский on 29/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class PauseScence: SKScene {
    
    override func didMove(to view: SKView) {
           

           self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
           
           
//           let texture = SKTexture(imageNamed: "header1")
//           let header = SKSpriteNode(texture: texture)
           let header = ButtonNode(titled: "pause", backgroundName: "header_background")
           header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 250)
           //header.name = "runButton"
           self.addChild(header)
           
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
           let button3 = ButtonNode(titled: "resume", backgroundName: "button_background")
           button3.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
           button3.name = "resume"
           button3.label.name = "resume"
           addChild(button3)
           
           
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           guard let location = touches.first?.location(in: self) else { return  }
           let node = self.atPoint(location)
         //  if node.name == "runButton" {
           if node.name == "restart" {
               let transition = SKTransition.crossFade(withDuration: 1.0)
               let gameScene = GameScene(size: self.size)
               gameScene.scaleMode = .aspectFill
               self.scene?.view?.presentScene(gameScene, transition: transition)
               
           }
       }


}
