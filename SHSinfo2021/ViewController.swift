//
//  ViewController.swift
//  SHSinfo2021
//
//  Created by 吉川哲也 on 2021/12/11.
//
import UIKit

import HNToaster
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var ViewContainer: UIView!
    
    var sonaeController:SonaeViewController?
    var tenkiController:TenkiViewController?
    var saiController:SaigaiViewController?
    var useController:UseViewController?
    
  
    //天気ボタン
    let tenkiButton = UIButton(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
    //キキクルボタン
    let kikiButton = UIButton(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
    //備えボダン
    let sonaeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
    //使い方ボタン
    let useButton = UIButton(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*******************ナビゲーションバー************************************/
        let imageView = UIImageView(frame: CGRect(x: 0,y: 0, width:350, height: 40))
      //  let wid1=view.frame.size.width
       // if wid1<600{
            imageView.contentMode = .scaleAspectFill
       // }else{
         //  imageView.contentMode = .scaleToFill
       // }
      
        //.redraw
        imageView.image = UIImage(imageLiteralResourceName : "title.png")
        self.navigationItem.titleView = imageView
        /*****************toolbar設定*************************************/
        //高さ設定
        let footerBarHeight: CGFloat = 60
        // ツールバー本体のインスタンス化
        let toolbar = UIToolbar(frame: CGRect(
            x: 0,
            y: self.view.bounds.size.height - footerBarHeight,
            width: self.view.bounds.size.width,
            height: footerBarHeight)
        )
        // ツールバースタイルの設定
        toolbar.barStyle = .default
        // ボタンのサイズ
        // let buttonSize: CGFloat = 60
        // 天気ボタン
        tenkiButton.setImage(UIImage(named: "tenki90"), for: .normal)
        tenkiButton.imageView?.contentMode = .scaleAspectFit
        tenkiButton.addTarget(self, action: #selector(self.onClicktenki(_:)), for: .touchUpInside)
        let tenkiButtonItem = UIBarButtonItem(customView: tenkiButton)
        // キキクルボタン
        kikiButton.setImage(UIImage(named: "sai_on90"), for: .normal)
        kikiButton.imageView?.contentMode = .scaleAspectFit
        kikiButton.addTarget(self, action: #selector(self.onClickSai(_:)), for: .touchUpInside)
        let saiButtonItem = UIBarButtonItem(customView: kikiButton)
        // 備えボタン
        sonaeButton.setImage(UIImage(named: "sonae_on90"), for: .normal)
        sonaeButton.imageView?.contentMode = .scaleAspectFit
        sonaeButton.addTarget(self, action: #selector(self.onClickSonae(_:)), for: .touchUpInside)
        let sonaeButtonItem = UIBarButtonItem(customView: sonaeButton)
       
        // 使い方ボタン
        useButton.setImage(UIImage(named: "use_on90"), for: .normal)
        useButton.imageView?.contentMode = .scaleAspectFit
        useButton.addTarget(self, action: #selector(self.onClickUse(_:)),
                             for: .touchUpInside)
        let useButtonItem = UIBarButtonItem(customView: useButton)
        
        // 余白を設定するスペーサー
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        // ツールバーにアイテムを追加する.
        toolbar.items = [flexibleItem,tenkiButtonItem,saiButtonItem ,sonaeButtonItem,useButtonItem,flexibleItem ]
        
        //背景色の設定
        toolbar.barTintColor = UIColor.rgba(red: 101, green: 131, blue: 193, alpha: 1)
        // ツールバーを表示
        self.view.addSubview(toolbar)
        
        tenkiController = createTenkiViewController()
        saiController = createSaigaiViewController()
        sonaeController = createSonaeViewController()
        useController = createUseViewController()
        displayContentController(content: tenkiController!, container: ViewContainer)
     
       
        
    }
   
    // 天気ボタンをクリックした時の処理
    @objc func onClicktenki(_ sender: UIButton) {
       
        tenkiButton.setImage(UIImage(named: "tenki90"), for: .normal)
        tenkiButton.imageView?.contentMode = .scaleAspectFit
        kikiButton.setImage(UIImage(named: "sai_on90"), for: .normal)
        kikiButton.imageView?.contentMode = .scaleAspectFit
        sonaeButton.setImage(UIImage(named: "sonae_on90"), for: .normal)
        sonaeButton.imageView?.contentMode = .scaleAspectFit
        useButton.setImage(UIImage(named: "use_on90"), for: .normal)
        useButton.imageView?.contentMode = .scaleAspectFit
        
        hideContentController(content: saiController!)
        hideContentController(content: sonaeController!)
        hideContentController(content: useController!)
        displayContentController(content: tenkiController!, container: ViewContainer)
      
        

    }
    // キキクルボタンをクリックした時の処理
    @objc func onClickSai(_ sender: UIButton) {
        
        
        tenkiButton.setImage(UIImage(named: "tenki_on90"), for: .normal)
        tenkiButton.imageView?.contentMode = .scaleAspectFit
        kikiButton.setImage(UIImage(named: "sai90"), for: .normal)
        kikiButton.imageView?.contentMode = .scaleAspectFit
        sonaeButton.setImage(UIImage(named: "sonae_on90"), for: .normal)
        sonaeButton.imageView?.contentMode = .scaleAspectFit
        useButton.setImage(UIImage(named: "use_on90"), for: .normal)
        useButton.imageView?.contentMode = .scaleAspectFit
        
        hideContentController(content: tenkiController!)
        hideContentController(content: sonaeController!)
        hideContentController(content: useController!)
        displayContentController(content: saiController!, container: ViewContainer)
      
    }
    // 備えボタンをクリックした時の処理
    @objc func onClickSonae(_ sender: UIButton) {
        
        
        tenkiButton.setImage(UIImage(named: "tenki_on90"), for: .normal)
        tenkiButton.imageView?.contentMode = .scaleAspectFit
        kikiButton.setImage(UIImage(named: "sai_on90"), for: .normal)
        kikiButton.imageView?.contentMode = .scaleAspectFit
        sonaeButton.setImage(UIImage(named: "sonae90"), for: .normal)
        sonaeButton.imageView?.contentMode = .scaleAspectFit
        useButton.setImage(UIImage(named: "use_on90"), for: .normal)
        useButton.imageView?.contentMode = .scaleAspectFit
        
        hideContentController(content: tenkiController!)
        hideContentController(content: saiController!)
        hideContentController(content: useController!)
        displayContentController(content: sonaeController!, container: ViewContainer)
      
    }
    
    // 使い方ボタンをクリックした時の処理
    @objc func onClickUse(_ sender: UIButton) {
       
        tenkiButton.setImage(UIImage(named: "tenki_on90"), for: .normal)
        tenkiButton.imageView?.contentMode = .scaleAspectFit
        kikiButton.setImage(UIImage(named: "sai_on90"), for: .normal)
        kikiButton.imageView?.contentMode = .scaleAspectFit
        sonaeButton.setImage(UIImage(named: "sonae_on90"), for: .normal)
        sonaeButton.imageView?.contentMode = .scaleAspectFit
        useButton.setImage(UIImage(named: "use90"), for: .normal)
        useButton.imageView?.contentMode = .scaleAspectFit
        
        hideContentController(content: tenkiController!)
        hideContentController(content: saiController!)
        hideContentController(content: sonaeController!)
        displayContentController(content: useController!, container: ViewContainer)
 
    }
    
    /*************画面遷移　タブボタン　***********************/
    func createTenkiViewController() -> TenkiViewController{
        let sb:UIStoryboard = UIStoryboard(name: "TenkiViewController",bundle: nil)
        let sController:TenkiViewController = sb.instantiateInitialViewController() as! TenkiViewController
     
        return sController
    }
    func createSaigaiViewController() -> SaigaiViewController{
       let sb:UIStoryboard = UIStoryboard(name: "SaigaiViewController",bundle: nil)
        let sController:SaigaiViewController = sb.instantiateInitialViewController() as! SaigaiViewController
        return sController
    }
   func createSonaeViewController() -> SonaeViewController{
        let sb:UIStoryboard = UIStoryboard(name: "SonaeViewController",bundle: nil)
        let sController:SonaeViewController = sb.instantiateInitialViewController() as! SonaeViewController
        return sController
    }
   
    func createUseViewController() -> UseViewController{
        let sb:UIStoryboard = UIStoryboard(name: "UseViewController",bundle: nil)
        let sController:UseViewController = sb.instantiateInitialViewController() as! UseViewController
        return sController
    }
   
    /*viewの追加*/
    func displayContentController(content:UIViewController, container:UIView){
        addChild(content)
        content.view.frame = container.bounds
        container.addSubview(content.view)
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
/******　拡張設定　******************/
extension UIColor {
    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
        
    }
}

