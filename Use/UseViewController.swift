//
//  SonaeViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/07/20.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class UseViewController: UIViewController {

    @IBOutlet weak var view1: UIView!

    @IBOutlet weak var useButton: UIButton!
    @IBOutlet weak var mikataButton: UIButton!
    @IBOutlet weak var HZButton: UIButton!
    @IBOutlet weak var hinaBtn: UIButton!
    
    let linkText1 = "AR機能の使い方"
    let linkText2 = "ARで表示される表示板の見方"
    let linkText3 = "ハザードマップの使い方"
    
    var page1Controller : useView?
    var page2Controller : mikataViewController?
    var page3Controller : HzHelpViewController?
    var page4Controller : hinanHelpViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
        page3Controller = createPage3ViewController()
        page4Controller = createPage4ViewController()
        
        hideContentController(content: page1Controller! )
        
        useButton.titleLabel?.numberOfLines = 0
        mikataButton.titleLabel?.numberOfLines = 0
        HZButton.titleLabel?.numberOfLines = 0
            
            
            
            
            
        
       

       
    }

    @IBAction func usebtn(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "useView", bundle: Bundle.main);
         let v:useView=storyboard.instantiateInitialViewController() as! useView;
         v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
         self.present(v, animated: true, completion: nil);
    }
    
    
    @IBAction func mikatabtn(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "mikataViewController", bundle: Bundle.main);
         let v:mikataViewController=storyboard.instantiateInitialViewController() as! mikataViewController;
         v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
         self.present(v, animated: true, completion: nil);
    }
    
    
    @IBAction func HZbtn(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "HzHelpViewController", bundle: Bundle.main);
         let v:HzHelpViewController=storyboard.instantiateInitialViewController() as! HzHelpViewController;
         v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
         self.present(v, animated: true, completion: nil);
    }
    
    @IBAction func hinanBtn(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "hinanHelpViewController", bundle: Bundle.main);
         let v:hinanHelpViewController=storyboard.instantiateInitialViewController() as! hinanHelpViewController;
         v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
         self.present(v, animated: true, completion: nil);
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
      
    
        
    }
    

    func createPage1ViewController() -> useView{
        let sb:UIStoryboard = UIStoryboard(name: "useView",bundle: nil)
        let sController:useView = sb.instantiateInitialViewController() as! useView
        return sController
    }
    func createPage2ViewController() -> mikataViewController{
        let sb:UIStoryboard = UIStoryboard(name: "mikataViewController",bundle: nil)
        let sController:mikataViewController = sb.instantiateInitialViewController() as! mikataViewController
        return sController
    }
    func createPage3ViewController() -> HzHelpViewController{
        let sb:UIStoryboard = UIStoryboard(name: "HzHelpViewController",bundle: nil)
        let sController:HzHelpViewController = sb.instantiateInitialViewController() as! HzHelpViewController
        return sController
    }
    func createPage4ViewController() -> hinanHelpViewController{
        let sb:UIStoryboard = UIStoryboard(name: "hinanHelpViewController",bundle: nil)
        let sController:hinanHelpViewController = sb.instantiateInitialViewController() as! hinanHelpViewController
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
