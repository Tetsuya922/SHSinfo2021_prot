//
//  tourokuViewController.swift
//  SHSinfo2019
//
//  Created by tetsuya yoshikawa on 2020/08/10.
//  Copyright © 2020 SHS情報技術. All rights reserved.
//

import UIKit

class tourokuViewController: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate{
    
     //UIPickerViewの列数を設定
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
    
    
    @IBOutlet weak var citySelect: UIPickerView!
    @IBOutlet weak var btnModoru: UIButton!
    
    
    //pickerView で選択された都道府県の都市名を設定する配列
    var cityArray:[ItemCity] = []
    var citys :ItemCity?
    var prefNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
         csvReader()
        
       //pickerViewのデリゲートになる
       citySelect.delegate = self
       //pickerViewのデータソースになる
       citySelect.dataSource = self
        //UserDefaultsの参照
        let userDefaults = UserDefaults.standard
        //rowというキーを指定して保存していた値を取り出す
        if let value = userDefaults.string(forKey: "row"){
                  //取り出した値をprefNumに保存
        prefNum = Int( value )!
       
        }
        
       //ピッカーの初期値　inComponentは何番目のピッカーか？
       citySelect.selectRow(prefNum, inComponent: 0, animated: false)
       self.view.addSubview(citySelect)
       
       
        
        //ボタン1行表示
        btnModoru.titleLabel?.numberOfLines = 1;
        btnModoru.backgroundColor = UIColor.rgba(red: 122, green: 174, blue: 252, alpha: 1)
        btnModoru.setTitleColor(UIColor.white, for: .normal)
        //buttonコーナーを丸く
        btnModoru.layer.cornerRadius = 15.0
        
        // Do any additional setup after loading the view.
    }
    func csvReader(){
         var csvLines = [String]()
        guard let path = Bundle.main.path(forResource:"WeatherPoint", ofType:"csv")
                   else {
                   print("csvファイルがないよ")
                   return
               }
               //ファイルの読み込み
               do {
                  let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                 csvLines = csvString.components(separatedBy: .newlines)
              
               } catch let error as NSError {
                   print("エラー: \(error)")
                   return
               }
        /*****************詳細読み込む*******************************/
         //配列の値を全て消去
        cityArray.removeAll()
        for csvData in csvLines {
            if let range = csvData.range(of: ",") {
                let csvData1 = csvData.components(separatedBy: ",")
                //pickerで選ばれた都道府県の都市名を配列 cityArrayに追加
                self.citys = ItemCity()
                self.citys?.pref = csvData1[0]
                self.citys?.url = csvData1[1]
                cityArray.append(self.citys!)
            }
            else{
              
          }
        }
    }
    //UIPickerViewの行数を取得
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //       if pickerView == prefSetting{
        return cityArray.count
       
    }
    //UIPickerViewの表示する内容を設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //都道府県名を表示
        //  if pickerView == prefSetting{
        return String( cityArray[row].pref )
       
    }
    
    //UIpickerView選択時に実行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == citySelect{
            let item = cityArray[row].pref
           
            print("\(item)が選ばれた")
            //現在選択されている行番号 purefNumはピッカーに表示される県名
            let row1 = pickerView.selectedRow(inComponent: 0)
            print("現在選択されている行番号\(row1)")
            
            
            let userDefaluts = UserDefaults.standard
            //prefというキーで保存
           // userDefaluts.set(cityArray[row].pref , forKey: "pref")
            userDefaluts.set(cityArray[row].url, forKey: "url")
            userDefaluts.set(row, forKey: "row")
            //userDefaultsへの値の保存を明示的に行う
            userDefaluts.synchronize()
            /********************/
            showAlert()
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
          self.dismiss(animated: true, completion: nil);
    }
    //アラートを作る
        func showAlert(){
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.title = "登録"
            alert.message = "地点が登録されました。週間天気予報や警報注意報へどうぞ"
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: {(action) ->
                        Void in self.hello(action.title!)
                   }
                    
            )
        )
        //表示する
            self.present(
                alert,
                animated: true,
                completion: {
                    print("表示された")
            })
    }
    func hello(_ msg:String){
        //メニューに戻る
        self.dismiss(animated: true, completion: nil);
        //displayContentController(content: page1Controller!, container: view)
        //hideContentController(content: page2Controller!)
        print(msg)
    }
    @IBAction func leftSwipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
}

    
   
