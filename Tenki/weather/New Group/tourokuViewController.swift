//
//  tourokuViewController.swift
//  SHSinfo2019
//
//  Created by tetsuya yoshikawa on 2020/08/10.
//  Copyright © 2020 SHS情報技術. All rights reserved.
//

import UIKit

class tourokuViewController: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
     //UIPickerViewの列数を設定
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
    
    
    @IBOutlet weak var citySelect: UIPickerView!
    @IBOutlet weak var btnModoru: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    //pickerView で選択された都道府県の都市名を設定する配列
    var cityArray:[ItemCity] = []
    var citys :ItemCity?
    var areaArray:[ItemAreaCode] = []
    var areas : ItemAreaCode?
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
       
        //tableViewのdataSouceを設定
        tableView.dataSource = self
        tableView.delegate = self
        
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
        /***************************都道府県の読み込み*********************************/
        guard let path = Bundle.main.path(forResource:"weather_prefcode", ofType:"csv")
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
        /***************************市町村の読み込み*********************************/
        guard let path2 = Bundle.main.path(forResource:"weather_areacode", ofType:"csv")
                   else {
                   print("csvファイルがないよ")
                   return
               }
               //ファイルの読み込み
               do {
                  let csvString = try String(contentsOfFile: path2, encoding: String.Encoding.utf8)
                 csvLines = csvString.components(separatedBy: .newlines)
              
               } catch let error as NSError {
                   print("エラー: \(error)")
                   return
               }
        /*****************詳細読み込む*******************************/
         //配列の値を全て消去
        areaArray.removeAll()
        for csvData in csvLines {
            if let range = csvData.range(of: ",") {
                let csvData1 = csvData.components(separatedBy: ",")
                //pickerで選ばれた都道府県の都市名を配列 cityArrayに追加
                self.areas = ItemAreaCode()
                self.areas?.areaNo = csvData1[0]
                self.areas?.name2 = csvData1[2]
                self.areas?.url = csvData1[3]
                
                areaArray.append(self.areas!)
        
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
    
    var selectItem : SelectAreaCode?
    var selectArray:[SelectAreaCode] = []
    //UIpickerView選択時に実行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == citySelect{
            //配列の値を全て消去
           selectArray.removeAll()
            let itemNo = cityArray[row].url
            var i:Int=0
            for area in areaArray {
                if (areaArray[i].url == itemNo){
                    selectItem = SelectAreaCode()
                    selectItem?.areaNo = areaArray[i].areaNo
                    selectItem?.name2 = areaArray[i].name2
                    
                    selectArray.append(self.selectItem!)
                    print (self.selectItem?.name2)
                }
            
                i+=1
              
            }
            self.tableView.reloadData()
            
        }
        
    }
    
    //cellの総数を返すdatasouceメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectArray.count
    }
    //cellの値を設定するdatasouceメソッド。必ず記述する必要があります。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //今回表示を行うcellオブジェクト（１行）を取得する
        let  cell = tableView.dequeueReusableCell(withIdentifier: "areaCell", for: indexPath)
        //都市名の設定
        cell.textLabel?.text = selectArray[indexPath.row].name2
        
        return cell
    }
    
    //tableViewを選択したときのコード
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = selectArray[indexPath.row].areaNo
            
     
                //値を渡す
                let areaCode:String = selectArray[indexPath.row].areaNo
                print(areaCode)
                /********値の保存************/
                let userDefaluts = UserDefaults.standard
                //areaCodeというキーで保存
                userDefaluts.set(areaCode, forKey: "areaCode")
                //userDefaultsへの値の保存を明示的に行う
                userDefaluts.synchronize()
                /********************/
                print("保存されました")
                showAlert()
                
            
        }
    }
    //tableViewを選択した時に画面遷移する値を設定
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
       
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

    
   
