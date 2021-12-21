//
//  EarthquakeViewController.swift
//  SHSinfo2018
//
//  Created by 吉川哲也 on 2018/06/03.
//  Copyright © 2018年 SHS情報技術. All rights reserved.
//

import UIKit

class EarthquakeViewController:  UIViewController , XMLParserDelegate , UITableViewDataSource ,UITableViewDelegate {
    var parser : XMLParser!
    
    //複数の記事を格納するために配列
    var items = [ItemEarth]()
    //Itemクラスのプロパティ　title,url,descriptionの２つのプロパティをもつ
    var item:ItemEarth?
    
    var Num :String = ""
    var currentString = ""
    
    
    
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var btnModoru: UIButton!
    
    //警報・注意報のタプル配列
    var keihouList : [( description:String ,date:String )] = []
    
    // セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //今回表示を行うCellオブジェクトを１行取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "keihoCell" , for: indexPath)
        //火山情報を設定
        cell.textLabel?.text = keihouList[indexPath.row].description
        
        
        //セルを複数行表示する
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    // セルの行数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //       print(keihouList.count)
        return keihouList.count
    }
    //  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //    print("Num: \(indexPath.row)")
    // print("Value: \(myItems[indexPath.row])")
    //performSegueWithIdentifier("toSubViewController",sender: nil)
    //  }
    func startDownload(){
        
        self.items = []
        var warnUrl:String = ""
        warnUrl = "http://weather.livedoor.com/forecast/rss/earthquake.xml"
        
        
        
        if let url = URL(string: warnUrl ){
            
            if let parser = XMLParser(contentsOf: url){
                
                self.parser=parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
        
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.currentString = ""
        if( channelNum == 0 ){
            if elementName == "item"{
                self.item = ItemEarth()
                
                
                
            }
        }
        
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString += string
        
    }
    var channelNum:Int = 0
    var num = 0
    var num2 = 0
    var num3 = 0
    var channelNum2:Int = 0
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        
        
        //1個目のRSS
        if( channelNum == 0 ){
            switch elementName {
            case "title": self.item?.title = currentString
                
            case "pubDate": self.item?.date = currentString
            case "description" : self.item?.description = currentString
                //   print(currentString)
                
                /*itemが来たら次の項目へ*/
            case "item": self.items.append(self.item!)
            num = num + 1
                
            case "channel" : channelNum = channelNum + 1
                
            default : break
                
            }
            
        }
        
    }
    
    
    func outDescripion(){
        var dateNew : String = ""
        for n in 1...num-1 {
            let text = items[n].description
            let date = items[n].date
            // let text1 = URL( string: url )
            
            let keihou = (text,date)
            
            // let CurrentDate :Date = Date()
            // if(CurrentDate - 60*60*24*7 < dateNew){
            // print(CurrentDate)
            
            //}
            
            //  print( text  , url )
            
            /************時間の整理*************************************/
            //print(date)
            
            let result1 = date.range(of: ",")
            let result2 = date.range(of: ":")
            if let theRange1 = result1{
                if let theRange2 = result2{
                    let afterStr = date[theRange1.upperBound...theRange2.lowerBound]
                    let to = afterStr.index(afterStr.endIndex, offsetBy: -1)
                    dateNew = String(afterStr[afterStr.startIndex ..< to])
                    
                }
            }
            let to1 = dateNew.index(dateNew.endIndex, offsetBy: -2)
            var date2 = String(dateNew[dateNew.startIndex ..< to1])
            print(date2)
            //日付の整理
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MM yyyy"
            
            if let range = date2.range(of: "Dec") {
                date2.replaceSubrange(range, with: "12")
                print(date2)
            }
            if let range = date2.range(of: "Nov") {
                date2.replaceSubrange(range, with: "11")
                print(date2)
            }
            if let range = date2.range(of: "Oct") {
                date2.replaceSubrange(range, with: "10")
                print(date2)
            }
            if let range = date2.range(of: "Sep") {
                date2.replaceSubrange(range, with: "09")
                print(date2)
            }
            if let range = date2.range(of: "Aug") {
                date2.replaceSubrange(range, with: "08")
                print(date2)
            }
            if let range = date2.range(of: "Jul") {
                date2.replaceSubrange(range, with: "07")
                print(date2)
            }
            if let range = date2.range(of: "Jun") {
                date2.replaceSubrange(range, with: "06")
                print(date2)
            }
            if let range = date2.range(of: "May") {
                date2.replaceSubrange(range, with: "05")
                print(date2)
            }
            if let range = date2.range(of: "Apr") {
                date2.replaceSubrange(range, with: "04")
                print(date2)
            }
            if let range = date2.range(of: "Mar") {
                date2.replaceSubrange(range, with: "03")
                print(date2)
            }
            if let range = date2.range(of: "Feb") {
                date2.replaceSubrange(range, with: "02")
                print(date2)
            }
            if let range = date2.range(of: "Jan") {
                date2.replaceSubrange(range, with: "01")
                print(date2)
            }
            
            // 上記の形式の日付文字列から日付データを取得します。
            let d:NSDate = formatter.date(from: date2) as! NSDate
            //3日前の日時
            let y:Date = Date(timeIntervalSinceNow: -60*60*24*6)
            let x = formatter.string(from: y)
            let now5:NSDate = formatter.date(from: x) as! NSDate
            //print (now5,d)
            
            if(now5.compare(d as Date) == .orderedAscending){
                
                self.keihouList.append(keihou)
                
            }
            
        }
        
    }
    
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var Earthlabel: UILabel!
    //戻るボタン
    var page1Controller : SonaeViewController?
    var page2Controller : EarthquakeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print( "よばれたよ")
        tableView2.estimatedRowHeight = 200
        tableView2.rowHeight = UITableView.automaticDimension
        
        //複数セルを編集可能にする
        tableView2.allowsMultipleSelectionDuringEditing = true
        tableView2.delegate = self
        tableView2.dataSource = self
        //ボタン２行表示
        btnModoru.titleLabel?.numberOfLines = 2;
        btnModoru.backgroundColor = UIColor.rgba(red: 122, green: 174, blue: 252, alpha: 1)
        btnModoru.setTitleColor(UIColor.white, for: .normal)
        //buttonコーナーを丸く
        btnModoru.layer.cornerRadius = 15.0
        page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
    }
    @IBAction func btnBack(_ sender: Any) {
        //displayContentController(content: page1Controller!, container: view)
        //hideContentController(content: page2Controller! )
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
    func createPage1ViewController() -> SonaeViewController{
        let sb:UIStoryboard = UIStoryboard(name: "SonaeViewController",bundle: nil)
        let sController:SonaeViewController = sb.instantiateInitialViewController() as! SonaeViewController
        return sController
    }
    func createPage2ViewController() -> EarthquakeViewController{
        let sb:UIStoryboard = UIStoryboard(name: "EarthquakeViewController",bundle: nil)
        let sController:EarthquakeViewController = sb.instantiateInitialViewController() as! EarthquakeViewController
        return sController
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("画面表示前に呼ばれる")
        Earthlabel.text = "地震情報"
        channelNum=0;
        channelNum2=0;
        
        num = 0
        num2 = 0
        num3 = 0
        startDownload()
        outDescripion()
        
        //
        self.tableView2.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        keihouList  = []
        
        tableView2.reloadData()
        
        print("画面遷移後によばれた")
        
        
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
}

