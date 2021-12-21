//
//  EarthquakeViewController2.swift
//  SHSinfo2019
//
//  Created by tetsuya yoshikawa on 2020/08/10.
//  Copyright © 2020 SHS情報技術. All rights reserved.
//

import UIKit
import WebKit

class EarthquakeViewController2: UIViewController {

   @IBOutlet weak var btnBack: UIButton!
   @IBOutlet weak var webView: WKWebView!
           
           override func viewDidLoad() {
               super.viewDidLoad()
               //buttonコーナーを丸く
               btnBack.layer.cornerRadius = 15.0
               
               //webviewの設定
               let myURL = URL(string:  "https://www.jma.go.jp/jp/quake/")
               let myRequest = URLRequest(url: myURL!)
               
               webView.load(myRequest)
              
           }
           
           @IBAction func leftSwipe(_ sender: Any) {
                  self.dismiss(animated: true, completion: nil);
              }
              
           @IBAction func back(_ sender: Any) {
                  self.dismiss(animated: true, completion: nil);
              }
         

       }
