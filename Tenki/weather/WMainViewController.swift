//
//  WMainViewController.swift
//  SHSinfo2018
//
//  Created by 吉川哲也 on 2018/05/30.
//  Copyright © 2018年 SHS情報技術. All rights reserved.
//

import UIKit

class WMainViewController:  UIViewController , XMLParserDelegate , UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource ,UITableViewDelegate{
    
    @IBOutlet weak var btnModoru: UIButton!
    //}, UITableViewDataSource{
    
    var parser : XMLParser!
    var items = [Item()]
    var items2 = [Item2]()
    var item:Item?
    var item2:Item2?
    var currentString = ""
    var prefTitle:String?
    var cityTitle:String?
    var warnSource:String?
    var cityWeather:String?
    //pickerView で選択された都道府県の都市名を設定する配列
    var cityArray:[String] = []
    
    
    //各都市ごとの都市名、天気情報、県NO,通しNO 配列
    var cityInfo : [(city:String,weather:String,num:String,num2:String)] = []
    
    @IBOutlet weak var prefSetting: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    //cellの総数を返すdatasouceメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    //cellの値を設定するdatasouceメソッド。必ず記述する必要があります。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //今回表示を行うcellオブジェクト（１行）を取得する
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        //都市名の設定
        cell.textLabel?.text = cityArray[indexPath.row]
        
