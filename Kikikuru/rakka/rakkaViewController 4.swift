//
//  ViewController.swift
//  rakka
//
//  Created by 吉川哲也 on 2019/08/21.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import AVFoundation

class rakkaViewController: UIViewController {
    
    var mytimer : Timer!
    
    var kan: UIImageView!
    var gunte: UIImageView!
    var kai: UIImageView!
    var game: UIImageView!
    var ball: UIImageView!
    var mizu: UIImageView!
   
    
    //サイズ
    var frameWidth : Int!
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    var time : Int!
    
    var flag :Bool = false
    // 画像インスタンス
    let target = UIImageView()
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    var startFlag :Bool = false
    var score:Int = 0
    var cdt:Int!
    var cdt_sub:Int!
    
    
    var page1Controller : rakka_endViewController?
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initImageView()
        initImage()
        
        //音
        let soundFilePath1 = Bundle.main.path(forResource: "rakka_bubu", ofType: "wav")!
        let sound1:URL = URL(fileURLWithPath: soundFilePath1)
        //インスタンスを作成
        do{
            audioPlayerInstance1 = try AVAudioPlayer(contentsOf: sound1, fileTypeHint:nil)
            
        }catch{
            print("インスタンス生成失敗")
        }
        audioPlayerInstance1.prepareToPlay()
        //カウントダウンタイマ
        cdt = 30
        cdt_sub = 0
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        self.view.addSubview(backBtn)
        
        
        startLabel.text = "タップしてね"
        startLabel.font = UIFont.systemFont(ofSize: 30)
        startLabel.frame = CGRect(x: 0, y: 0, width:Int(200), height: 60)
        startLabel.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
        //startLabel.backgroundColor = UIColor.white
        startLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(startLabel)
        
        /*******カバン操作*************/
       // createTimer()
        target.image = UIImage(named: "rakka_ruck.png")
        // 画像のフレームを設定
        target.frame = CGRect(x:0, y:0, width:100, height:100)
        // 画像をスクリーン中央に設定
        target.center = CGPoint(x:screenWidth/2, y:screenHeight-100)
        // タッチ操作を enable
        target.isUserInteractionEnabled = true
        self.view.addSubview(target)
        
        /*********スコア*******************/
        scoreLabel.text = "スコア：" + String(score)
        self.view.addSubview(scoreLabel)
        /********タイム**********/
        timeLabel.text = String(cdt)
        self.view.addSubview(timeLabel)
        
        page1Controller = createPage1ViewController()
    }
    //アイテム
    private func initImage(){
        
        // スクリーンの縦横サイズを取得
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height
        // UIImage インスタンスの生成
        let img1:UIImage = UIImage(named:"rakka_gunte.jpg")!
        // UIImageView 初期化
        gunte = UIImageView(image:img1)
        gunte.frame = CGRect(x: 60, y: -100, width: 60, height: 60)
        self.view.addSubview(gunte)
        
        let img2:UIImage = UIImage(named:"rakka_bousai_kaichudentou.png")!
        // UIImageView 初期化
        kai = UIImageView(image:img2)
        kai.frame = CGRect(x:100, y: -100, width: 60, height: 60)
        self.view.addSubview(kai)
        
        let img3:UIImage = UIImage(named:"rakka_portable_game.png")!
        // UIImageView 初期化
        game = UIImageView(image:img3)
        game.frame = CGRect(x: 150, y: -100, width: 60, height: 60)
        self.view.addSubview(game)
        
        let img4:UIImage = UIImage(named:"rakka_soccer_ball.png")!
        // UIImageView 初期化
        ball = UIImageView(image:img4)
        ball.frame = CGRect(x: 200, y: -100, width: 60, height: 60)
        self.view.addSubview(ball)
        
        let img5:UIImage = UIImage(named:"rakka_bousai_water.png")!
        // UIImageView 初期化
        mizu = UIImageView(image:img5)
        mizu.frame = CGRect(x: 250, y: -100, width: 30, height: 60)
        self.view.addSubview(mizu)
       
        let img6:UIImage = UIImage(named:"rakka_bousai_kanpan.png")!
        // UIImageView 初期化
        kan = UIImageView(image:img6)
        kan.frame = CGRect(x: 300, y: -100, width: 60, height: 60)
        self.view.addSubview(kan)
       
        
    }
