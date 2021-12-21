//
//  HazardViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/07/20.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import CoreLocation

class TenkiViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var kamiBtn: UIButton!
    @IBOutlet weak var amaBtn: UIButton!
    @IBOutlet weak var taiBtn: UIButton!
    
    //ロケーションマネージャーを作る
    var locationManager = CLLocationManager()
    // 緯度
    var latitudeNow: String = ""
    // 経度
    var longitudeNow: String = ""
    
    var page1Controller : weatherViewController2?
    var page2Controller : EarthquakeViewController2?
    var page3Controller : VolcanoViewController2?
    var page4Controller : warnViewController2?
    var page5Controller : tourokuViewController?
    var page6Controller : AmeKamiTai?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //アプリ利用中の位置情報の利用許可を得る
        locationManager.requestWhenInUseAuthorization()//セキュリティの設定の確認
        //ロケーションマネージャーのdelegateになる
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
                    locationManager.requestLocation()
                    locationManager.startUpdatingLocation()
                }

        //ロケーション機能の設定
        setupLocationService()
        
       
        
        
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
        
        btn5.imageView?.contentMode = .scaleAspectFit
        btn5.contentHorizontalAlignment = .fill
        btn5.contentVerticalAlignment = .fill
        
        kamiBtn.imageView?.contentMode = .scaleAspectFit
        kamiBtn.contentHorizontalAlignment = .fill
        kamiBtn.contentVerticalAlignment = .fill
        
        amaBtn.imageView?.contentMode = .scaleAspectFit
        amaBtn.contentHorizontalAlignment = .fill
        amaBtn.contentVerticalAlignment = .fill
        
        taiBtn.imageView?.contentMode = .scaleAspectFit
        taiBtn.contentHorizontalAlignment = .fill
        taiBtn.contentVerticalAlignment = .fill
        
        page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
        page3Controller = createPage3ViewController()
        page4Controller = createPage4ViewController()
        page5Controller = createPage5ViewController()
        page6Controller = createPage6ViewController()
        hideContentController(content: page1Controller! )
        hideContentController(content: page2Controller! )
        hideContentController(content: page3Controller! )
        hideContentController(content: page4Controller! )
        hideContentController(content: page5Controller! )
        hideContentController(content: page6Controller! )
        
        // Do any additional setup after loading the view.
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
  
    override func viewDidAppear(_ animated: Bool) {
        let wid1=view1.frame.size.width
        let hei=view1.frame.size.height
      
    }
    //雨雲
    @IBAction func amaBtn(_ sender: Any) {
        //displayContentController(content: page4Controller!, container: view1)
        let storyboard:UIStoryboard=UIStoryboard(name: "AmeKamiTai", bundle: Bundle.main);
        let v:AmeKamiTai = storyboard.instantiateInitialViewController() as! AmeKamiTai;
        // v.modalTransitionStyle=UIModalTransitionStyle;
        v.flag = 0
         v.modalPresentationStyle = .fullScreen // ★この行追加
        self.present(v, animated: true, completion: nil);
    }
    //雷
    @IBAction func kamiBtn(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "AmeKamiTai", bundle: Bundle.main);
        let v:AmeKamiTai = storyboard.instantiateInitialViewController() as! AmeKamiTai;
        // v.modalTransitionStyle=UIModalTransitionStyle;
        v.flag = 1
         v.modalPresentationStyle = .fullScreen // ★この行追加
        self.present(v, animated: true, completion: nil);
    }
    //台風
    @IBAction func taiBtn(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "AmeKamiTai", bundle: Bundle.main);
        let v:AmeKamiTai = storyboard.instantiateInitialViewController() as! AmeKamiTai;
        // v.modalTransitionStyle=UIModalTransitionStyle;
        v.flag = 2
         v.modalPresentationStyle = .fullScreen // ★この行追加
        self.present(v, animated: true, completion: nil);
    }
    
    //地震
    @IBAction func btn1(_ sender: Any) {
        //displayContentController(content: page4Controller!, container: view1)
        let storyboard:UIStoryboard=UIStoryboard(name: "EarthquakeViewController2", bundle: Bundle.main);
        let v:EarthquakeViewController2=storyboard.instantiateInitialViewController() as! EarthquakeViewController2;
        // v.modalTransitionStyle=UIModalTransitionStyle;
         v.modalPresentationStyle = .fullScreen // ★この行追加
        
        self.present(v, animated: true, completion: nil);
    }
   
    
     //火山
    @IBAction func btn2(_ sender: Any) {
        //displayContentController(content: page5Controller!, container: view1)
        let storyboard:UIStoryboard=UIStoryboard(name: "VolcanoViewController2", bundle: Bundle.main);
        let v:VolcanoViewController2=storyboard.instantiateInitialViewController() as! VolcanoViewController2;
        // v.modalTransitionStyle=UIModalTransitionStyle;
         v.modalPresentationStyle = .fullScreen // ★この行追加
        self.present(v, animated: true, completion: nil);
    }
    //警報
    @IBAction func btn3(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "warnViewController2", bundle: Bundle.main);
        let v:warnViewController2=storyboard.instantiateInitialViewController() as! warnViewController2;
        // v.modalTransitionStyle=UIModalTransitionStyle;
         v.modalPresentationStyle = .fullScreen // ★この行追加
        self.present(v, animated: true, completion: nil);
    }
    
    //天気
    @IBAction func btn4(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "weatherViewController2", bundle: Bundle.main);
        let v:weatherViewController2=storyboard.instantiateInitialViewController() as! weatherViewController2;
        // v.modalTransitionStyle=UIModalTransitionStyle;
         v.modalPresentationStyle = .fullScreen // ★この行追加
        self.present(v, animated: true, completion: nil);
    }
    //地点登録
    @IBAction func btn5(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "tourokuViewController2", bundle: Bundle.main);
        let v:tourokuViewController = storyboard.instantiateInitialViewController() as! tourokuViewController;
        // v.modalTransitionStyle=UIModalTransitionStyle;
         v.modalPresentationStyle = .fullScreen // ★この行追加
        self.present(v, animated: true, completion: nil);
    }
    
    
    func createPage1ViewController() -> weatherViewController2{
        let sb:UIStoryboard = UIStoryboard(name: "weatherViewController2",bundle: nil)
        let sController:weatherViewController2 = sb.instantiateInitialViewController() as! weatherViewController2
        return sController
    }
    func createPage2ViewController() -> EarthquakeViewController2{
        let sb:UIStoryboard = UIStoryboard(name: "EarthquakeViewController2",bundle: nil)
        let sController:EarthquakeViewController2 = sb.instantiateInitialViewController() as! EarthquakeViewController2
        return sController
    }
    func createPage3ViewController() -> VolcanoViewController2{
        let sb:UIStoryboard = UIStoryboard(name: "VolcanoViewController2",bundle: nil)
        let sController:VolcanoViewController2 = sb.instantiateInitialViewController() as! VolcanoViewController2
        return sController
    }
    func createPage4ViewController() -> warnViewController2{
        let sb:UIStoryboard = UIStoryboard(name: "warnViewController2",bundle: nil)
        let sController:warnViewController2 = sb.instantiateInitialViewController() as! warnViewController2
        return sController
    }
    func createPage5ViewController() -> tourokuViewController{
        let sb:UIStoryboard = UIStoryboard(name: "tourokuViewController2",bundle: nil)
        let sController:tourokuViewController = sb.instantiateInitialViewController() as! tourokuViewController
        return sController
    }
    func createPage6ViewController() -> AmeKamiTai{
        let sb:UIStoryboard = UIStoryboard(name: "AmeKamiTai",bundle: nil)
        let sController:AmeKamiTai = sb.instantiateInitialViewController() as! AmeKamiTai
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
extension TenkiViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if locations.first != nil {
            print("location:: (location)")
        }
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
        

    }

}
