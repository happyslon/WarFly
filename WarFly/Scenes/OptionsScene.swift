//
//  OptionsScene.swift
//  WarFly
//
//  Created by Сергей Поляновский on 03/03/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class OptionsScene: ParentScene {
    
    
       
        
        override func didMove(to view: SKView) {
            
          // перенесли
         //   self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
            
            setHeader(withName: "options", andBackground: "header_background")
            
            
            let button1 = ButtonNode(titled: nil, backgroundName: "music")
            button1.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
            button1.name = "music"
            button1.label.isHidden = true
            addChild(button1)
            ////
            let button2 = ButtonNode(titled: nil, backgroundName: "sound")
            button2.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY )
            button2.name = "sound"
            button2.label.isHidden = true
            addChild(button2)
//            ///
            let button3 = ButtonNode(titled: "back", backgroundName: "header_background")
            button3.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
            button3.name = "back"
            button3.label.name = "back"
            addChild(button3)
            
            
        }
        

        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let location = touches.first?.location(in: self) else { return  }
            let node = self.atPoint(location)
            
            if node.name == "music" {
                
                
            }else if node.name == "sound"{

                
            }else if node.name == "back"{
                
                let transition = SKTransition.crossFade(withDuration: 1.0)
                guard let backScene = backScene else {return}
                backScene.scaleMode = .aspectFill
                self.scene?.view?.presentScene(backScene, transition: transition)
            }
        }
    

}
