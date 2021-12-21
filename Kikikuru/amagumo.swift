//
//  amagumo.swift
//  SHSinfo2021
//
//  Created by 吉川哲也 on 2021/12/09.
//  Copyright © 2021 SHS情報技術. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation

class amagumo: UIViewController {
    @IBOutlet weak var modorubtn: UIButton!
    @IBOutlet weak var webview: WKWebView!
    var zoom :String = "9"
    var lat :String = "31.72350"
    var lon :String = "131.080266"
    
    // 緯度
    var latitudeNow: String = ""
    // 経度
    var longitudeNow: String = ""
    
    /// ロケーションマネージャ
    var locationManager: CLLocationManager!
    
    var homeUrl = ""




    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ロケーションマネージャのセットアップ
        //setupLocationManager()
        //アプリ利用中の位置情報の利用許可を得る
       // locationManager.requestWhenInUseAuthorization()//セキュリティの設定の確認
        //ロケーションマネージャーのdelegateになる
        //locationManager.delegate = self
        
        //  if #available(iOS 9.0, *) {
       //locationManager.requestLocation() // 一度きりの取得
        // Do any additional setup after loading the view.
        
        
        
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

        homeUrl = "https://www.jma.go.jp/bosai/nowc/#zoom:"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:hrpns&slmcs"
       
        
      
        let url1 = URL(string:homeUrl)
        let req1 = URLRequest(url: url1!)
        webview.load(req1)
        
    }
    
    @IBAction func modoru(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
        
    }
    /*
    /// ロケーションマネージャのセットアップ
        func setupLocationManager() {
            locationManager = CLLocationManager()

            // 権限をリクエスト
            guard let locationManager = locationManager else { return }
            locationManager.requestWhenInUseAuthorization()

            // マネージャの設定
            let status = CLLocationManager.authorizationStatus()

            // ステータスごとの処理
            if status == .authorizedWhenInUse {
                locationManager.delegate = self
                locationManager.startUpdatingLocation()
            }
        }
    /// アラートを表示する
       func showAlert() {
           let alertTitle = "位置情報取得が許可されていません。"
           let alertMessage = "設定アプリの「プライバシー > 位置情報サービス」から変更してください。"
           let alert: UIAlertController = UIAlertController(
               title: alertTitle,
               message: alertMessage,
               preferredStyle:  UIAlertController.Style.alert
           )
           // OKボタン
           let defaultAction: UIAlertAction = UIAlertAction(
               title: "OK",
               style: UIAlertAction.Style.default,
               handler: nil
           )
           // UIAlertController に Action を追加
           alert.addAction(defaultAction)
           // Alertを表示
           present(alert, animated: true, completion: nil)
       }
  */
    }
/*
extension amagumo: CLLocationManagerDelegate{
    
/// 位置情報が更新された際、位置情報を格納する
    /// - Parameters:
    ///   - manager: ロケーションマネージャ
    ///   - locations: 位置情報
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        // 位置情報を格納する
        self.latitudeNow = String(format:"%.6f",latitude!)
        self.longitudeNow = String(format:"%0.6f",longitude!)
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
*/
