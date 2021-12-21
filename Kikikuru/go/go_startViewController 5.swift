//
//  go_startViewController.swift
//  hinanjyoGO
//
//  Created by 吉川哲也 on 2019/08/18.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class go_startViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var setumeiLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    var page1Controller : GoViewController?
    
    var pointY : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        initImageView()
        initbtn()
        page1Controller = createPage1ViewController()
        // Do any additional setup after loading the view.
    }
    private func initImageView(){
        // UIImage インスタンスの生成
        let image:UIImage = UIImage(named:"go_zisin.jpg")!
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
            CGRect(x:0, y:backBtn.frame.origin.y+30, width:imgWidth*scale, height:imgHeight*scale)
        //ボタンの位置を保存
        pointY=backBtn.frame.origin.y+30+imgHeight*scale*3/4
        
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        
        /*タイトル*/
        titleLabel.numberOfLines = 0
        titleLabel.frame = CGRect(x: 0, y:imgHeight*scale*1/4, width: screenWidth, height: imgHeight*scale/2)
        titleLabel.font = UIFont.systemFont(ofSize: 50)
        titleLabel.text = "避難所GO"
       
        self.view.addSubview(titleLabel)
        
        /*ルールの説明*/
        setumeiLabel.numberOfLines = 0
        setumeiLabel.frame = CGRect(x: 0, y:imageView.frame.origin.y+imgHeight*scale , width: screenWidth, height: 230)
        setumeiLabel.font = UIFont.systemFont(ofSize: 20)
        setumeiLabel.text = "ルールの説明\n\n避難所まで逃げよう！\nスマホが揺れだしたら地震の合図だよ！\n危なからキャラクターを押してしゃがませてね。\nでも５秒以上しゃがむと避難に遅れちゃうよ"
        
        self.view.addSubview(setumeiLabel)
       // print(imageView.frame.origin.y,imgHeight*scale,screenHeight-imgHeight*scale)
    }
    
    private func initbtn(){
        
        let image :UIImage = UIImage(named:"go_start.png")!
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = image.size.width
        let imgHeight:CGFloat = image.size.height
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = screenWidth / imgWidth
        let rect:CGRect =
            CGRect(x:0, y:0, width:imgWidth, height:imgHeight)
        // ImageView frame をCGRectで作った矩形に合わせる
        let state = UIControl.State.normal
        startBtn.setImage(image, for: state)
        startBtn.frame = rect
        // 画像の中心を画面の中心に設定
        startBtn.center = CGPoint(x:screenWidth/2, y:pointY)
       
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(startBtn)
        
    }
    @IBAction func backbtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil);
    }
    
   
    @IBAction func startBtn(_ sender: Any) {
        /*画面遷移*/
        self.displayContentController(content: self.page1Controller!, container: self.view)
        /************ここまで******************/
    }
    func createPage1ViewController() -> GoViewController{
        let sb:UIStoryboard = UIStoryboard(name: "GoMain",bundle: nil)
        let sController:GoViewController = sb.instantiateInitialViewController() as! GoViewController
        return sController
    }
    
    
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
}
