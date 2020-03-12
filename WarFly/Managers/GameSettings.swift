//
//  GameSettings.swift
//  WarFly
//
//  Created by Сергей Поляновский on 12/03/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import UIKit

class GameSettings {
    
    let ud = UserDefaults.standard
    
    var isMusic = true
    var isSound = true
    
    let musicKey = "music"
    let soundKey = "sound"
    
    var highscore: [Int] = []
    var currentScore = 0
    let highscoreKey = "highscore"
    
    init(){
        
        loadGameSettings()
        loadScores()
    }
    
    func saveScores(){
        print(currentScore)
        highscore.append(currentScore)
        highscore = Array(highscore.sorted{ $0 > $1}.prefix(3))
        
        ud.set(highscore, forKey: highscoreKey)
        ud.synchronize()
        
    }
    
    func loadScores(){
        
        guard ud.value(forKey: highscoreKey) != nil else {return}
        highscore = ud.array(forKey: highscoreKey) as! [Int]
        print(highscore)
    }
    
    func saveGameSettings(){
        ud.set(isMusic, forKey: musicKey)
        ud.set(isSound, forKey: soundKey)
        
    }
    
    func loadGameSettings(){
        guard ud.value(forKey: musicKey) != nil && ud.value(forKey: soundKey) != nil else {return}
        isMusic = ud.bool(forKey: musicKey)
        isSound = ud.bool(forKey: soundKey)
    }

}
