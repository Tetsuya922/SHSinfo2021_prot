//
//  RouteViewController.swift
//  Resas1
//
//  Created by 吉川哲也 on 2018/12/03.
//  Copyright © 2018 SHS情報技術. All rights reserved.
//

import UIKit
import WebKit

class RouteViewController: UIViewController  ,WKNavigationDelegate, WKUIDelegate{

   
  
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backBtn: UIButton!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var urlString: String!
       
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        //子ビューの削除
      //  View1.removeFromSuperview()
        let userDefaults = UserDefaults.standard
        let lat = userDefaults.double(forKey: "lat")
        let lon = userDefaults.double(forKey: "lon")
        let latobj = userDefaults.double(forKey: "latObj")
        let lonobj = userDefaults.double(forKey: "lonObj")
        
        
        
        
        
        let saddr = NSString(format: "%f,%f", lat, lon)
        let daddr = NSString(format: "%f,%f", latobj,lonobj)
        
        
        
        let urlString1 = "https://maps.google.com/maps?&saddr=\(saddr)&daddr=\(daddr)&directionsmode=walking"
        //目的地をURLエンコーディング 日本語を含むので
       urlString = urlString1.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        print(urlString)
        let myURL = NSURL(string: urlString)
        let myRequest = NSURLRequest(url: myURL! as URL)
        webView.load(myRequest as URLRequest)
        
        self.view.addSubview(webView)
        
        // インスタンスをビューに追加する
        
        //let viewWidth = View1.frame.size.width-0
        //let viewHeight = View1.frame.size.height
        
        let myAppFrameSize: CGSize = UIScreen.main.bounds.size
        let myAppFrameSizeStr = myAppFrameSize.height
      
    }
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
