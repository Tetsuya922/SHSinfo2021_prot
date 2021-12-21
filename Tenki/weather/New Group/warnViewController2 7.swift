//
//  warnViewController2.swift
//  SHSinfo2019
//
//  Created by tetsuya yoshikawa on 2020/08/10.
//  Copyright © 2020 SHS情報技術. All rights reserved.
//

import UIKit
import WebKit

class warnViewController2: UIViewController {

     @IBOutlet weak var btnBack: UIButton!
     @IBOutlet weak var webView: WKWebView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //buttonコーナーを丸く
            btnBack.layer.cornerRadius = 15.0
            
            var urlNo:String = "351"
            //UserDefaultsの参照
            let userDefaults = UserDefaults.standard
            //ディクショナリ形式で初期値を指定できる
            userDefaults.register(defaults: ["areaCode" : "4520100"])
            //rowというキーを指定して保存していた値を取り出す
            if let value = userDefaults.string(forKey: "areaCode"){
            urlNo = value
                  
            }
            if urlNo.count<7{
                //webviewの設定
                let myURL = URL(string: "https://www.jma.go.jp/bosai/warning/#lang=ja&area_type=class20s&area_code=0" + String(urlNo) )
                let myRequest = URLRequest(url: myURL!)
                webView.load(myRequest)
            }else{
                //webviewの設定
                let myURL = URL(string: "https://www.jma.go.jp/bosai/warning/#lang=ja&area_type=class20s&area_code=" + String(urlNo) )
                let myRequest = URLRequest(url: myURL!)
                webView.load(myRequest)
            }
           
        }
        
        @IBAction func leftSwipe(_ sender: Any) {
               self.dismiss(animated: true, completion: nil);
           }
           
        @IBAction func back(_ sender: Any) {
               self.dismiss(animated: true, completion: nil);
           }
      

    }
