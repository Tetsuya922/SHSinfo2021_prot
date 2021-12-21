//
//  KisyoutyouViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/07/22.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation

class KisyoutyouViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var webview1: WKWebView!
    @IBOutlet weak var webview2: WKWebView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var slider1: UISlider!

    @IBOutlet weak var modorubtn: UIButton!
    
    var zoom :String = "9"
    var lat :String = "31.72350"
    var lon :String = "131.080266"
    
    // 緯度
    var latitudeNow: String = ""
    // 経度
    var longitudeNow: String = ""
    
    var sliderValue:CGFloat = 0.0

    @IBOutlet weak var view3: UIStackView!
    @IBOutlet weak var btn1: UIButton!
    let stacview = UIStackView()
    var stacFlag : Bool = true
    
    var homeUrl = ""
    var kikiFlag = 0


    // リスト
    let dataList = ["土砂災害","浸水害","洪水害"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wid = view.frame.width
        let hei = view.frame.height
        webview1.frame = CGRect(x: 0, y: 50, width: wid, height: hei)
        webview2.frame = CGRect(x: 0, y: 50, width: wid, height: hei)
        view.addSubview(webview1)
        view.addSubview(webview2)
        //buttonコーナーを丸く
        modorubtn.layer.cornerRadius = 15.0
        
        let userDefaults = UserDefaults.standard
        if let  value = userDefaults.string(forKey: "latitude"){
        //取り出した値をprefNumに保存
            lat = value
        }
        //longitudeというキーを指定して保存していた値を取り出す
        if let  value = userDefaults.string(forKey: "longitude"){
        //取り出した値をprefNumに保存
            lon = value
        }
        print(lat,lon)
        //buttonコーナーを丸く
        modorubtn.layer.cornerRadius = 15.0
        
        label1.text = "雨雲と重ねるキキクルを選んできください"
        label2.text = "雨雲viewの透過度"
        btn1.setTitle("折りたたむ", for: .normal)
        
        
       // view2.frame = CGRect(x:0,y:200,width:view.frame.width ,height:200 )
        
        stacview.axis = .vertical
        //stacview.alignment = .center
        //stacview.distribution = .equalCentering
        stacview.frame = CGRect(x:0,y:view.frame.height-200,width:view.frame.width
                                
                                ,height:200 )
        stacview.addArrangedSubview(btn1)
        stacview.addArrangedSubview(view3)
        stacview.backgroundColor = UIColor.white
        //stacview.alpha = 1.0
        view.addSubview(stacview)
       
      
        homeUrl = "https://www.jma.go.jp/bosai/nowc/#zoom:"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:hrpns&slmcs"
        var url1 = URL(string:
                                "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:land")!
        switch kikiFlag {
        case 0:
            url1 = URL(string:
                             "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:land")!
            break
        case 1:
            url1 = URL(string:
                             "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:inund")!
            break
            
        default:
            url1 = URL(string:
                              "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:flood")!
        }
        
      
       
        let req1 = URLRequest(url: url1)
        webview1.load(req1)
        
        webview2.alpha = 0.0
        
    
    /*
       self.webview2!.isOpaque = false
        self.webview2!.backgroundColor = UIColor.clear
        self.webview2!.scrollView.backgroundColor = UIColor.clear
        */
        // オブサーバーの設定
        self.webview2?.addObserver(self, forKeyPath:"URL", options:.new, context:nil)
        openUrl(urlString: homeUrl)
        
       
        // Delegate設定
        picker1.delegate = self
        picker1.dataSource = self
        
        //webkitタップしたとき タップイベントをとる
         let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
         tapRecognizer.numberOfTapsRequired = 1
         
         //このときUIGestureRecognizerDelegateに準拠したオブジェクトを設定する。
         tapRecognizer.delegate = self
         webview2.addGestureRecognizer(tapRecognizer)
         
         let touchDown = UILongPressGestureRecognizer(target:self, action: #selector(didTouchDown))
             touchDown.minimumPressDuration = 0
         webview2.addGestureRecognizer(touchDown)
        
        
        //picker 初期値
        picker1.selectRow(kikiFlag, inComponent: 0, animated: false)
       
        
      
    }
    @objc private func handleTap(_ sender:UITapGestureRecognizer){
        NSLog("tap")
       
        
    }
    @objc func didTouchDown(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            NSLog("tap start")
            webview2.alpha = 1.0
        }
        if gesture.state == .ended{
            NSLog("end")
            webview2.alpha = CGFloat(sliderValue)
        }
    }
    

    func openUrl(urlString: String){
           let url = URL(string: urlString)
           let urlRequest = URLRequest(url: url!)
         
           webview2.load(urlRequest)
       }

    deinit {
           self.webview2?.removeObserver(self, forKeyPath: "URL")
    }

    @IBAction func modoru(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func view_active(_ sender: Any) {
        let x = webview2.frame.minX
        let y = webview2.frame.minY
        let xx = webview2.frame.width
        let yy = webview2.frame.height
        
        print(x,y,xx,yy)
        
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            switch keyPath {
                case "URL"?:
                    if let url = change![NSKeyValueChangeKey.newKey] as? URL {
                        let urlString: String = url.absoluteString
                        // ページアクセスするたびにURLを取得
                        print(url)
                        let result1 = urlString.range(of: "zoom:")
                        if let theRange = result1 {
                            let afterStr = urlString[theRange.upperBound...]
                            let idx = afterStr.index(of: "/")
                            self.zoom = String(urlString[theRange.upperBound..<idx!])
                            print(self.zoom)
                        }
                        let result2 = urlString.range(of: "lat:")
                        if let theRange = result2 {
                            let afterStr = urlString[theRange.upperBound...]
                            let idx = afterStr.index(of: "/")
                            self.lat = String(urlString[theRange.upperBound..<idx!])
                            print(self.lat)
                        }
                        let result3 = urlString.range(of: "lon:")
                        if let theRange = result3 {
                            let afterStr = urlString[theRange.upperBound...]
                            let idx = afterStr.index(of: "/")
                            self.lon = String(urlString[theRange.upperBound..<idx!])
                            print(self.lon)
                        }
                        
                        var url1 = URL(string:
                                                "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:land")!
                        switch kikiFlag {
                        case 0:
                            url1 = URL(string:
                                             "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:land")!
                            break
                        case 1:
                            url1 = URL(string:
                                             "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:inund")!
                            break
                            
                        default:
                            url1 = URL(string:
                                              "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:flood")!
                        }
                       
                        let req1 = URLRequest(url: url1)
                        webview1.load(req1)
                        
                        
                    }
            default:
                break
            }

        }

    @IBAction func sliderAction(_ sender: UISlider) {
        print(sender.value)
       
        sliderValue = CGFloat(sender.value)
        webview2.alpha = CGFloat(sliderValue)
    }
    
    @IBAction func btn1(_ sender: Any) {
        if stacFlag {
            stacview.frame  = CGRect(x:0,y:view.frame.height-50,width:view.frame.width
                                   
                                   ,height:50 )
            stacFlag = !stacFlag
            btn1.setTitle("コントローラーの表示", for: .normal)
        }else{
            stacview.frame  = CGRect(x:0,y:view.frame.height-200,width:view.frame.width
                                   
                                   ,height:200 )
            stacFlag = !stacFlag
            btn1.setTitle("折りたたむ", for: .normal)
        }
        
        view3.isHidden = !view3.isHidden
    }
    
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
     
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
     
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
       
        
        var url1 = URL(string:
                        "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:land")!
        //土砂災害
        if row == 0{
            kikiFlag = 0
           url1 = URL(string:
                            "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:land")!
           
        
        }
        //浸水害
        else if row == 1 {
            kikiFlag = 1
           url1 = URL(string:
                            "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:inund")!
           
           
        }
        //
        else{
            kikiFlag = 2
          url1 = URL(string:
                            "https://www.jma.go.jp/bosai/risk/#zoom:+"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:flood")!
           
            
        }
        let req1 = URLRequest(url: url1)
        webview1.load(req1)
    }
}
extension KisyoutyouViewController: CLLocationManagerDelegate ,UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    /// 位置情報が更新された際、位置情報を格納する
    /// - Parameters:
    ///   - manager: ロケーションマネージャ
    ///   - locations: 位置情報
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        // 位置情報を格納する
        self.latitudeNow = String(latitude!)
        self.longitudeNow = String(longitude!)
        print(latitudeNow,longitudeNow)
        //緯度、経度を保存
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        //areaCodeというキーで保存
        userDefaluts.set(latitudeNow, forKey: "latitude")
        userDefaluts.set(longitudeNow, forKey: "longitude")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        /********************/    }
}
