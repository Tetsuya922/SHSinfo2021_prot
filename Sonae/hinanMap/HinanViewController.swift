//
//  HinanViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/07/22.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation
import HNToaster
//import MaterialComponents

class HinanViewController: UIViewController ,UITextFieldDelegate,CLLocationManagerDelegate{
    
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var check1: UIButton!
    @IBOutlet weak var check2: UIButton!
    @IBOutlet weak var check3: UIButton!
    @IBOutlet weak var check4: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet var view1: UIView!
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var RouteBtn: UIButton!
    @IBOutlet weak var genzaiBtn: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var label_chiriin: UILabel!
    
    var locationManager : CLLocationManager! //位置情報を管理するクラス
    var latitude:Double!
    var longitude:Double!
    var SearchAddress:String = ""
    var timer1: Timer?
    var timer2: Timer?
    var timer3: Timer?
    var timer4: Timer?
    var Hinan:String = "45201"
    var currentLatitude: CLLocationDegrees!
    var currentLongitude: CLLocationDegrees!
    var type :Int = 2
    //現在地か、検索地区かのフラグ
    var flag1 :Int = 0
    //くるくる
    var ActivityIndicator: UIActivityIndicatorView!
    
    //避難所データがあるかないか ある　true
    var hinanCount:Bool = true
    
    //近い避難所
    var hinanjyo5 = [HinanJyo]()
    
