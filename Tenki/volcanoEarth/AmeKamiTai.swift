//
//  AmeKamiTai..swift
//  SHSinfo2021
//
//  Created by 吉川哲也 on 2021/12/09.
//  Copyright © 2021 SHS情報技術. All rights reserved.
//

import UIKit
import WebKit

class AmeKamiTai: UIViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var webView: WKWebView!
    var zoom :String = "9"
    var lat :String = "31.72350"
    var lon :String = "131.080266"
    var homeUrl = ""
    var flag = 0
            
            override func viewDidLoad() {
                super.viewDidLoad()
                //buttonコーナーを丸く
                btnBack.layer.cornerRadius = 15.0
                
                let userDefaults = UserDefaults.standard
                if let  value = userDefaults.string(forKey: "latitude"){
                //取り出した値をprefNumに保存
                    lat = value
                }
                //longitudeというキーを指定して保存していた値を取り出す
                if let  value = userDefaults.string(forKey: "longitude"){
                //取り出した値をprefNumに保存
                    lon = value
                }
                print(lat,lon,flag)
                //buttonコーナーを丸く
            
                switch(flag){
                case 0:
                    homeUrl = "https://www.jma.go.jp/bosai/nowc/#zoom:"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:hrpns&slmcs"
                    break;
                case 1:
                    homeUrl = "https://www.jma.go.jp/bosai/nowc/#zoom:"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:slmcs&thns"
                    break;
                case 2:
                    homeUrl =  "https://www.jma.go.jp/bosai/map.html#5/"+lat+"/"+lon+"/&elem=typhoon_all&typhoon=all&contents=typhoon"
                    break;
                default:
                    homeUrl = "https://www.jma.go.jp/bosai/nowc/#zoom:"+zoom+"/lat:"+lat+"/lon:"+lon+"/colordepth:normal/elements:hrpns&slmcs"
                    break;
               
                }
                
               
                
              
                let url1 = URL(string:homeUrl)
                let req1 = URLRequest(url: url1!)
                webView.load(req1)
               
            }
            
            @IBAction func leftSwipe(_ sender: Any) {
                   self.dismiss(animated: true, completion: nil);
               }
               
            @IBAction func back(_ sender: Any) {
                   self.dismiss(animated: true, completion: nil);
               }
          

        }