        return cell
    }
    
    //tableViewを選択したときのコード
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = cityArray[indexPath.row]
            
            let n = self.cityInfo.count
            var indexNo = -1
            for a in 0...n-1 {
                if cityInfo[a].city == item{
                    indexNo = a
                }
            }
            
            if indexNo == -1 {
                print("みつかりません")
            }
            else{
                //値を渡す
                //let city1:String = cityInfo[indexNo].num
                //controller.Weather = cityInfo[indexNo].weather
                //controller.Num = cityInfo[indexNo].num
                //controller.Ken = Kenmei
                /********値の保存************/
                let userDefaluts = UserDefaults.standard
                //prefというキーで保存
                userDefaluts.set(cityInfo[indexNo].num , forKey: "pref")
                userDefaluts.set(cityInfo[indexNo].city, forKey: "city")
                userDefaluts.set(cityInfo[indexNo].weather, forKey: "weather")
                userDefaluts.set(cityInfo[indexNo].num, forKey: "Num")
                userDefaluts.set(Kenmei ,forKey: "Ken")
                //userDefaultsへの値の保存を明示的に行う
                userDefaluts.synchronize()
                /********************/
                print("保存されました")
                showAlert()
                
            }
        }
    }
    //tableViewを選択した時に画面遷移する値を設定
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
       
    }
    
    
    //UIPickerViewの列数を設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //UIPickerViewの行数を取得
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //       if pickerView == prefSetting{
        return items.count
        //     }
        //        else{
        //            return cityArray.count
        //        }
    }
    //UIPickerViewの表示する内容を設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //都道府県名を表示
        //  if pickerView == prefSetting{
        return String( items[row].pref )
        //}
        //        else{
        //            return String( cityArray[row] )
        //        }
    }
    var prefNum = 0
    var Kenmei = ""
    //UIpickerView選択時に実行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == prefSetting{
            let item = items[row].pref
            Kenmei = item
            print("\(item)が選ばれた")
            //現在選択されている行番号 purefNumはピッカーに表示される県名
            let row1 = pickerView.selectedRow(inComponent: 0)
            print("現在選択されている行番号\(row1)")
            
            
            //配列の値を全て消去
            cityArray.removeAll()
            //地区（市）を検索
            for n in 0...140{
                if items2[n].num == String(row1){
                    //pickerで選ばれた都道府県の都市名を配列 cityArrayに追加
                    cityArray.append( items2[n].city )
                    //print( items2[n].city )
                    
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
    
    func startDownload(){
        
        self.items = []
        if let url = URL(string: "http://weather.livedoor.com/forecast/rss/primary_area.xml"){
            //http://weather.livedoor.com/forecast/rss/primary_area.xml"){
            if let parser = XMLParser(contentsOf: url){
                self.parser=parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
        
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.currentString = ""
        self.item = Item()
        self.item2 = Item2()
        
        
        //県名
        if elementName == "pref"{
            let prefT = attributeDict["title"]! as NSString
            self.prefTitle = prefT as String
            //self.item = Item()
            //print( prefT )
        }
        //市名
        if elementName == "city"{
            let cityT = attributeDict["title"]! as NSString
            self.cityTitle = cityT as String
        }
        //警報・注意報
        if elementName == "warn"{
            let warnT = attributeDict["source"]! as NSString
            self.warnSource = warnT as String
        }
        //各地の天気
        if elementName == "city"{
            let weatherT = attributeDict["source"]! as NSString
            self.cityWeather = weatherT as String
        }
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString += string
        
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        switch elementName {
        case "warn":
            self.item?.pref = prefTitle!
            self.item?.warn = warnSource!
            self.item?.num = String( num1 )
            /*itemが来たら次の項目へ*/
            self.items.append(self.item!)
            
            num1 = num1+1
            
            
        case "city":
            
            self.item2?.city = cityTitle!
            self.item2?.cityWeather = cityWeather!
            self.item2?.num2 = String( num2 )
            self.item2?.num = String( num )
            num2 = num2+1
            /*cityが来たら次の項目へ*/
            self.items2.append(self.item2!)
            
        case "pref":
            
            
            num = num + 1
        default : break
        }
    }
    var num = 0
    var num1 = 0
    var num2 = 0
    func outDescripion(){

        if num2 != 0{
            for n in 0...num2-1 {
                let city = items2[n].city
                let weather = items2[n].cityWeather
                let num = items2[n].num
                let num2 = items2[n].num2
                let text = ( city,weather,num,num2 )
                // print( city ,  weather , num ,num2 )
                self.cityInfo.append( text )
            }
        }
        
    
        
    }
    
 
   // var page1Controller : SonaeViewController?
    var page2Controller : WMainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        // Do any additional setup after loading the view, typically from a nib.
        startDownload()
        outDescripion()
        
        //UserDefaultsの参照
        let userDefaults = UserDefaults.standard
        //prefというキーを指定して保存していた値を取り出す
        if let value = userDefaults.string(forKey: "pref"){
            //取り出した値をprefNumに保存
            prefNum = Int( value )!
        }
        if userDefaults.string(forKey: "Ken") != nil {
            Kenmei = userDefaults.string(forKey: "Ken")!
        }
        //pickerViewのデリゲートになる
        prefSetting.delegate = self
        //pickerViewのデータソースになる
        prefSetting.dataSource = self
        //ピッカーの初期値　inComponentは何番目のピッカーか？
        prefSetting.selectRow(prefNum, inComponent: 0, animated: false)
        
        //tableViewのdataSouceを設定
        tableView.dataSource = self
        tableView.delegate = self
        
        /*****tableViewの値を表示*****************************/
        //配列の値を全て消去
        cityArray.removeAll()
        
        if num != 0 {
            //地区（市）を検索
            for n in 0...140{
                if items2[n].num == String(prefNum){
                    //pickerで選ばれた都道府県の都市名を配列 cityArrayに追加
                    cityArray.append( items2[n].city )
                    //print( items2[n].city )
                    
                }
            }
        }
        self.tableView.reloadData()
        /*******************************************************/
        //画面遷移　戻るため
        //page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
        
        
        //ボタン1行表示
        btnModoru.titleLabel?.numberOfLines = 1;
        btnModoru.backgroundColor = UIColor.rgba(red: 122, green: 174, blue: 252, alpha: 1)
        btnModoru.setTitleColor(UIColor.white, for: .normal)
        //buttonコーナーを丸く
        btnModoru.layer.cornerRadius = 15.0
    }
    
    @IBAction func btnBack(_ sender: Any) {
          self.dismiss(animated: true, completion: nil);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //画面遷移　戻る
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
    /*削除*/
    func hideContentController(content:UIViewController){
        content.willMove(toParent: self)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
    /***************画面遷移**************************/
  /*  func createPage1ViewController() -> SonaeViewController{
        let sb:UIStoryboard = UIStoryboard(name: "SonaeViewController",bundle: nil)
        let sController:SonaeViewController = sb.instantiateInitialViewController() as! SonaeViewController
        return sController
    }
   */
    func createPage2ViewController() -> WMainViewController{
        let sb:UIStoryboard = UIStoryboard(name: "WMainViewController",bundle: nil)
        let sController:WMainViewController = sb.instantiateInitialViewController() as! WMainViewController
        return sController
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

