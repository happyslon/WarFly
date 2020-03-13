//
//  BestScene.swift
//  WarFly
//
//  Created by Сергей Поляновский on 04/03/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit

class BestScene: ParentScene {
    
    var places: [Int]!   //[10, 100, 1000]
    //var places = [10]
    
    override func didMove(to view: SKView) {
        
        gameSetting.loadScores()
        places = gameSetting.highscore
        
        // перенесли в родительский класс
        //self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        setHeader(withName: "best", andBackground: "header_background")
        
    
        let button3 = ButtonNode(titled: "back", backgroundName: "header_background")
        button3.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        button3.name = "back"
        button3.label.name = "back"
        addChild(button3)
        
        //let topPlaces = places.sorted{ $0 > $1 }.prefix(3)
        
        //for (index, value) in topPlaces.enumerated(){
        for (index, value) in places.enumerated(){
            if value != 0 {
                let l = SKLabelNode(text: value.description)
                l.fontColor = UIColor(red: 219 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1.0)
                l.fontName = "AmericanTypewriter-Bold"
                l.fontSize = 30
                l.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 60))
                addChild(l)
            }

        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return  }
        let node = self.atPoint(location)
        
        if node.name == "back"{
            
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else {return}
            backScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(backScene, transition: transition)
        }
    }
    
    
}
