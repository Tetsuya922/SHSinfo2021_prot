//
//  GameViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/07/20.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import CoreLocation

class SaigaiViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    var page1Controller : KisyoutyouViewController?

    // 緯度
    var latitudeNow: String = ""
    // 経度
    var longitudeNow: String = ""
    /// ロケーションマネージャ
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        page1Controller = createPage1ViewController()
        hideContentController(content: page1Controller! )
        
        // ロケーションマネージャのセットアップ
        setupLocationManager()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let wid1=view1.frame.size.width
        let hei=view1.frame.size.height
       
       
        btn1.imageView?.contentMode = .scaleAspectFit
        btn1.contentHorizontalAlignment = .fill
        btn1.contentVerticalAlignment = .fill
        
       
        btn2.imageView?.contentMode = .scaleAspectFit
        btn2.contentHorizontalAlignment = .fill
        btn2.contentVerticalAlignment = .fill
        
        btn3.imageView?.contentMode = .scaleAspectFit
        btn3.contentHorizontalAlignment = .fill
        btn3.contentVerticalAlignment = .fill
        
        btn4.imageView?.contentMode = .scaleAspectFit
        btn4.contentHorizontalAlignment = .fill
        btn4.contentVerticalAlignment = .fill
        
        
        
        
        
        
        // マネージャの設定
               let status = CLLocationManager.authorizationStatus()
               if status == .denied {
                   showAlert()
               } else if status == .authorizedWhenInUse {
                   //self.latitude.text = latitudeNow
                  // self.longitude.text = longitudeNow
              
                
                
               }
       
    }
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
   
    
    
    
    //大雨
    @IBAction func btn1(_ sender: Any) {
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        userDefaluts.set("1",forKey: "kisyou")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        
        let storyboard:UIStoryboard=UIStoryboard(name: "KisyoutyouViewController", bundle: Bundle.main);
        let v:KisyoutyouViewController=storyboard.instantiateInitialViewController() as! KisyoutyouViewController;
       // v.modalTransitionStyle=UIModalTransitionStyle;
        v.modalPresentationStyle = .fullScreen // ★この行追加
        v.kikiFlag = 2
        self.present(v, animated: true, completion: nil);
    }
    //土砂
    @IBAction func btn2(_ sender: Any) {
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        userDefaluts.set("3",forKey: "kisyou")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        
        let storyboard:UIStoryboard=UIStoryboard(name: "KisyoutyouViewController", bundle: Bundle.main);
        let v:KisyoutyouViewController=storyboard.instantiateInitialViewController() as! KisyoutyouViewController;
        // v.modalTransitionStyle=UIModalTransitionStyle;
         v.modalPresentationStyle = .fullScreen // ★この行追加
        v.kikiFlag = 0
        self.present(v, animated: true, completion: nil);
    }
    //ナウキャスト
    @IBAction func btn3(_ sender: Any) {
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        userDefaluts.set("4",forKey: "kisyou")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        
        let storyboard:UIStoryboard=UIStoryboard(name: "amagumo", bundle: Bundle.main);
        let v:amagumo=storyboard.instantiateInitialViewController() as! amagumo;
        // v.modalTransitionStyle=UIModalTransitionStyle;
         v.modalPresentationStyle = .fullScreen // ★この行追加
    
        self.present(v, animated: true, completion: nil);
    }
    //洪水
    @IBAction func btn4(_ sender: Any) {
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        userDefaluts.set("2",forKey: "kisyou")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        
        let storyboard:UIStoryboard=UIStoryboard(name: "KisyoutyouViewController", bundle: Bundle.main);
        let v:KisyoutyouViewController=storyboard.instantiateInitialViewController() as! KisyoutyouViewController;
        // v.modalTransitionStyle=UIModalTransitionStyle;
         v.modalPresentationStyle = .fullScreen // ★この行追加
        v.kikiFlag = 1
        self.present(v, animated: true, completion: nil);
    }
    
    func createPage1ViewController() -> KisyoutyouViewController{
        let sb:UIStoryboard = UIStoryboard(name: "KisyoutyouViewController",bundle: nil)
        let sController:KisyoutyouViewController = sb.instantiateInitialViewController() as! KisyoutyouViewController
        return sController
    }
    /*削除*/
    func hideContentController(content:UIViewController){
        content.willMove(toParent: self)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SaigaiViewController: CLLocationManagerDelegate {

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
