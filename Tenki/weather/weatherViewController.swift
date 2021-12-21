//
//  weatherViewController.swift
//  SHSinfo2018
//
//  Created by 吉川哲也 on 2018/05/30.
//  Copyright © 2018年 SHS情報技術. All rights reserved.
//

import UIKit

class weatherViewController: UIViewController , XMLParserDelegate  , UIPickerViewDataSource, UIPickerViewDelegate {
    var City:String  = "宮崎"
    var Weather:String = "http://weather.livedoor.com/forecast/rss/area/450030.xml"
    var Num:String = "48"
    var Ken:String = "宮崎県"
    //    var City:String = ""
    //    var Weather:String = ""
    //    var Num:String = ""
    //    var Ken:String  = ""
    
    var parser:XMLParser!
    var items = [Item5]()
    var item:Item5?
    var currentString = ""
    @IBOutlet weak var labelLiveDoor: UILabel!
    
    @IBOutlet weak var btnModoru: UIButton!
    
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    
    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab4: UILabel!
    @IBOutlet weak var lab5: UILabel!
    @IBOutlet weak var lab6: UILabel!
    @IBOutlet weak var lab7: UILabel!
    
    @IBOutlet weak var lab11: UILabel!
    @IBOutlet weak var lab22: UILabel!
    @IBOutlet weak var lab33: UILabel!
    @IBOutlet weak var lab44: UILabel!
    @IBOutlet weak var lab55: UILabel!
    @IBOutlet weak var lab66: UILabel!
    @IBOutlet weak var lab77: UILabel!
    
    @IBOutlet weak var lab111: UILabel!
    @IBOutlet weak var lab222: UILabel!
    @IBOutlet weak var lab333: UILabel!
    @IBOutlet weak var lab444: UILabel!
    @IBOutlet weak var lab555: UILabel!
    @IBOutlet weak var lab666: UILabel!
    @IBOutlet weak var lab777: UILabel!
    
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var pickerView1: UIPickerView!
    
    @IBOutlet weak var kionLab1: UILabel!
    @IBOutlet weak var kionLab2: UILabel!
    @IBOutlet weak var kousuiLab1: UILabel!
    @IBOutlet weak var kousuiLab2: UILabel!
    
    //    @IBOutlet weak var sekisetuLab1: UILabel!
    //    @IBOutlet weak var sekisetuLab2: UILabel!
    //
    
    
    
    
    //複数の記事を格納するために配列
    var items11 = [Item3]()
    var items22 = [Item4]()//降水
    // var items33 = [Item6]()//積雪
    
    //Itemクラスのプロパティ　title,url,descriptionの２つのプロパティをもつ
    var item11:Item3?
    var item22:Item4?
    //var item33:Item6?
    
    //気温・降水量・積雪深を格納する配列
    var kion : [(city:String,time:String,kion:String)] = []
    var kousui :[(city:String,time:String,kousui:String)] = []
    // var sekisetu :[(city:String,time:String,sekisetu:String)] = []
    
    
    
    //    @IBAction func buttonTapped(sender : AnyObject) {
    //        performSegue(withIdentifier: "toViewController2",sender: nil)
    //
    //    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toViewController2") {
           // let vc2: warnViewController = (segue.destination as? warnViewController )!
            // ViewControllerのtextVC2にメッセージを設定
            
