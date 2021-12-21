//
//  weatherViewController.swift
//  SHSinfo2019
//
//  Created by tetsuya yoshikawa on 2020/08/10.
//  Copyright © 2020 SHS情報技術. All rights reserved.
//

import UIKit
import WebKit

class weatherViewController2: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        btnBack.layer.cornerRadius = 15.0
        
        var urlNo:String = "4520100"
        //UserDefaultsの参照
        let userDefaults = UserDefaults.standard
        //ディクショナリ形式で初期値を指定できる
        userDefaults.register(defaults: ["areaCode" : "4520100"])
        //rowというキーを指定して保存していた値を取り出す
        if let value = userDefaults.string(forKey: "areaCode"){
                         //取り出した値をprefNumに保存
        urlNo = value
              
        }
        //webviewの設定
        print(urlNo.count)
        if urlNo.count<7{
           let myURL = URL(string: "https://www.jma.go.jp/bosai/#pattern=forecast&area_type=class20s&area_code=0" + String(urlNo))
           let myRequest = URLRequest(url: myURL!)
          webView.load(myRequest)
        }else{
            let myURL = URL(string: "https://www.jma.go.jp/bosai/#pattern=forecast&area_type=class20s&area_code=" + String(urlNo))
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
