//
//  EverydayViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/07/20.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import CoreLocation

class SonaeViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var btn1: UIButton!//ハザード
    @IBOutlet weak var btn2: UIButton!//hinan
    @IBOutlet weak var motiBtn: UIButton!
    
    @IBOutlet weak var space1: UILabel!
    @IBOutlet weak var space2: UILabel!
    
    @IBOutlet weak var mochiLabel: UILabel!
    
    
    var page1Controller : HinanViewController?
     var page2Controller : HzMapViewController?
 
     var  deviceName:String = ""
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "hinanView")
        
        page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
        hideContentController(content: page1Controller! )
        hideContentController(content: page2Controller! )
        
        let wid1=view1.frame.size.width
        let hei=view1.frame.size.height
    
        
 
        
        
        
        
        
        btn1.imageView?.contentMode = .scaleAspectFit
        btn1.contentHorizontalAlignment = .fill
        btn1.contentVerticalAlignment = .fill
        
        btn2.imageView?.contentMode = .scaleAspectFit
        btn2.contentHorizontalAlignment = .fill
        btn2.contentVerticalAlignment = .fill
        
        motiBtn.imageView?.contentMode = .scaleAspectFit
        motiBtn.contentHorizontalAlignment = .fill
        motiBtn.contentVerticalAlignment = .fill
        
        deviceName  =  UIDevice.current.model
       // print(deviceName)
        locationManager = CLLocationManager()
                  locationManager!.delegate = self

                  //位置情報を使用可能か
                  if CLLocationManager.locationServicesEnabled() {

                       //位置情報の取得開始
                       locationManager!.startUpdatingLocation()

                  }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let wid1=view1.frame.size.width
        let hei=view1.frame.size.height
        let wid=wid1/2

    
    
     
            
      
    }

    // ボタン1をクリックした時の処理
    @IBAction func btn1(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "hinanView")
        
        
       let storyboard:UIStoryboard=UIStoryboard(name: "HinanViewController", bundle: Bundle.main);
        let vc:HinanViewController=storyboard.instantiateInitialViewController() as! HinanViewController;
        vc.modalPresentationStyle = .fullScreen // ここを設定
        self.present(vc, animated: true, completion: nil)
        
    }
  
    @IBAction func btn2(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "HzMapViewController", bundle: Bundle.main);
           let vc:HzMapViewController=storyboard.instantiateInitialViewController() as! HzMapViewController;
           vc.modalPresentationStyle = .fullScreen // ここを設定
           self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func motiBtn(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "Mochi", bundle: Bundle.main);
           let vc:Mochi=storyboard.instantiateInitialViewController() as! Mochi;
           vc.modalPresentationStyle = .fullScreen // ここを設定
           self.present(vc, animated: true, completion: nil)
    }
    
    /***************画面遷移**************************/
    func createPage1ViewController() -> HinanViewController{
        let sb:UIStoryboard = UIStoryboard(name: "HinanViewController",bundle: nil)
        let sController:HinanViewController = sb.instantiateInitialViewController() as! HinanViewController
        return sController
    }
    func createPage2ViewController() -> HzMapViewController{
        let sb:UIStoryboard = UIStoryboard(name: "HzMapViewController",bundle: nil)
        let sController:HzMapViewController = sb.instantiateInitialViewController() as! HzMapViewController
        return sController
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//ダークモード 検出
extension UITraitCollection {

    public static var isDarkMode: Bool {
        if #available(iOS 13, *), current.userInterfaceStyle == .dark {
            return true
        }
        return false
    }

}