//背景
    private func initImageView(){
        // UIImage インスタンスの生成
        let img1:UIImage = UIImage(named:"rakka_back.png")!
        // UIImageView 初期化
        let image = UIImageView(image:img1)
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = img1.size.width
        let imgHeight:CGFloat = img1.size.height
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = ( screenWidth ) / imgWidth
        let rect:CGRect =
            CGRect(x:0, y:0, width:screenWidth, height:screenHeight)
        image.contentMode = UIView.ContentMode.scaleToFill
        // ImageView frame をCGRectで作った矩形に合わせる
        image.frame = rect;
        // 画像の中心を画面の中心に設定
        image.center = CGPoint(x:screenWidth/2 , y:screenHeight/2)
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(image)
        
    }
    func createTimer(){
        //timerを生成する.
        mytimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.maintimeaction(timer:)), userInfo: nil, repeats: true)
    }
    
    @objc func maintimeaction(timer: Timer){
        scoreLabel.text = "スコア：" + String(score)
        
        /********カウントダウンタイマ*****************/
        cdt_sub += 1
        if cdt_sub >= 20 {
            cdt_sub = 0
            cdt -= 1
            timeLabel.text = String(cdt)
        }
        /*********タイムオーバー*********************/
        if cdt<0 {
            mytimer.invalidate()
            
            /********値の保存************/
            let userDefaluts = UserDefaults.standard
            //prefというキーで保存
            userDefaluts.set(score, forKey: "rakka_score")
            //userDefaultsへの値の保存を明示的に行う
            userDefaluts.synchronize()
            
            //バッグを消す
            target.isHidden = true
            
            /*******画面遷移*************/
            displayContentController(content: page1Controller!, container: view)
        }
        
        
            //軍手
       gunte.frame.origin.y += 10
        if hitCheak(rakkaX: gunte.frame.origin.x, rakkaY: gunte.frame.origin.y) == true {
            //画面から消す
            gunte.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            gunte.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100);
            score += 10
            
        }
       if self.gunte.center.y > (screenHeight) {
            gunte.frame.origin.y = -10
            print("ぐんて")
            //0から99までの値を取得する
               let random = arc4random() % 100
                gunte.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100);
       
            }
        
            //懐中電灯
       kai.frame.origin.y += 12;
        if hitCheak(rakkaX: kai.frame.origin.x, rakkaY: kai.frame.origin.y) {
            //画面から消す
            kai.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            kai.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100);
            score += 10
        }
        if self.kai.center.y >  (screenHeight+200)  {
            kai.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
           kai.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100);
            
        }
            //ゲーム
        game.frame.origin.y += 11;
        if hitCheak(rakkaX: game.frame.origin.x, rakkaY: game.frame.origin.y) {
            //画面から消す
            game.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            game.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100)
            score -= 20
            
            audioPlayerInstance1.currentTime = 0
            audioPlayerInstance1.play()
        }
        if self.game.center.y >  (screenHeight+200)  {
            game.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            game.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100)
            
        }
            //乾パン
        kan.frame.origin.y += 13;
        if hitCheak(rakkaX: kan.frame.origin.x, rakkaY: kan.frame.origin.y) {
            //画面から消す
            kan.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            kan.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100)
            score += 10
        }
        if self.kan.center.y >  (screenHeight+200)  {
            kan.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            kan.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100)
        }
        //水
        mizu.frame.origin.y += 12;
        if hitCheak(rakkaX: mizu.frame.origin.x, rakkaY: mizu.frame.origin.y) {
            //画面から消す
            mizu.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            mizu.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100)
            score += 10
        }
        if self.mizu.center.y >  (screenHeight+200)  {
            mizu.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            mizu.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100)
            
        }
        //ボール
        ball.frame.origin.y += 9;
        if hitCheak(rakkaX: ball.frame.origin.x, rakkaY: ball.frame.origin.y) {
            //画面から消す
            ball.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            ball.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100)
            score -= 20
            
            audioPlayerInstance1.currentTime = 0
            audioPlayerInstance1.play()
        }
        if self.ball.center.y >  (screenHeight+200)  {
            ball.frame.origin.y = -10
            //0から99までの値を取得する
            let random = arc4random() % 100
            ball.frame.origin.x = floor(CGFloat(random) * (screenWidth)/100)
            
        }
            
        }
   
    // 画面にタッチで呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //画面にタップでStart
        if startFlag == false {
            createTimer()
            startFlag = true
            startLabel.text = ""
            startLabel.backgroundColor = UIColor.clear
        }
       
        let touch: UITouch = touches.first as! UITouch
        let startPoint = touch.location(in: self.view)
        //タッチをやり始めた時のイメージの座標
        let imagePoint = self.target.frame.origin
        print( imagePoint)
        
        let MinX = imagePoint.x
        let MaxX = imagePoint.x + 100.0
        let MinY = imagePoint.y
        let MaxY = imagePoint.y + 100.0
        
        if (MinX <= startPoint.x) && (MaxX >= startPoint.x) && (MinY <= startPoint.y) && (MaxY >= startPoint.y){
            flag = true
        }
        else{
            flag = false
        }
           print("Began")
    }
    //　ドラッグ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if flag == true {
            // タッチイベントを取得
            let touchEvent = touches.first!
            // ドラッグ前の座標, Swift 1.2 から
            let preDx = touchEvent.previousLocation(in: self.view).x
           // let preDy = touchEvent.previousLocation(in: self.view).y
            // ドラッグ後の座標
            let newDx = touchEvent.location(in: self.view).x
            // ドラッグしたx座標の移動距離
            let dx = newDx - preDx
            // ドラッグしたy座標の移動距離
            print("Move")
            // 画像のフレーム
            var viewFrame: CGRect = target.frame
            // 移動分を反映させる
            viewFrame.origin.x += dx
            target.frame = viewFrame
            self.view.addSubview(target)
            
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得
        // let touchEvent = touches.first!
        let targetTop = target.frame.origin.y
        let targetRight = target.frame.origin.x + 50
        let targetLeft   = target.frame.origin.x
        print("End")
    }
    func hitCheak(rakkaX:CGFloat,rakkaY:CGFloat) -> Bool {
        let targetTop = target.frame.origin.y
        let targetRight = target.frame.origin.x + 100
        let targetLeft   = target.frame.origin.x

        
        if ((targetTop < (rakkaY+50) && (targetTop+50) > (rakkaY+50) && rakkaX < targetRight && (rakkaX ) >= targetLeft)) || ((targetTop < (rakkaY+50) && (targetTop+50) > (rakkaY+50) && (rakkaX+50) > targetLeft && (rakkaX + 50) < targetRight)) {
            //print("ひっと")
            return true
        }else{
            
            return false
        }
    }
    func createPage1ViewController() -> rakka_endViewController{
        let sb:UIStoryboard = UIStoryboard(name: "rakka_endViewController",bundle: nil)
        let sController:rakka_endViewController = sb.instantiateInitialViewController() as! rakka_endViewController
        return sController
    }
    
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
    @IBAction func modorubtn(_ sender: Any) {
        mytimer.invalidate()
        //バッグを消す
        target.isHidden = true
        
        self.dismiss(animated: true, completion: nil);
    }
}

