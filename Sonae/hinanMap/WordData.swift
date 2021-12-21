//
//  WordData.swift
//  csvReader
//
//  Created by 吉川哲也 on 2019/05/25.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import Foundation
class WordData {
    
    //単語
    var name: String?
    
    var kouzui: Int?
    var jishin: Int?
    var tsunami: Int?
    var jyo:Int?
    var lat: Double?
    var lng: Double?
    
    //単語の番号
    var wordNumber: Int = 0
    
    //クラスが生成された時の処理
    init(wordSourceDataArray: [String]) {
        name = wordSourceDataArray[1]
        kouzui =  Int(wordSourceDataArray[3])
        jishin = Int(wordSourceDataArray[6])
        tsunami = Int(wordSourceDataArray[7])
        jyo = Int(wordSourceDataArray[11])
        lat = Double(wordSourceDataArray[12])
        lng = Double(wordSourceDataArray[13])
        
        
        //print(word,"です")
        //print(meaning,"です")
    }
}

