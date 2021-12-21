//
//  HazardViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/07/20.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class TenkiViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    var page1Controller : weatherViewController2?
    var page2Controller : EarthquakeViewController2?
    var page3Controller : VolcanoViewController2?
    var page4Controller : warnViewController2?
    var page5Controller : tourokuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
        page3Controller = createPage3ViewController()
        page4Controller = createPage4ViewController()
        page5Controller = createPage5ViewController()
        hideContentController(content: page1Controller! )
        hideContentController(content: page2Controller! )
        hideContentController(content: page3Controller! )
        hideContentController(content: page4Controller! )
        hideContentController(content: page5Controller! )
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let wid1=view1.frame.size.width
        let hei=view1.frame.size.height
        let wid=hei*8/10/3
       
        //余白を計算  画像の左上と　画像の幅
        let margin = wid1/2-wid/2
        //ボタンの大きさ
        let rr = Int(wid)
        
        let xx=Int(wid1)/2-rr
        let yy=Int(hei)*1/20;
        
        let picture1 = UIImage(named: "g2_jishin_d")
        let picture2 = UIImage(named: "g2_kazan_d")
        let picture3 = UIImage(named: "g2_keihou_d")
        let picture4 = UIImage(named: "g2_tenki_d")
        let picture5 = UIImage(named: "g2_titen_d")
        
        if UITraitCollection.isDarkMode == true{
            btn1.setImage(picture1, for: .normal)
            btn2.setImage(picture2, for: .normal)
            btn3.setImage(picture3, for: .normal)
            btn4.setImage(picture4, for: .normal)
            btn5.setImage(picture5, for: .normal)
          
        }
        //地震
        btn1.frame=CGRect(x:xx,y:yy,width:rr,height:rr)
        //火山
        btn2.frame=CGRect(x:xx+Int(rr),y:yy,width:rr,height:rr)
        //警報
        btn3.frame=CGRect(x:xx,y:yy+Int(rr+10),width:rr,height:rr)
        //天気
        btn4.frame=CGRect(x:xx+Int(rr),y:yy+Int(rr+10),width:rr,height:rr)
        //地点登録
        btn5.frame=CGRect(x:Int(margin),y:yy+Int(rr*2+20),width:rr,height:rr)

      
    }
   //地震
    @IBAction func btn1(_ sender: Any) {
        //displayContentController(content: page4Controller!, container: view1)
        let storyboard:UIStoryboard=UIStoryboard(name: "EarthquakeViewController2", bundle: Bundle.main);
        let v:EarthquakeViewController2=storyboard.instantiateInitialViewController() as! EarthquakeViewController2;
        v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
        self.present(v, animated: true, completion: nil);
    }
     //火山
    @IBAction func btn2(_ sender: Any) {
        //displayContentController(content: page5Controller!, container: view1)
        let storyboard:UIStoryboard=UIStoryboard(name: "VolcanoViewController2", bundle: Bundle.main);
        let v:VolcanoViewController2=storyboard.instantiateInitialViewController() as! VolcanoViewController2;
        v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
        self.present(v, animated: true, completion: nil);
    }
    //警報
    @IBAction func btn3(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "warnViewController2", bundle: Bundle.main);
        let v:warnViewController2=storyboard.instantiateInitialViewController() as! warnViewController2;
        v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
        self.present(v, animated: true, completion: nil);
    }
    
    //天気
    @IBAction func btn4(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "weatherViewController2", bundle: Bundle.main);
        let v:weatherViewController2=storyboard.instantiateInitialViewController() as! weatherViewController2;
        v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
        self.present(v, animated: true, completion: nil);
    }
    //地点登録
    @IBAction func btn5(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "tourokuViewController2", bundle: Bundle.main);
        let v:tourokuViewController = storyboard.instantiateInitialViewController() as! tourokuViewController;
        v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
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
