//
//  bousaiQViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/08/06.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class bousaiQViewController: UIViewController {
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    
     var mondai = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    var page1Controller : mondaiViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initImageView()
        //buttonコーナーを丸く
        backbtn.layer.cornerRadius = 15.0
        startBtn.setTitle("はじめる", for: .normal)
        startBtn.layer.cornerRadius=10.0
        startBtn.layer.borderColor=UIColor.red.cgColor
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        startBtn.frame = CGRect(x:20,y:screenHeight-100,width: 150,height: 60)
        self.view.addSubview(backbtn)
        self.view.addSubview(startBtn)
        
        hairetu_build()
        
        let userDefaluts = UserDefaults.standard
        //   というキーで保存
        userDefaluts.set(mondai, forKey: "hairetu1")
       
        userDefaluts.set(0,forKey: "seikaiCount")
        userDefaluts.set(1, forKey: "mondaiCount")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        
        page1Controller = createPage1ViewController()
       
        // Do any additional setup after loading the view.
    }
    
    private func initImageView(){
        // UIImage インスタンスの生成
        let image:UIImage = UIImage(named:"bousai_q.png")!
        // UIImageView 初期化
        let imageView = UIImageView(image:image)
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = image.size.width
        let imgHeight:CGFloat = image.size.height
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = screenWidth / imgWidth
        let rect:CGRect =
            CGRect(x:0, y:200, width:imgWidth*scale, height:(imgHeight-200)*scale)
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        
    }
    @IBAction func backbtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func startBtn(_ sender: Any) {
       displayContentController(content: page1Controller!, container: view)
        
    }
    
   func createPage1ViewController() -> mondaiViewController{
        let sb:UIStoryboard = UIStoryboard(name: "mondaiViewController",bundle: nil)
        let sController:mondaiViewController = sb.instantiateInitialViewController() as! mondaiViewController
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
    func hairetu_build(){
        
        for num in 0...14{
            let RandomNumber :Int = Int(arc4random() % 15)
            let buff = mondai[num]
            mondai[num] = mondai[RandomNumber]
            mondai[RandomNumber] = buff
            
        }
        
        for num in 0...14{
            print( mondai[num] )
        }
        
    }
}