         //   vc2.Num = self.Num
        }
    }
    //UIPickerViewの列数を設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //UIPickerViewの行数を取得
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kion.count
        
    }
    //UIPickerViewの表示する内容を設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //都道府県名を表示
        return String( kion[row].city )
        
    }
    
    //UIpickerView選択時に実行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1{
            let item = kion[row].kion
            print("\(item)が選ばれた")
            //現在選択されている行番号
            var row1 = pickerView1.selectedRow(inComponent: 0)
            print("現在選択されている行番号\(row1)")
            kionLab1.text = kion[row].time
            kionLab1.text = kionLab1.text! + "の気温"
            kionLab2.text = kion[row].kion
            
            let name = kion[row].city
            let count = kousui.count
            var row2:Int = 0
            for i in 0..<count {
                if name == kousui[i].city
                {   row2=i;
                    break;
                }
            }
            kousuiLab1.text = kousui[row2].time
            kousuiLab1.text = kousuiLab1.text! + "の降水量"
            kousuiLab2.text = kousui[row2].kousui
            //    sekisetuLab1.text = sekisetuLab1.text! + "の降水量"
            //   sekisetuLab2.text = sekisetu[row].sekisetu
        }
    }
    
    
    
    //引っ張って更新
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //戻るボタン
  //  var page1Controller : SonaeViewController?
    var page2Controller : weatherViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // print(City,Weather,Num,Ken)
        let userDefaults = UserDefaults.standard
        let city = userDefaults.string(forKey: "city")
        if ( city != nil){
            City = userDefaults.string(forKey: "city")!
            Weather = userDefaults.string(forKey: "weather")!
            Num = userDefaults.string(forKey: "Num")!
            Ken = userDefaults.string(forKey: "Ken")!
        }
        // lab1.numberOfLines = 0
        print(City,Weather,Num,Ken)
        //引っ張って更新
        scrollview.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(weatherViewController.refresh(sender:)), for: .valueChanged)
        //pickerViewのデリゲートになる
        pickerView1.delegate = self
        //pickerViewのデータソースになる
        pickerView1.dataSource = self
        // ここで初期値を設定
        pickerView1.selectRow(5, inComponent: 0, animated: false)
        
        //戻るボタン２行表示
        btnModoru.titleLabel?.numberOfLines = 2;
        btnModoru.backgroundColor = UIColor.rgba(red: 122, green: 174, blue: 252, alpha: 1)
        btnModoru.setTitleColor(UIColor.white, for: .normal)
        //buttonコーナーを丸く
        btnModoru.layer.cornerRadius = 15.0
        //戻るボタン
     //   page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
        
        labelLiveDoor.text = "気象情報「Weather Hacks livedoor」RSSフィードより"
    }
    
    
    //引っ張って更新
    @objc func refresh(sender: UIRefreshControl){
        //viewDidLoad()
        //pickerViewのデリゲートになる
        pickerView1.delegate = self
        //pickerViewのデータソースになる
        pickerView1.dataSource = self
        channelNum=0;
        channelNum2=0;
        channelNum3=0;
        num = 0
        num2 = 0
        num3 = 0
        startDownload()
        outDescription()
        print("引っ張られた")
        /********気温・降水量の更新**************************/
        let row1 = 1
            //pickerView1.selectedRow(inComponent: 0)
        print("現在選択されている行番号\(row1)")
        kionLab1.text = kion[row1].time
        kionLab1.text = kionLab1.text! + "の気温"
        kionLab2.text = kion[row1].kion
        kousuiLab1.text = kousui[row1].time
        kousuiLab1.text = kousuiLab1.text! + "の降水量"
        kousuiLab2.text = kousui[row1].kousui
        // sekisetuLab1.text = sekisetuLab1.text! + "の降水量"
        // sekisetuLab2.text = sekisetu[row1].sekisetu
        /****************************************************/
        
        
        didReload()
    }
    func didReload()
    {
        refreshControl.endRefreshing()//インジケータを終了する
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("画面表示前に呼ばれる")
        channelNum=0;
        channelNum2=0;
        channelNum3=0;
        
        num = 0
        num2 = 0
        num3 = 0
        //pickerViewのデリゲートになる
        pickerView1.delegate = self
        //pickerViewのデータソースになる
        pickerView1.dataSource = self
        startDownload()
        outDescription()
        
    }
    
    
    
    func startDownload(){
        /************保存データの読み込み*****************************/
        let userDefaults = UserDefaults.standard
        let city = userDefaults.string(forKey: "city")
        if ( city != nil){
            City = userDefaults.string(forKey: "city")!
            Weather = userDefaults.string(forKey: "weather")!
            Num = userDefaults.string(forKey: "Num")!
            Ken = userDefaults.string(forKey: "Ken")!
        }
        /******************************************************/
        
        
        var tempUrl:String = ""
        var rainUrl:String = ""
        //    var snowUrl:String = ""
        let num =  Int( Num )
        self.items = []
        self.items11 = []
        self.items22 = []
        // self.items33 = []
        self.kousui = []
        // self.sekisetu = []
        self.kion = []
        
        if num == 0 {
            tempUrl = "http://weather.livedoor.com/forecast/rss/amedas/temp/01a.xml"
            rainUrl = "http://weather.livedoor.com/forecast/rss/amedas/rain/01a.xml"
            //   snowUrl = "http://weather.livedoor.com/forecast/rss/amedas/snow/01a.xml"
        }
        else if num == 1 {
            tempUrl = "http://weather.livedoor.com/forecast/rss/amedas/temp/01c.xml"
            rainUrl = "http://weather.livedoor.com/forecast/rss/amedas/rain/01c.xml"
            //   snowUrl = "http://weather.livedoor.com/forecast/rss/amedas/snow/01c.xml"
            
        }
        else if num == 2 {
            tempUrl = "http://weather.livedoor.com/forecast/rss/amedas/temp/01d.xml"
            rainUrl = "http://weather.livedoor.com/forecast/rss/amedas/rain/01d.xml"
            //   snowUrl = "http://weather.livedoor.com/forecast/rss/amedas/snow/01d.xml"
            
        }
        else if num == 3 {
            tempUrl = "http://weather.livedoor.com/forecast/rss/amedas/temp/01b.xml"
            rainUrl = "http://weather.livedoor.com/forecast/rss/amedas/rain/01b.xml"
            //  snowUrl = "http://weather.livedoor.com/forecast/rss/amedas/snow/01b.xml"
            
        }
        else if num == 4 {
            tempUrl = "http://weather.livedoor.com/forecast/rss/amedas/temp/01d.xml"
            rainUrl = "http://weather.livedoor.com/forecast/rss/amedas/rain/01d.xml"
            // snowUrl = "http://weather.livedoor.com/forecast/rss/amedas/snow/01d.xml"
            
        }
        else if num! >= 5  {
            let num22 = num! - 3
            
            //2桁の文字列に変換　”３”→”０３”
            let num222 = String(format: "%02d" , num22 )
            tempUrl = "http://weather.livedoor.com/forecast/rss/amedas/temp/" + num222 + ".xml"
            rainUrl = "http://weather.livedoor.com/forecast/rss/amedas/rain/" + num222 + ".xml"
            //   snowUrl = "http://weather.livedoor.com/forecast/rss/amedas/snow/" + num222 + ".xml"
            
        }
        /************************************************************************/
        
        
        //選ばれた地区の週間天気予報をダウンロード
        if let url = URL(string: Weather){
            
            if let parser = XMLParser(contentsOf: url){
                self.parser = parser
                self.parser.delegate = self
                self.parser.parse()
                // print("XMLparserよばれた")
            }
        }
        //各地の気温
        if let url2 = URL(string: tempUrl ){
            
            if let parser = XMLParser(contentsOf: url2){
                
                self.parser=parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
        //各地の降水量
        if let url3 = URL(string: rainUrl ){
            
            if let parser = XMLParser(contentsOf: url3){
                
                self.parser=parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
        //各地の積雪深
        //        if let url4 = URL(string: snowUrl ){
        //
        //            if let parser = XMLParser(contentsOf: url4){
        //
        //                self.parser=parser
        //                self.parser.delegate = self
        //                self.parser.parse()
        //            }
        //        }
        /*天気画像表示*/
        for num1 in 1...7{
            let url = items[num1].url
            
            
            
            switch( num1 ){
            case 1:
                let surl = URL(string: url)
                if let imageData = try? Data(contentsOf: surl!){
                    img1?.image = UIImage(data: imageData)
                }
            case 2:
                let surl = URL(string: url)
                if let imageData = try? Data(contentsOf: surl!){
                    img2?.image = UIImage(data: imageData)
                }
            case 3:
                let surl = URL(string: url)
                if let imageData = try? Data(contentsOf: surl!){
                    img3?.image = UIImage(data: imageData)
                }
            case 4:
                let surl = URL(string: url)
                if let imageData = try? Data(contentsOf: surl!){
                    img4?.image = UIImage(data: imageData)
                }
            case 5:
                let surl = URL(string: url)
                if let imageData = try? Data(contentsOf: surl!){
                    img5?.image = UIImage(data: imageData)
                }
            case 6:
                let surl = URL(string: url)
                if let imageData = try? Data(contentsOf: surl!){
                    img6?.image = UIImage(data: imageData)
                }
            case 7:
                let surl = URL(string: url)
                if let imageData = try? Data(contentsOf: surl!){
                    img7?.image = UIImage(data: imageData)
                }
            //print( url )
            default :
                break
            }
        }
        
        
        
        /*タプルの準備*/
        var weatherForecast1 = ["日":"","天気":"","最高気温":"","最低気温":""]
        var weatherForecast2 = ["日":"","天気":"","最高気温":"","最低気温":""]
        var weatherForecast3 = ["日":"","天気":"","最高気温":"","最低気温":""]
        var weatherForecast4 = ["日":"","天気":"","最高気温":"","最低気温":""]
        var weatherForecast5 = ["日":"","天気":"","最高気温":"","最低気温":""]
        var weatherForecast6 = ["日":"","天気":"","最高気温":"","最低気温":""]
        var weatherForecast7 = ["日":"","天気":"","最高気温":"","最低気温":""]
        
        for num in 1...7 {
            let te = items[num].description
            
            //天気の次から最高気温まで
            let str = te
            
            
            
            
            //先頭から）まで
            let result2 = str.range(of: "の天気")
            if let theRange2 = result2{
                let afterStr1 = str[..<theRange2.lowerBound]
                let text = String(afterStr1)
                switch (num){
                case 1 : weatherForecast1["日"] = text
                lab1.text = text
                    
                case 2 : weatherForecast2["日"] = text
                lab2.text = text
                case 3 : weatherForecast3["日"] = text
                lab3.text = text
                case 4 : weatherForecast4["日"] = text
                lab4.text = text
                case 5 : weatherForecast5["日"] = text
                lab5.text = text
                case 6 : weatherForecast6["日"] = text
                lab6.text = text
                case 7 : weatherForecast7["日"] = text
                lab7.text = text
                default:
                    break
                }
                
                // print(afterStr1)
                
            }
            
            
            
            let result3 = str.range(of: "天気は")
            let result4 = str.range(of: "、最高気温")
            if let theRange3 = result3{
                if let theRange4 = result4{
                    let afterStr2 = str[theRange3.upperBound...(theRange4.lowerBound)]
                    let to = afterStr2.index(afterStr2.endIndex, offsetBy: -1)
                    let afterStr22 = afterStr2[afterStr2.startIndex ..< to]
                    let text = String(afterStr22)
                    switch (num){
                    case 1 : weatherForecast1["天気"] = text
                        
                    case 2 : weatherForecast2["天気"] = text
                        
                    case 3 : weatherForecast3["天気"] = text
                        
                    case 4 : weatherForecast4["天気"] = text
                        
                    case 5 : weatherForecast5["天気"] = text
                        
                    case 6 : weatherForecast6["天気"] = text
                        
                    case 7 : weatherForecast7["天気"] = text
                        
                    default:
                        break
                    }// print(afterStr22)
                    
                }
            }
            var text1 = ""
            let result5 = str.range(of: "最高気温は")
            let result6 = str.range(of: "℃")
            if let theRange5 = result5{
                if let theRange6 = result6{
                    let afterStr3 = str[theRange5.upperBound...theRange6.lowerBound]
                    let to = afterStr3.index(afterStr3.endIndex, offsetBy: -1)
                    let afterStr33 = afterStr3[afterStr3.startIndex ..< to]
                    text1 = String(afterStr33)
                }
            }
            switch (num){
            case 1 : weatherForecast1["最高気温"] = text1
                lab11.text = text1 + "℃"
                lab11.textColor=UIColor.red
            case 2 : weatherForecast2["最高気温"] = text1
                lab22.text = text1 + "℃"
                lab22.textColor=UIColor.red
            case 3 : weatherForecast3["最高気温"] = text1
                lab33.text = text1 + "℃"
                lab33.textColor=UIColor.red
            case 4 : weatherForecast4["最高気温"] = text1
                lab44.text = text1 + "℃"
                lab44.textColor=UIColor.red
            case 5 : weatherForecast5["最高気温"] = text1
                lab55.text = text1 + "℃"
                lab55.textColor=UIColor.red
            case 6 : weatherForecast6["最高気温"] = text1
                lab66.text = text1 + "℃"
                lab66.textColor=UIColor.red
            case 7 : weatherForecast7["最高気温"] = text1
                lab77.text = text1 + "℃"
                lab77.textColor=UIColor.red
            default:
                break
            }//print(afterStr3)
            
            
            var text2 = ""
            let result7 = str.range(of: "最低気温は")
            let result8 = str.range(of: "℃で")
            if let theRange7 = result7{
                if let theRange8 = result8{
                    let afterStr4 = str[theRange7.upperBound...theRange8.lowerBound]
                    let to = afterStr4.index(afterStr4.endIndex, offsetBy: -1)
                    let afterStr44 = afterStr4[afterStr4.startIndex ..< to]
                    text2 = String(afterStr44)
                }
            }
            //String(afterStr44)
            switch (num){
            case 1 : weatherForecast1["最低気温"] = text2
                
                lab111.text = text2 + "℃"
                lab111.textColor=UIColor.blue
            case 2 : weatherForecast2["最低気温"] = text2
            
                lab222.text = text2 + "℃"
                lab222.textColor=UIColor.blue
            case 3 : weatherForecast3["最低気温"] = text2
                lab333.text = text2 + "℃"
                lab333.textColor=UIColor.blue
            case 4 : weatherForecast4["最低気温"] = text2
                lab444.text = text2 + "℃"
                lab444.textColor=UIColor.blue
            case 5 : weatherForecast5["最低気温"] = text2
                lab555.text = text2 + "℃"
                lab555.textColor=UIColor.blue
            case 6 : weatherForecast6["最低気温"] = text2
                lab666.text = text2 + "℃"
                lab666.textColor=UIColor.blue
            case 7 : weatherForecast7["最低気温"] = text2
                lab777.text = text2 + "℃"
                lab777.textColor=UIColor.blue
            default:
                break
            }
            /********タイトルの設定****************************/
            CityLabel.text = City + "の週間天気予報"
            weatherInfoLabel.text = Ken + " 各地の現在の気象情報"
            
        }
        print("startDownloadよばれた")
        
        
        
        
    }
    /*********************startDownload おわり*******************************************************/
    
    
    
    var channelNum:Int = 0
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        self.currentString = ""
        
        
        if channelNum == 0 {
            if elementName == "item"{
                self.item = Item5()
            }
        }
        if channelNum == 1{
            if elementName == "item"{
                self.item11 = Item3()
            }
        }
        if channelNum2 == 2{
            if elementName == "item"{
                self.item22 = Item4()
            }
        }
        //        if channelNum3 == 2{
        //            if elementName == "item"{
        //                self.item33 = Item6()
        //            }
        //        }
        //print("1個目のparser")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString += string
        //print("2個目のparser")
    }
    /**3個目のparserで使用する変数*********/
    var num = 0
    var num2 = 0
    var num3 = 0
    //var num4 = 0
    var channelNum2:Int = 0
    var channelNum3:Int = 0
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        //1個目のRSS
        if channelNum == 0 {
            switch elementName {
            case "title": self.item?.title = currentString
            case "url": self.item?.url = currentString
            case "item": self.items.append(self.item!)
            case "description": self.item?.description = currentString
            case "channel" : channelNum = channelNum + 1
            default : break
            }
        }
        //気温
        if ( channelNum2 <= 1 ) && ( channelNum >= 1 )   {
            switch elementName {
            case "description" : self.item11?.description = currentString
                // print( "num2" , num2 )
                // case "url" : self.item11?.url = currentString
                /*itemが来たら次の項目へ*/
            case "item": self.items11.append(self.item11!)
            num2 = num2 + 1
            case "channel" : channelNum2 = channelNum2 + 1
                
            default : break
            }
        }
        //降水量
        // print ("cn" ,  channelNum2 ,channelNum)
        if ( (channelNum2 >= 2 ) && ( channelNum3 <= 1 ))    {
            switch elementName {
            case "description" : self.item22?.description = currentString
                
                // case "url" : self.item22?.url = currentString
                /*itemが来たら次の項目へ*/
            case "item": self.items22.append(self.item22!)
            num3 = num3 + 1
            case "channel" : channelNum3 = channelNum3 + 1
                
            default : break
            }
        }        //print("3個目のparser")
        
        //積雪量
        
        //        if ( channelNum3 >= 2 )    {
        //        switch elementName {
        //        case "description" : self.item33?.description = currentString
        //
        //        // case "url" : self.item22?.url = currentString
        //        /*itemが来たら次の項目へ*/
        //        case "item": self.items33.append(self.item33!)
        //        num4 = num4 + 1
        //        default : break
        //        }
        //        }        //print("3個目のparser")
    }
    /****************表示のための各種設定*********************************************/
    func outDescription(){
        
        /************現在の気温の設定**************************/
        for n in 1...num2-1 {
            let text = items11[n].description
            var city = ""
            var time = ""
            var kion = ""
            
            //先頭から”の気温”まで（都市名を保存）
            let result1 = text.range(of: "の気温")
            if let theRange = result1{
                city = String(text[..<theRange.lowerBound ])
                
            }
            //時間の設定
            let result2 = text.range(of: "気温は、")
            let result3 = text.range(of: "現在")
            if let theRange2 = result2{
                if let theRange3 = result3{
                    let afterStr = text[theRange2.upperBound...theRange3.lowerBound]
                    let to = afterStr.index(afterStr.endIndex, offsetBy: -1)
                    time = String(afterStr[afterStr.startIndex ..< to])
                }
            }
            //気温
            let result4 = text.range(of: "現在")
            let result5 = text.range(of: "です")
            if let theRange4 = result4{
                if let theRange5 = result5{
                    let afterStr = text[theRange4.upperBound...theRange5.lowerBound]
                    let to = afterStr.index(afterStr.endIndex, offsetBy: -1)
                    kion = String(afterStr[afterStr.startIndex ..< to])
                }
            }
            let kionList = ( city, time, kion )
            
            self.kion.append( kionList )
        }
        
        /************現在の降水量の設定**************************/
        for n in 1...num3-1 {
            let text = items22[n].description
            var city = ""
            var time = ""
            var kousui = ""
            
            //先頭から”の気温”まで（都市名を保存）
            let result1 = text.range(of: "の降水量")
            if let theRange = result1{
                city = String(text[..<theRange.lowerBound ])
                
            }
            //時間の設定
            let result2 = text.range(of: "降水量は、")
            let result3 = text.range(of: "現在")
            if let theRange2 = result2{
                if let theRange3 = result3{
                    let afterStr = text[theRange2.upperBound...theRange3.lowerBound]
                    let to = afterStr.index(afterStr.endIndex, offsetBy: -1)
                    time = String(afterStr[afterStr.startIndex ..< to])
                }
            }
            //気温
            let result4 = text.range(of: "現在")
            let result5 = text.range(of: "です")
            if let theRange4 = result4{
                if let theRange5 = result5{
                    let afterStr = text[theRange4.upperBound...theRange5.lowerBound]
                    let to = afterStr.index(afterStr.endIndex, offsetBy: -1)
                    kousui = String(afterStr[afterStr.startIndex ..< to])
                }
            }
            let kousuiList = ( city, time, kousui )
            print(kousuiList)
            self.kousui.append( kousuiList )
        }
        
        /************現在の積雪深の設定**************************/
        //        for n in 1...num4-1 {
        //            let text = items33[n].description
        //            var city = ""
        //            var time = ""
        //            var sekisetu = ""
        //
        //            //先頭から”の気温”まで（都市名を保存）
        //            let result1 = text.range(of: "の積雪深")
        //            if let theRange = result1{
        //                city = String(text[..<theRange.lowerBound ])
        //
        //            }
        //            //時間の設定
        //            let result2 = text.range(of: "積雪深は、")
        //            let result3 = text.range(of: "現在")
        //            if let theRange2 = result2{
        //                if let theRange3 = result3{
        //                    let afterStr = text[theRange2.upperBound...theRange3.lowerBound]
        //                    let to = afterStr.index(afterStr.endIndex, offsetBy: -1)
        //                    time = String(afterStr[afterStr.startIndex ..< to])
        //                }
        //            }
        //            //積雪深
        //            let result4 = text.range(of: "現在")
        //            let result5 = text.range(of: "です")
        //            if let theRange4 = result4{
        //                if let theRange5 = result5{
        //                    let afterStr = text[theRange4.upperBound...theRange5.lowerBound]
        //                    let to = afterStr.index(afterStr.endIndex, offsetBy: -1)
        //                    sekisetu = String(afterStr[afterStr.startIndex ..< to])
        //                }
        //            }
        //            let sekisetuList = ( city, time, sekisetu )
        //            self.sekisetu.append( sekisetuList )
        //        }
    }

    @IBAction func btnBack(_ sender: Any) {
        //displayContentController(content: page1Controller!, container: view)
       // hideContentController(content: page2Controller! )
        self.dismiss(animated: true, completion: nil);
    }
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
 /*   func createPage1ViewController() -> SonaeViewController{
        let sb:UIStoryboard = UIStoryboard(name: "SonaeViewController",bundle: nil)
        let sController:SonaeViewController = sb.instantiateInitialViewController() as! SonaeViewController
        return sController
    }
  */
    func createPage2ViewController() -> weatherViewController{
        let sb:UIStoryboard = UIStoryboard(name: "weatherViewController",bundle: nil)
        let sController:weatherViewController = sb.instantiateInitialViewController() as! weatherViewController
        return sController
    }
    
    @IBAction func leftswipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
}


