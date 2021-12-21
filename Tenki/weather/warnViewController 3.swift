//
//  warnViewController.swift
//  SHSinfo2018
//
//  Created by 吉川哲也 on 2018/06/02.
//  Copyright © 2018年 SHS情報技術. All rights reserved.
//

import UIKit

class warnViewController: UIViewController , XMLParserDelegate , UITableViewDataSource ,UITableViewDelegate {
    var parser : XMLParser!
    
    //複数の記事を格納するために配列
    var items = [Item3]()
    //Itemクラスのプロパティ　title,url,descriptionの２つのプロパティをもつ
    var item:Item3?
    
    var Num :String = ""
    var currentString = ""
    
    
    
    @IBOutlet weak var tableView2: UITableView!
    
    //警報・注意報のタプル配列
    var keihouList : [( description:String ,image:String )] = []
    
    // セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //今回表示を行うCellオブジェクトを１行取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "keihoCell" , for: indexPath)
        //警報・注意報を設定
        cell.textLabel?.text = keihouList[indexPath.row].description
        //警報・注意報の画像を取得
        let url = keihouList[indexPath.row].image
        print("url",url)
        //警報・注意報がない場合画像は取得できないので、処理をとばす。
       
        if url != "" {
            let url2 = URL( string: url )
            if let imageData = try? Data(contentsOf: url2! ){
                cell.imageView?.image = UIImage(data: imageData)
            }
        }
        else {
           cell.imageView?.image = UIImage(named: "white.png")
           
        }
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
        
        
        let num = Int( Num )
        
        
        if num == 0 {
            warnUrl = "http://weather.livedoor.com/forecast/rss/warn/01a.xml"
        }
        else if num == 1 {
            warnUrl = "http://weather.livedoor.com/forecast/rss/warn/01c.xml"
        }
        else if num == 2 {
            warnUrl = "http://weather.livedoor.com/forecast/rss/warn/01d.xml"
        }
        else if num == 3 {
            warnUrl = "http://weather.livedoor.com/forecast/rss/warn/01b.xml"
        }
        else if num == 4 {
            warnUrl = "http://weather.livedoor.com/forecast/rss/warn/01d.xml"
        }
        else if num! >= 5  {
            let num22 = num! - 3
            
            //2桁の文字列に変換　”３”→”０３”
            let num222 = String(format: "%02d" , num22 )
            
            warnUrl = "http://weather.livedoor.com/forecast/rss/warn/" + num222 + ".xml"
        
        }
        
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
                self.item = Item3()
                
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
                
            case "url": self.item?.url = currentString
            case "description" : self.item?.description = currentString
              //   print(currentString)
            case "pubDate" : self.item?.date = currentString
                /*itemが来たら次の項目へ*/
            case "item": self.items.append(self.item!)
            num = num + 1
                
            case "channel" : channelNum = channelNum + 1
                
            default : break
                
            }
            
        }
  
    }
    
    
    func outDescripion(){
       print(num)
        //警報・注意報が出ているか調査
        let date = items[1].date
        var dateNew :String = ""
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
        let d1:NSDate = formatter.date(from: date2) as! NSDate
        //2日前の日時
        let y:Date = Date(timeIntervalSinceNow: -60*60*24*1)
        let x = formatter.string(from: y)
        let now5:NSDate = formatter.date(from: x) as! NSDate
        //print (now5,d)
        //本日　警報、注意報が出ていた表示
        print(x,d1)
        //2日以内の警報・注意報を表示
        if(now5.compare(d1 as Date) == .orderedAscending){
           
                for n in 1...num-1 {
                    let text = items[n].description
                    let url = items[n].url
                    // let text1 = URL( string: url )
                    let keihou = (text,url)
                  //  print( text  , url)
                    self.keihouList.append(keihou)
                }
        }
    }

    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var preflabel: UILabel!
    
    @IBOutlet weak var btnModoru: UIButton!
    
    
    //戻るボタン
    var page1Controller : SonaeViewController?
   var page2Controller : warnViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print( "よばれたよ")
       /* let userDefaults = UserDefaults.standard
        let numdemo = userDefaults.string(forKey: "Num")
        print(numdemo!+"kokokokokooko")
        if ( numdemo != nil){
            Num = userDefaults.string(forKey: "Num")!
            preflabel.text = userDefaults.string(forKey: "Ken")! + "の気象に関する警報・注意報"
        }
        else {
            Num = "48"
            preflabel.text = "宮崎県の気象に関する警報・注意報"
        }
 */
        // print( Num)
       // startDownload()
       
       // outDescripion()
        
        //引っ張って更新
       // tableView2.refreshControl = refreshControl
       // refreshControl.addTarget(self, action: #selector(weatherViewController.refresh(sender:)), for: .valueChanged)
       //複数セルを編集可能にする
        tableView2.allowsMultipleSelectionDuringEditing = true
        tableView2.delegate = self
        tableView2.dataSource = self
        
        //戻るボタン２行表示
        btnModoru.titleLabel?.numberOfLines = 2;
        btnModoru.backgroundColor = UIColor.rgba(red: 122, green: 174, blue: 252, alpha: 1)
        btnModoru.setTitleColor(UIColor.white, for: .normal)
        //buttonコーナーを丸く
        btnModoru.layer.cornerRadius = 15.0
        //戻るボタン
        page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
        
     
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        print("画面表示前に呼ばれる")
        let userDefaults = UserDefaults.standard
        var numdemo : String? = nil
        if userDefaults.string(forKey: "Num") != nil{
             numdemo = userDefaults.string(forKey: "Num")
        }
       
      //  print(numdemo! + "kokokokokooko")
        if ( numdemo != nil){
            Num = userDefaults.string(forKey: "Num")!
            preflabel.text = userDefaults.string(forKey: "Ken")! + "の気象に関する警報・注意報"
            print("8/15" + userDefaults.string(forKey: "Ken")!)
        }
        else {
            Num = "48"
            preflabel.text = "宮崎県の気象に関する警報・注意報"
        }
        
        
        
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
    //引っ張って更新
  /*  @objc func refresh(sender: UIRefreshControl){
        //viewDidLoad()
        //pickerViewのデリゲートになる
        channelNum=0;
        channelNum2=0;
        
        num = 0
        num2 = 0
        num3 = 0

        startDownload()
        outDescripion()
        //tableView2.dataSource = self
        print("引っ張られた")
        
        didReload()
    }
    func didReload()
    {
        refreshControl.endRefreshing()//インジケータを終了する
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       keihouList  = []
      
        tableView2.reloadData()
     //   print("画面遷移後によばれた")
    }
    @IBAction func btnBack(_ sender: Any) {
       // displayContentController(content: page1Controller!, container: view)
       // hideContentController(content: page2Controller!)
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
    func createPage2ViewController() ->warnViewController{
        let sb:UIStoryboard = UIStoryboard(name: "warnViewController",bundle: nil)
        let sController:warnViewController = sb.instantiateInitialViewController() as! warnViewController
        return sController
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
}
