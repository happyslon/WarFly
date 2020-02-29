//
//  BitMaskCategory.swift
//  WarFly
//
//  Created by Сергей Поляновский on 27/02/2020.
//  Copyright © 2020 Сергей Поляновский. All rights reserved.
//

import SpriteKit



struct BitMaskCategory: OptionSet {
    
    let rawValue: UInt32
    
    static let none = BitMaskCategory(rawValue: 0 << 0)
    
//    init(rawValue: UInt32){  // можно удалить так как инициализация уже есть по дифолту т.е. BitMaskCategoty
//        self.rawValue = rawValue
//    }
    // перепишем
//    static let player:  UInt32 = 0x1 << 0 //0000000...01
//    static let enemy:   UInt32 = 0x1 << 1 //0000000...10
//    static let powerUp: UInt32 = 0x1 << 2 //0000000..100
//    static let shot:    UInt32 = 0x1 << 3 //0000000.1000
    
    //BitMaskCategory(rawValue: 1 << 0)
    
    static let player =  BitMaskCategory(rawValue: 1 << 0) //0000000...01
    static let enemy =   BitMaskCategory(rawValue: 1 << 1) //0000000...10
    static let powerUp = BitMaskCategory(rawValue: 1 << 2) //0000000..100
    static let shot =    BitMaskCategory(rawValue: 1 << 3) //0000000.1000
    
    static let all =     BitMaskCategory(rawValue: UInt32.max)
    
    
    
    
    
}
