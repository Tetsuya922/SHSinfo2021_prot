//
//  CustomNavigationControllerViewController.swift
//  SHSinfo2018
//
//  Created by 吉川哲也 on 2018/06/01.
//  Copyright © 2018年 SHS情報技術. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    convenience init(rootVC:UIViewController , naviBarClass:AnyClass?, toolbarClass: AnyClass?){
        self.init(navigationBarClass: naviBarClass, toolbarClass: toolbarClass)
        self.viewControllers = [rootVC]
    }

}
