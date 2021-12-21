//
//  HzMapViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/07/21.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation

class HzMapViewController: UIViewController , CLLocationManagerDelegate {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var webview: WKWebView!
    
    //ロケーションマネージャーを作る
    var locationManager = CLLocationManager()
    
    //緯度経度の変数
    var idoValue :String = ""
    var keidoValue :String = ""
    var page1Controller : SonaeViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        //ラベルの初期化
        disabledLocationLabel()
        //アプリ利用中の位置情報の利用許可を得る
        locationManager.requestWhenInUseAuthorization()//セキュリティの設定の確認
        //ロケーションマネージャーのdelegateになる
        locationManager.delegate = self
        //ロケーション機能の設定
        setupLocationService()
        
        //  if #available(iOS 9.0, *) {
        locationManager.requestLocation() // 一度きりの取得
        // }
        //  else{
        //      locationManager.startUpdatingLocation()//継続的に取得
        //   }
        //webviewの設定
        let myURL = URL(string: "https://disaportal.gsi.go.jp/maps/?ll=" + String(idoValue) + "," +  String(keidoValue) + "&z=12&base=pale&vs=c1j0l0u0")
        let myRequest = URLRequest(url: myURL!)
        
        webview.load(myRequest)
        page1Controller = createPage1ViewController()
        
        
    }
    
    
    @IBAction func leftSwipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    
    
    
    /***************画面遷移**************************/
    func createPage1ViewController() -> SonaeViewController{
        let sb:UIStoryboard = UIStoryboard(name: "SonaeViewController",bundle: nil)
        let sController:SonaeViewController = sb.instantiateInitialViewController() as! SonaeViewController
        return sController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //ロケーション機能の設定
    func setupLocationService(){
        //ロケーションの精度を設定する
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距離（メートル）
        locationManager.distanceFilter = 1000
    }
    
    
    //ロケーションサービスの利用不可メッセージ
    func disabledLocationLabel(){
        
    }
    
    //位置情報利用許可のステータスが変わった
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse :  //利用許可した
            //ロケーションの更新を開始する
            locationManager.startUpdatingLocation()
        case .notDetermined:                            //利用を不許可にした
            //ロケーションの更新を停止する
            locationManager.stopUpdatingLocation()
            disabledLocationLabel()
        default:
            //ロケーションの更新を停止する
            locationManager.stopUpdatingLocation()
            disabledLocationLabel()
            
        }
    }
    //位置を移動した
    
    func  locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationData = locations.last
        //緯度
        if var ido = (locationData?.coordinate.latitude){
            ido = round(ido*1000000)/1000000
            //idoLabel.text = String(ido)
            idoValue = String(ido)
        }
        if var keido = (locationData?.coordinate.longitude){
            keido = round (keido*1000000)/1000000
            // keidoLabel.text = String(keido)
            keidoValue = String(keido)
        }
        if var hyoukou = locationData?.altitude{
            hyoukou = round (hyoukou*100)/100
            //  hyoukouLabel.text = String(hyoukou) + "m"
        }
        
        //webviewの設定
        let myURL = URL(string: "https://disaportal.gsi.go.jp/maps/?ll=" + String(idoValue) + "," +  String(keidoValue) + "&z=12&base=pale&vs=c1j0l0u0")
        
        let myRequest = URLRequest(url: myURL!)
        webview.load(myRequest)
    }
    @IBAction func back(_ sender: Any) {
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
    
    // requestLocation()を使用する場合、失敗した際のDelegateメソッドの実装が必須
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗しました")
    }
}

