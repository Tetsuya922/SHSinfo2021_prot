//
//  WordsDataManager.swift
//  csvReader
//
//  Created by 吉川哲也 on 2019/05/25.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import Foundation

//==================================================
//全ての単語に関する情報を管理するモデルクラス
//==================================================
class WordsDataManager {
    
    //シングルトンオブジェクトを作成
    static let sharedInstance = WordsDataManager()
    
    //単語を格納するための配列
    var wordDataArray = [WordData]()
    
    //現在の単語のインデックス
    var nowWordIndex: Int = 0
    
    //初期化処理
    private init(){
        //シングルトンであることを保証するためにprivateで宣言
    }
    
    //------------------------------
    //単語の読み込み処理
    //------------------------------
    func loadWord(csvfile:String) {
        //格納済みの単語があれば一旦削除
        wordDataArray.removeAll()
        //現在の単語のインデックスを初期化
        nowWordIndex = 0

            let file_url = URL(string: "https://sadowara.sakura.ne.jp/hinan/" + csvfile + ".csv")!
            do {
                 let csvStringData: String = try String(contentsOf:file_url, encoding: String.Encoding.shiftJIS)
                    //CSVデータを1行ずつ読み込む
                    csvStringData.enumerateLines(invoking: { (line, stop) -> () in
                        //let line = "ABC,DEF,GHI"
                        //カンマ区切りで分割
                        let wordSourceDataArray = line.components(separatedBy: ",")
                        //単語データを格納するオブジェクトを作成
                        let wordData = WordData(wordSourceDataArray: wordSourceDataArray).self
                        //単語を追加
                        self.wordDataArray.append(wordData)
                        //単語番号を設定
                        wordData.wordNumber = self.wordDataArray.count
                    })
                
            } catch let error {
                //ファイル読み込みエラー時
                print(error)
        }
    }
    
    //------------------------------
    //次の単語を取り出す
    //------------------------------
    func nextWord() -> WordData? {
        if nowWordIndex < wordDataArray.count {
            let nextWord = wordDataArray[nowWordIndex]
            //nowWordIndex += 1
            return nextWord
        }
        return nil
    }
}
