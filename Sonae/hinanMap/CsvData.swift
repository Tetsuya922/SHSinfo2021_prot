//
//  WordData.swift
//  csvReader
//
//  Created by 吉川哲也 on 2019/05/25.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import Foundation
class CsvData {
    
    //単語
    var name: String?
    
    var ban: String?
    //提出
    var etc: String?
    
    //単語の番号
    var wordNumber: Int = 0
    
    //クラスが生成された時の処理
    init(wordSourceDataArray: [String]) {
        name = wordSourceDataArray[1]
        ban =  wordSourceDataArray[3]
        etc =  wordSourceDataArray[2]
        
        
        
        //print(word,"です")
        //print(meaning,"です")
    }
}

