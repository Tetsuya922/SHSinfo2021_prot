//
//  go_clearViewController.swift
//  hinanjyoGO
//
//  Created by 吉川哲也 on 2019/08/19.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class go_clearViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    
     var page1Controller : go_startViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backbtn.layer.cornerRadius = 15.0
        initbtn()
        page1Controller = createPage1ViewController()
        
        
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        titleLabel.text = "無事到着！"
        titleLabel.frame = CGRect(x:50,y:screenHeight/10,width: screenWidth*3/4,height: 100)
        titleLabel.textColor = UIColor.white
        
        // Do any additional setup after loading the view.
    }
    
    private func initbtn(){
        
        let image :UIImage = UIImage(named:"go_retry.png")!
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = image.size.width
        let imgHeight:CGFloat = image.size.height
        // 画像サイズをスクリーン幅に合わせる
        let rect:CGRect =
            CGRect(x:0, y:0, width:imgWidth, height:imgHeight)
        // ImageView frame をCGRectで作った矩形に合わせる
        let state = UIControl.State.normal
        retryBtn.setImage(image, for: state)
        retryBtn.frame = rect
        // 画像の中心を画面の中心に設定
        retryBtn.center = CGPoint(x:screenWidth/2, y:screenHeight*2/5)
        
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(retryBtn)
        
    }
    @IBAction func retryBtn(_ sender: Any) {
        /*画面遷移*/
        self.displayContentController(content: self.page1Controller!, container: self.view)
        /************ここまで******************/
    }
    func createPage1ViewController() ->go_startViewController{
        let sb:UIStoryboard = UIStoryboard(name: "go_startViewController",bundle: nil)
        let sController:go_startViewController = sb.instantiateInitialViewController() as! go_startViewController
        return sController
    }
    
    
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
    @IBAction func backBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil);
    }
    
    
}
