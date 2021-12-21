//
//  kekkaViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/08/09.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class kekkaViewController: UIViewController {
    @IBOutlet weak var kekkaLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        kekkaLabel.frame = CGRect(x:40,y:screenHeight/10,width: screenWidth-80,height: 60)
        kekkaLabel.text="結果"
        kekkaLabel.textColor = UIColor.rgba(red:170,green:102,blue:204,alpha:1)
       /******image*************************/
        // UIImage インスタンスの生成
        let image:UIImage = UIImage(named:"q_image_tia")!
        // UIImageView 初期化
        let imageView = UIImageView(image:image)
        
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = image.size.width
        let imgHeight:CGFloat = image.size.height
        
        let amari = screenWidth/2
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = amari / (imgWidth)
        let rect:CGRect =
            CGRect(x:10, y:screenHeight/10+60, width:imgWidth*scale, height:imgHeight*scale)
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        /*******************************/
        scoreLabel.frame = CGRect(x:0,y:0,width: 200,height: 250)
        scoreLabel.center = CGPoint(x:screenWidth*3/4,y:screenHeight*2/8-25)
        
        totalLabel.frame = CGRect(x:0,y:0,width: screenWidth-20,height: 60)
        totalLabel.center = CGPoint(x: screenWidth/2, y: screenHeight/10+100+imgHeight*scale)
        
        btn.frame = CGRect(x:0,y:0,width: 200,height: 60)
        btn.center = CGPoint(x: screenWidth/2, y: screenHeight-100)
        
        btn.backgroundColor = UIColor.rgba(red:255,green:119,blue:0,alpha:1)
        btn.setTitle("もどる", for: .normal)
        
        
        let userDefaluts = UserDefaults.standard
        let seikaiCount = userDefaluts.integer(forKey: "seikaiCount")
        scoreLabel.text = (seikaiCount).description + "/5"
        
        totalLabel.text = "トータルスコア　：" + (seikaiCount*100).description
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
       self.dismiss(animated: true, completion: nil);
    }
    
    

}