    @IBOutlet weak var AR_btn:UIButton!
    
    
   private let tileOverlay = MKTileOverlay(urlTemplate: "https://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //マップ関連の初期化処理
        mapView.delegate = self
      
        setupLocationManager()
        //buttonコーナーを丸く
        searchBtn.layer.cornerRadius = 15.0
        genzaiBtn.layer.cornerRadius = 15.0
        RouteBtn.layer.cornerRadius = 15.0
        back.layer.cornerRadius = 15.0
        
        let width = view.frame.width
        let height = view.frame.height
        
        //button表示
        AR_btn.isEnabled = false
        
        
      
        
        
        // Do any additional setup after loading the view, typically from a nib.
        inputText.delegate = self
       
        locationManager!.delegate = self
       //方角取得
       if CLLocationManager.locationServicesEnabled() {
             // 何度動いたら更新するか（デフォルトは1度）
             locationManager.headingFilter = kCLHeadingFilterNone
             // デバイスのどの向きを北とするか（デフォルトは画面上部）
             locationManager.headingOrientation = .portrait
             locationManager.startUpdatingHeading()
         }
        mapView.setUserTrackingMode(.follow, animated: true)
       locationManager.requestLocation() // 一度きりの取得
       
        //ランニングなど
       // locationManager.activityType = .fitness
        
       

        
        // ActivityIndicatorを作成＆中央に配置
        ActivityIndicator = UIActivityIndicatorView()
        //ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        ActivityIndicator.center = self.view.center
        // クルクルをストップした時に非表示する
        ActivityIndicator.hidesWhenStopped = true
        //大きく表示
        ActivityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        // 色を設定
        ActivityIndicator.color = UIColor.blue
        //Viewに追加
        self.view1.addSubview(ActivityIndicator)
        // クルクルスタート
        ActivityIndicator.startAnimating()
        
        var flag1:Bool = UserDefaults.standard.bool(forKey: "hinanView")
        if flag1 == true {
                    //2秒後に実行
                    /* timer1 = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: false)
                     //3秒後に実行
                     timer2 = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ViewController.timerUpdate2), userInfo: nil, repeats: false)
                     */
                    lab1.text="目的の避難場所を選んで、ルートボタンを押してください"
                    
                    //ラジオボタン配置
                    check1.frame = CGRect(x:10,y:150,width:30,height: 30)
                    check2.frame = CGRect(x:80,y:150,width:30,height: 30)
                    check3.frame = CGRect(x:150,y:150,width:30,height: 30)
                    check4.frame = CGRect(x:220,y:150,width:30,height: 30)
                    label1.frame = CGRect(x:40,y:150,width:60,height: 30)
                    label2.frame = CGRect(x:110,y:150,width:60,height: 30)
                    label3.frame = CGRect(x:180,y:150,width:60,height: 30)
                    label4.frame = CGRect(x:250,y:150,width:60,height: 30)
                    label1.text = "洪水"
                    label2.text = "地震"
                    label3.text = "津波"
                    label4.text = "避難所"
                    //ラジオボタンに画像をセット
                    check1.setImage(UIImage(named: "checkBox"), for: UIControl.State.normal)
                    check1.setImage(UIImage(named: "checkBoxOn"), for: UIControl.State.selected)
                    check2.setImage(UIImage(named: "checkBox"), for: UIControl.State.normal)
                    check2.setImage(UIImage(named: "checkBoxOn"), for: UIControl.State.selected)
                    check3.setImage(UIImage(named: "checkBox"), for: UIControl.State.normal)
                    check3.setImage(UIImage(named: "checkBoxOn"), for: UIControl.State.selected)
                    check4.setImage(UIImage(named: "checkBox"), for: UIControl.State.normal)
                    check4.setImage(UIImage(named: "checkBoxOn"), for: UIControl.State.selected)
                    //初期値
                    check2.isSelected=true
                    label2.textColor = UIColor.red
                    self.type = 2
                    
                    mapView.frame = CGRect(x:0,y:180,width: self.view.bounds.width,height: self.view.bounds.height-250)
                    AR_btn.frame = CGRect(x:self.view.bounds.width-100,y:self.view.bounds.height-70,width: 100,height: 30)
                    label_chiriin.frame = CGRect(x:10,y:self.view.bounds.height-70,width: 100,height: 30)
                    label_chiriin.text = "地理院地図"
                    //地理院地図
                    mapView.addOverlay(tileOverlay, level: .aboveLabels)
                    //現在地のマークを消す
                    self.mapView.showsUserLocation = false
                    
                    //７秒後に実行
                    timer4 = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(HinanViewController.timerUpdate4), userInfo: nil, repeats: false)
        }
        
        
}
    
    
    func setupLocationManager() {
            locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        //アプリ利用中の位置情報の利用許可を得る
        locationManager.requestWhenInUseAuthorization()//セキュリティの設定の確認
        let status = CLLocationManager.authorizationStatus()
                if status == .authorizedWhenInUse {
                    locationManager.delegate = self
                    locationManager.distanceFilter = 10
                    locationManager.startUpdatingLocation()
                }
        }
    
    
    @IBAction func check1Act(_ sender: Any) {
        check4.isSelected = false
        check3.isSelected = false
        check2.isSelected = false
        check1.isSelected = true
        label1.textColor = UIColor.red
        label2.textColor = UIColor.systemBlue
        label3.textColor = UIColor.systemBlue
        label4.textColor = UIColor.systemBlue
        self.type = 1
        //timerUpdate()
        if self.flag1 == 1{
            timerUpdate2()
        }else{
            timerUpdate3()
        }
        
}
    @IBAction func check2Act(_ sender: Any) {
        check4.isSelected = false
        check1.isSelected = false
        check3.isSelected = false
        check2.isSelected = true
        label2.textColor = UIColor.red
        label1.textColor = UIColor.systemBlue
        label3.textColor = UIColor.systemBlue
        label4.textColor = UIColor.systemBlue
        self.type = 2
        //timerUpdate()
        if self.flag1 == 1{
            timerUpdate2()
        }else{
            timerUpdate3()
        }
}
    @IBAction func check3Act(_ sender: Any) {
        check4.isSelected = false
        check2.isSelected = false
        check1.isSelected = false
        check3.isSelected = true
        label3.textColor = UIColor.red
        label2.textColor = UIColor.systemBlue
        label1.textColor = UIColor.systemBlue
        label4.textColor = UIColor.systemBlue
        self.type = 3
        //timerUpdate()
        if self.flag1 == 1{
            timerUpdate2()
        }else{
            timerUpdate3()
        }
}
    @IBAction func check4Act(_ sender: Any) {
        check3.isSelected = false
              check2.isSelected = false
              check1.isSelected = false
              check4.isSelected = true
              label4.textColor = UIColor.red
              label2.textColor = UIColor.systemBlue
              label1.textColor = UIColor.systemBlue
              label3.textColor = UIColor.systemBlue
              self.type = 4
              //timerUpdate()
              if self.flag1 == 1{
                  timerUpdate2()
              }else{
                  timerUpdate3()
              }
    }
    @objc func timerUpdate(){
        /*****************市町村コードを配列に読み込む*******************************/
        let city_code = CsvDataManager.sharedInstance
        city_code.loadWord()
        city_code.nowWordIndex=1
        while city_code.nowWordIndex < city_code.CsvDataArray.count {
            let word1 = city_code.nextWord()
            
            var num:Int = word1!.wordNumber
            num-=1
            city_code.nowWordIndex += 1
        }
        print("ここです",self.SearchAddress)
        
        //宮崎県東諸県郡国富町　を　宮崎県国富町に変換
        if self.SearchAddress.hasSuffix("町") || self.SearchAddress.hasSuffix("村"){
            
            //北海道
            if self.SearchAddress.prefix(2) == "北海"{
                let array2 = SearchAddress.components(separatedBy: "道")
                let pref = array2[0] + "道"
                let array1 = SearchAddress.components(separatedBy: "郡")  // ,で分割する
                print(array1,array1.count)
                var city:String = ""
                if array1.count==2 {
                    city = array1[array1.count-1]
                    SearchAddress = pref + city
                }
                if array1.count>=3 {
                    //city = array1[array1.count-1]
                    let city2:String = array1[array1.count-2] + "郡" + array1[array1.count-1]
                    SearchAddress = pref + city2
                    }
            }
            //東京
               else if self.SearchAddress.prefix(2) == "東京"{
                   let array2 = SearchAddress.components(separatedBy: "都")
                   let pref = array2[0] + "都"
                   let array1 = SearchAddress.components(separatedBy: "郡")  // ,で分割する
                   print(array1,array1.count)
                   var city:String = ""
                   if array1.count==2 {
                       city = array1[array1.count-1]
                       SearchAddress = pref + city
                   }
                   if array1.count>=3 {
                       //city = array1[array1.count-1]
                       let city2:String = array1[array1.count-2] + "郡" + array1[array1.count-1]
                       SearchAddress = pref + city2
                       }
               }
            //大阪　京都
            else if self.SearchAddress.prefix(2) == "大阪" || self.SearchAddress.prefix(2) == "京都"{
                let array2 = SearchAddress.components(separatedBy: "府")
                let pref = array2[0] + "府"
                let array1 = SearchAddress.components(separatedBy: "郡")  // ,で分割する
                print(array1,array1.count)
                var city:String = ""
                if array1.count==2 {
                    city = array1[array1.count-1]
                    SearchAddress = pref + city
                }
                if array1.count>=3 {
                    //city = array1[array1.count-1]
                    let city2:String = array1[array1.count-2] + "郡" + array1[array1.count-1]
                    SearchAddress = pref + city2
                    }
            }
            //それ以外
               else{
                   let array2 = SearchAddress.components(separatedBy: "県")
                   let pref = array2[0] + "県"
                   let array1 = SearchAddress.components(separatedBy: "郡")  // ,で分割する
                   print(array1,array1.count)
                   var city:String = ""
                   if array1.count==2 {
                       city = array1[array1.count-1]
                       SearchAddress = pref + city
                   }
                   if array1.count>=3 {
                       //city = array1[array1.count-1]
                       let city2:String = array1[array1.count-2] + "郡" + array1[array1.count-1]
                       SearchAddress = pref + city2
                       }
               }
        }
        print("変換後",SearchAddress)
        
       
        if city_code.CsvDataArray.count != 0{
            //市町村コードの出力
            for i in 0...1740 {
                //検索しています。
                if self.SearchAddress.contains(city_code.CsvDataArray[i].name!){
                    print(city_code.CsvDataArray[i].ban!)
                    if(city_code.CsvDataArray[i].etc != "未提出"){
                        Hinan = city_code.CsvDataArray[i].ban!
                        print(Hinan,"2222")
                        hinanCount = true
                        if Hinan.count == 4 {
                            Hinan = "0" + Hinan
                            print(Hinan,"33333")
                        }
                        return
                    }
                    else {hinanCount = false}
                }
            }
        } else {hinanCount = false}
        print("hinancount",hinanCount)
    }
    //避難所データの読み込み
    let annotation = MKPointAnnotation()
  
    
    
    //var annotationaArray: [MKAnnotation] = []
    @objc func timerUpdate2(){
      
        var hinanjyo = HinanJyo()
        var hinanjyos = [HinanJyo]()
        
        //現在地を取得
        let userDefaults = UserDefaults.standard
        let lat = userDefaults.double(forKey: "latGenzai")
        let lon = userDefaults.double(forKey: "lonGenzai")
        
        //ピンをｚすべて削除します
        self.mapView.removeAnnotations(mapView.annotations)
        
        let word = WordsDataManager.sharedInstance
        word.loadWord(csvfile: Hinan)
        word.nowWordIndex=1
        while word.nowWordIndex < word.wordDataArray.count {
            let word1 = word.nextWord()
            
            let name = word1?.name
            let kouzui = word1?.kouzui
            let jishin = word1?.jishin
            let tsunami = word1?.tsunami
            let jyo = word1?.jyo
            let lat1 = word1?.lat
            let lng1 = word1?.lng
            var num:Int = word1!.wordNumber
            num-=1
            //削除する時のために一覧を作成
            annotation.coordinate = CLLocationCoordinate2DMake(lat1!, lng1!)
            
            //避難所と距離を配列に追加
            hinanjyo.name = name ?? "?"
            hinanjyo.kyori = kyori(currentLatitude: CGFloat(lat), currentLongitude: CGFloat(lon), targetLatitude: CGFloat(lat1!), targetLongitude: CGFloat(lng1!))
            hinanjyo.lat = lat1!
            hinanjyo.lon = lng1!
            hinanjyo.kouzui = kouzui!
            hinanjyo.jishin = jishin!
            hinanjyo.tsunami = tsunami!
            hinanjyo.jyo = jyo!
            hinanjyos.append(hinanjyo)
            
            hinanjyo = HinanJyo()
            
            //ピンを立てる
            if (self.type==1) && (kouzui==1 ){
                pin(lat: lat1!,lng: lng1!,title: name!)
            }
            else if(self.type==2) && (jishin==1 ){
                pin(lat: lat1!,lng: lng1!,title: name!)
            }else if(self.type==3) && (tsunami==1 ){
                pin(lat: lat1!,lng: lng1!,title: name!)
            }else if(self.type==4) && (jyo==1 ){
                pin(lat: lat1!,lng: lng1!,title: name!)
            }

            // print(num,name!,kouzui!,jishin!,tunami!,lat!,lng!)
            word.nowWordIndex += 1
        }
        
        //起動時に１回だけ動作させる
        if (hinanjyo5.count == 0){
            //距離で並び替え
            let hinanjyoSort = hinanjyos.sorted(by: {$1.kyori > $0.kyori})
            var i=0
            //上位５件をhinanjyo5にコピー
            for hi: HinanJyo in hinanjyoSort {
                print(hi.name, hi.kyori)
                if i<5 {
                    hinanjyo5.append(hinanjyoSort[i])
                }
                 i=i+1
            }
        }
        //現在地にピンを立てます
       
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
        let myPin: MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate = center
        myPin.title = "現在地"
        self.mapView.addAnnotation(myPin)
        //button表示
        AR_btn.isEnabled = true
        
        print(hinanCount,"kokoです")
        //住所がない場合　
        if hinanCount == false{
            //トースト表示
            let toastFrame: CGRect = CGRect(x: 10, y: self.view.bounds.height - 150, width: self.view.bounds.width - 20, height: 30)
            let messageFont: UIFont = UIFont.italicSystemFont(ofSize: 30)
            Toaster.toast(onView: self.view, message: "避難所データがありません.",frame: toastFrame,font: messageFont)
        }
        
    }
    
    //住所検索で使用
    @objc func timerUpdate3(){
        //ピンをｚすべて削除します
        self.mapView.removeAnnotations(mapView.annotations)
        
        let word = WordsDataManager.sharedInstance
        word.loadWord(csvfile: Hinan)
        word.nowWordIndex=1
        while word.nowWordIndex < word.wordDataArray.count {
            let word1 = word.nextWord()
            
            let name = word1?.name
            let kouzui = word1?.kouzui
            let jishin = word1?.jishin
            let tsunami = word1?.tsunami
            let jyo = word1?.jyo
            let lat = word1?.lat
            let lng = word1?.lng
            var num:Int = word1!.wordNumber
            num-=1
            //削除する時のために一覧を作成
            annotation.coordinate = CLLocationCoordinate2DMake(lat!, lng!)
            //ピンを立てる
            if (self.type==1) && (kouzui==1 ){
                pin(lat: lat!,lng: lng!,title: name!)
            }
            else if(self.type==2) && (jishin==1 ){
                pin(lat: lat!,lng: lng!,title: name!)
            }else if(self.type==3) && (tsunami==1 ){
                pin(lat: lat!,lng: lng!,title: name!)
            }else if(self.type==4) && (jyo==1 ){
                pin(lat: lat!,lng: lng!,title: name!)
            }
            // print(num,name!,kouzui!,jishin!,tunami!,lat!,lng!)
            word.nowWordIndex += 1
        }
        //検索地にピンを立てます
        let userDefaults = UserDefaults.standard
        let lat = userDefaults.double(forKey: "lat")
        let lon = userDefaults.double(forKey: "lon")
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
        let myPin: MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate = center
        myPin.title = "検索地区"
        self.mapView.addAnnotation(myPin)
        
        
        
        //住所がない場合
        if hinanCount == false{
            //トースト表示
            let toastFrame: CGRect = CGRect(x: 10, y: self.view.bounds.height - 150, width: self.view.bounds.width - 20, height: 30)
            let messageFont: UIFont = UIFont.italicSystemFont(ofSize: 30)
            Toaster.toast(onView: self.view, message: "避難所データがありません.",frame: toastFrame,font: messageFont)
        }
        
    }
    //最初に使用
    @objc func timerUpdate4(){
        genzai()
        //くるくるストップ
        self.ActivityIndicator.stopAnimating()
      
}
    //テキストボックスから検索
    @IBAction func SearchMap(_ sender: Any) {
        //初期値
        check4.isSelected = false
        check1.isSelected = false
        check3.isSelected = false
        check2.isSelected = true
        label2.textColor = UIColor.red
        label1.textColor = UIColor.systemBlue
        label3.textColor = UIColor.systemBlue
        label4.textColor = UIColor.systemBlue
        self.type = 2
        //フラグを検索地区に設定
        self.flag1 = 2
        
//        mapView.removeOverlays(mapView.overlays)
        //地理院地図
        mapView.addOverlay(tileOverlay, level: .aboveLabels)


        guard let add = inputText.text else { return  }
        // 入力された住所を元に取材地の座標を登録
        let myGeocoder:CLGeocoder = CLGeocoder()
        myGeocoder.geocodeAddressString(add, completionHandler: {(placemarks, error)in
            if(error == nil) {
                for placemark in placemarks! {
                    let location:CLLocation = placemark.location!
                    
                    //中心座標
                    let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(location.coordinate.latitude,forKey: "lat")
                    userDefaults.set(location.coordinate.longitude,forKey: "lon")
                    //表示範囲
                    let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                    
                    //中心座標と表示範囲をマップに登録する。
                    let region = MKCoordinateRegion(center: center, span: span)
                    self.mapView.setRegion(region, animated:true)
                    
                    //地図にピンを立てる。
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                    annotation.title = "検索地区"
                   
                    self.mapView.addAnnotation(annotation)
                    
                    //住所検索
                    self.addressSearch(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                    //2秒後に実行
                    self.timer1 = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(HinanViewController.timerUpdate), userInfo: nil, repeats: false)
                    //3秒後に実行
                    self.timer3 = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(HinanViewController.timerUpdate3), userInfo: nil, repeats: false)
                    
                }
            } else {
                self.inputText.text = "検索できませんでした。"
            }
        })
        // キーボードを閉じる
        textFieldShouldReturn(inputText)
}

    @IBAction func genzai(_ sender: Any) {
        //初期値
        check4.isSelected = false
        check1.isSelected = false
        check3.isSelected = false
        check2.isSelected = true
        label2.textColor = UIColor.red
        label1.textColor = UIColor.systemBlue
        label3.textColor = UIColor.systemBlue
        label4.textColor = UIColor.systemBlue
        
        //地震を表示
        self.type = 2
        locationManager.requestLocation()
       genzai()
    }
    
    
    func genzai(){
        //フラグを現在地に設定
        self.flag1 = 1
        let userDefaults = UserDefaults.standard
       // let lat = userDefaults.double(forKey: "latGenzai")
        //let lon = userDefaults.double(forKey: "lonGenzai")
        var lat :Double
        var lon :Double
        print(latitude,longitude)
        if latitude == 0.0 || latitude == nil{
            lat = userDefaults.double(forKey: "lat")
            lon = userDefaults.double(forKey: "lon")
        }else{
            lat = self.latitude!
            lon = self.longitude!
        }
       
        print(lat,lon,"です")
        
        userDefaults.set(lat,forKey: "lat")
        userDefaults.set(lon,forKey: "lon")
        userDefaults.set(lat,forKey: "latGenzai")
        userDefaults.set(lon,forKey: "lonGenzai")
        
        let center = CLLocationCoordinate2DMake(lat, lon)
        //表示範囲
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        //中心座標と表示範囲をマップに登録する。
        let region = MKCoordinateRegion(center: center, span: span)
        self.mapView.setRegion(region, animated:true)
 
        //住所検索
        if lat != 0{
            print(lat , "です")
        self.addressSearch(lat: lat, lon: lon)
        //1秒後に実行
        self.timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HinanViewController.timerUpdate), userInfo: nil, repeats: false)
        //1秒後に実行
        self.timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HinanViewController.timerUpdate2), userInfo: nil, repeats: false)
            
            
        }
    }
    
    @IBAction func AR_btn(_ sender: Any) {
        
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "AR") as! ARViewController
       //値の渡し
        nextView.direc = (locationManager.heading?.magneticHeading ?? 0.0) as Double
        //配列の渡し
        nextView.hinanjyo5 = self.hinanjyo5
        self.present(nextView, animated: true, completion: nil)
    }
    
    @IBAction func route(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        let lat = userDefaults.double(forKey: "lat")
        let lon = userDefaults.double(forKey: "lon")
        let latobj = userDefaults.double(forKey: "latObj")
        let lonobj = userDefaults.double(forKey: "lonObj")
        
        print(lat,lon,latobj,lonobj)
        
   
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    //ピンが押されたとき
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        
        let annotation = view.annotation
        let title = annotation?.title
       // print("押された",annotation?.title)
        //  print(title,annotation?.coordinate)
        let latitude = annotation?.coordinate.latitude
        let longitude = annotation?.coordinate.longitude
        let userDefaults = UserDefaults.standard
        userDefaults.set(latitude,forKey: "latObj")
        userDefaults.set(longitude,forKey: "lonObj")
        
    }
    //現在地にのピンの色を設定
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
      //  var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKMarkerAnnotationView
        
        var pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        //吹き出しを表示可能に。
        pinView.canShowCallout = true
        if (annotation.title == "現在地") || (annotation.title == "検索地区"){
           
            pinView.pinTintColor = UIColor.rgba(red: 247, green: 60, blue: 255, alpha: 1)
            
         
           
        }else{
           //pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            switch (self.type){
                case 1: pinView.pinTintColor = UIColor.blue
                case 2: pinView.pinTintColor = UIColor.rgba(red: 21, green: 123, blue: 19, alpha: 1)
                case 3: pinView.pinTintColor = UIColor.red
                case 4: pinView.pinTintColor = UIColor.purple
                
                default: pinView.pinTintColor = UIColor.blue
            }
           // pinView.pinTintColor = UIColor.green
           
        }
        //吹き出しを表示可能に。
       // pinView.canShowCallout = true
        
        return pinView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // manager.delegate = self as! CLLocationManagerDelegate //Delegateを設定
        locationManager.requestWhenInUseAuthorization()//ユーザに許可を求める
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func pin(lat:Double,lng:Double,title:String) {
        
        addAnnotation(latitude: lat,longitude: lng,title: title)
        
    }
    //ロケーション機能の設定
  /*  func setupLocationService(){
        //ロケーションの精度を設定する
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距離（メートル）
        locationManager.distanceFilter = 5
    }*/
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse,.authorizedAlways:
         //位置情報の更新を開始
         locationManager.startUpdatingLocation()
          
         default:
         break
         }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //位置情報を１回取得
        if currentLatitude == nil && currentLongitude == nil {
            currentLatitude = locations.first?.coordinate.latitude
            currentLongitude = locations.first?.coordinate.longitude
            print("ここ通過しました")
            //緯度・経度を取得
            guard let latitude = locations.first?.coordinate.latitude,
                let longitude = locations.first?.coordinate.longitude else{
                    return
            }
            
            
            addressSearch(lat: latitude, lon: longitude)
            
            self.latitude = latitude
            self.longitude = longitude
            
     /*       let userDefaults = UserDefaults.standard
            userDefaults.set(latitude,forKey: "latGenzai")
            userDefaults.set(longitude,forKey: "lonGenzai")
            userDefaults.set(latitude,forKey: "lat")
            userDefaults.set(longitude,forKey: "lon")
            */
        }
        
        self.locationManager.stopUpdatingLocation()
    }
    // requestLocation()を使用する場合、失敗した際のDelegateメソッドの実装が必須
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗しました")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
          
    }
   
    //避難所のピン
    func addAnnotation(latitude: CLLocationDegrees,longitude: CLLocationDegrees, title:String){
        // ピンの生成
        let annotation = MKPointAnnotation()
        // 緯度経度を指定
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        // タイトル、サブタイトルを設定
        annotation.title = title
      
        
        
        // mapViewに追加
        mapView.addAnnotation(annotation)
        self.view.addSubview(mapView)
    }
    
    /*緯度　経度から住所検索*/
    func addressSearch(lat: Double ,lon: Double){
        let geocoder = CLGeocoder()
        
        let location = CLLocation(latitude: lat, longitude: lon)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemarks = placemarks {
            
                    
                if let pm = placemarks.first {
                    if pm.country == "日本"{
                     self.SearchAddress = pm.administrativeArea! + pm.locality!
                        print(self.SearchAddress,"addressSearch",pm.country!)
                    }
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    //距離を計算する
    func kyori(currentLatitude: CGFloat, currentLongitude: CGFloat, targetLatitude: CGFloat, targetLongitude: CGFloat) -> Double {
        let gen : CLLocation = CLLocation(latitude: CLLocationDegrees(currentLatitude), longitude: CLLocationDegrees(currentLongitude))
        let sadowara :CLLocation = CLLocation(latitude: CLLocationDegrees(targetLatitude), longitude: CLLocationDegrees(targetLongitude))
        let distance = sadowara.distance(from: gen)
        return distance
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
        print("koko通過")
        
    }

}

extension HinanViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKTileOverlayRenderer(overlay: overlay)
    }
}
