//
//  ViewController.swift
//  hinanjyoGO
//
//  Created by 吉川哲也 on 2019/08/05.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import AudioToolbox

class GoViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var hito_btn: UIButton!
    @IBOutlet weak var count_label: UILabel!
    @IBOutlet weak var jishinLabel: UILabel!
    
    var image_hito: UIImage!
    var mytimer : Timer!
    var count :Int = 60
    var timer1 : Timer!
    var flag_3byou : Bool!
    var count_3byou :Int!
    var flag_on : Bool!
    var timer_inter : Int!
    var on_time : Int!
    
    
    var page1Controller : go_over_ViewController?
    var page2Controller : go_clearViewController?
    
    var vibrationCount = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        //背景１
        initImageView2()
        //背景２　アニメーション
        initImageView()
        let screenWidth:CGFloat = view.frame.size.width
        
        let image1:UIImage = UIImage(named:"go_town.png")!
         let imgWidth:CGFloat = image1.size.width
        self.view1.center = self.view.center
        UIView.animate(withDuration: 30.0, delay: 0.0, options: .repeat, animations: {
            // アニメーション終了後の座標とサイズを指定
            //補正
            var hosei:CGFloat!
            if(screenWidth>370){
                hosei=screenWidth/2
            }else{
                hosei=screenWidth*4/5
            }
            self.view1.center.x -= (imgWidth*2-hosei)
        }, completion: nil)
        
        timer_inter=0
        /******************人************************/
        image_hito = UIImage(named:"go_dash.png")
        //ボタンを押したときに暗くしない
        hito_btn.adjustsImageWhenHighlighted = false
        initbtn()
      
        /*************カウントダウンタイマー***********************/
        createTimer()
        flag_3byou = false
        count_3byou = 0
        /*******************/
        //ボタンを押している？
        flag_on = false
        //ボタンを押しているトータル時間
        on_time = 0
        
        
        page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
        
    }
    
    private func initImageView(){
    // UIImage インスタンスの生成
    let image1:UIImage = UIImage(named:"go_town.png")!
    // UIImageView 初期化
    let imageView = UIImageView(image:image1)
    // スクリーンの縦横サイズを取得
    let screenWidth:CGFloat = view.frame.size.width
    let screenHeight:CGFloat = view.frame.size.height
    // 画像の縦横サイズを取得
    let imgWidth:CGFloat = image1.size.width
    let imgHeight:CGFloat = image1.size.height
    // 画像サイズをスクリーン幅に合わせる
    let scale:CGFloat = screenWidth/imgWidth * 10 / 6
    //アニメーションの初期値
    //補正
        print(screenWidth)
        var hosei:CGFloat!
        if(screenWidth>370){
            hosei=screenWidth/6
        }else{
             hosei=screenWidth/2
        }
    let rect:CGRect =
        CGRect(x:imgWidth-hosei, y:0, width:imgWidth, height:imgHeight*scale)
    // ImageView frame をCGRectで作った矩形に合わせる
    imageView.frame = rect;
       
    view1.frame = CGRect(x: 0, y: 0, width:imgWidth*scale, height: imgHeight*scale+screenHeight * 2 / 10)
    // UIImageViewのインスタンスをビューに追加
    self.view1.addSubview(imageView)
  
        
    imageView.contentMode = UIView.ContentMode.scaleAspectFill
        // backgroundColorを使って透過させる。
    view1.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0)
    view.addSubview(view1)
    
   
    }
    private func initImageView2(){
        // UIImage インスタンスの生成
        let image2:UIImage = UIImage(named:"go_haikei5.jpg")!
        // UIImageView 初期化
        let imageView2 = UIImageView(image:image2)
        // スクリーンの縦横サイズを取得
        let screenWidth2:CGFloat = view.frame.size.width
        let screenHeight2:CGFloat = view.frame.size.height
        // 画像の縦横サイズを取得
        let imgWidth2:CGFloat = image2.size.width
        let imgHeight2:CGFloat = image2.size.height
        // 画像サイズをスクリーン幅に合わせる
        let scale2:CGFloat = screenHeight2 / imgHeight2 * 6 / 10
        let rect2:CGRect =
            CGRect(x:0, y:0, width:imgWidth2*scale2, height:imgHeight2*scale2)
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView2.frame = rect2;
        // 画像の中心を画面の中心に設定
        imageView2.center = CGPoint(x:screenWidth2/2, y:screenHeight2/2)
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView2)
        print(imageView2.frame.origin.x,imageView2.frame.origin.y,"です")
        count_label.frame = CGRect(x: 50, y: Int(imageView2.frame.origin.y), width: 200, height: 60)
        count_label.font = UIFont.systemFont(ofSize: 25)
        count_label.text = "あと" + String(count) + "秒"
        
        self.view.addSubview(count_label)
        
        
        jishinLabel.frame = CGRect(x: 50, y: Int(imageView2.frame.origin.y), width: 200, height: 60)
        jishinLabel.center = CGPoint(x:screenWidth2/2, y:screenHeight2/6)
        jishinLabel.font = UIFont.systemFont(ofSize: 40)
        jishinLabel.textColor = UIColor.red
        jishinLabel.text = "走れ！"
        self.view.addSubview(jishinLabel)
    }
    
    private func initbtn(){
        
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = image_hito.size.width
        let imgHeight:CGFloat = image_hito.size.height
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = screenHeight / imgHeight * 3/10
        let rect:CGRect =
            CGRect(x:0, y:0, width:imgWidth*scale, height:imgHeight*scale)
        // ImageView frame をCGRectで作った矩形に合わせる
        let state = UIControl.State.normal
        hito_btn.setImage(image_hito, for: state)
        hito_btn.frame = rect
        // 画像の中心を画面の中心に設定
        hito_btn.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(hito_btn)
        
    }
    
    func createTimer(){
        //timerを生成する.
        mytimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.maintimeaction(timer:)), userInfo: nil, repeats: true)
    }
    // カウントを停止するメソッド
    func stopBtnTap() {
        mytimer.invalidate()
    }
    
    @objc func maintimeaction(timer: Timer){
        timer_inter += 1
        count_3byou += 1
        //１秒間隔でカウントアップ
        if timer_inter % 2 == 0{
            count -= 1
           
        }
        
        //１０秒間隔で地震
        if (count%10 == 0) && (count > 9) && (count != 60) {
            flag_3byou = true
            count_3byou=0;
            //vibrate()
            jishinLabel.text = "地震！"
            //createTimer2()
            //timer1.fire()
            //startVibrateInterval()
            oto()
        }
        //３秒間バイブレーション
        if (flag_3byou == true) && (count_3byou >= 6) {
            flag_3byou = false
            jishinLabel.text = "走れ！"
            //timer1.invalidate()
        
            print("終了")
        }
        //print(flag_3byou,count_3byou,flag_on)
        //判定 地震がキて1.5秒以内に押したか？
        if (flag_3byou == true) && (count_3byou>3) && (flag_on == false){
            print("ゲームオーバー")
            /*画面遷移*/
            self.displayContentController(content: self.page1Controller!, container: self.view)
            /************ここまで******************/
            //timer1.invalidate()
            mytimer.invalidate()
        }
        //押している間をカウント
        if flag_on == true {
            on_time += 1
        }
        if on_time > 40{
            print("ゲームオーバー")
            /*画面遷移*/
            self.displayContentController(content: self.page1Controller!, container: self.view)
            /************ここまで******************/
           // timer1.invalidate()
            mytimer.invalidate()
        }
        
        //クリア
        if count<0 {
            /*画面遷移*/
            self.displayContentController(content: self.page2Controller!, container: self.view)
            /************ここまで******************/
           // timer1.invalidate()
            mytimer.invalidate()
        }
        
        
         count_label.text = "あと" + String(count) + "秒"
        
    }
    //押した時
    @IBAction func hito_btn1(_ sender: UIButton) {
        let image = UIImage(named: "go_drop.png")
        let state = UIControl.State.normal
        hito_btn.setImage(image, for: state)
        flag_on = true
        
        //アニメーションストップ
        let layer = view1.layer
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    //離した時
    @IBAction func hito_btn2(_ sender: UIButton) {
        let image = UIImage(named: "go_dash.png")
        let state = UIControl.State.normal
        hito_btn.setImage(image, for: state)
        flag_on = false
        
        //アニメーション再開
        let layer = view1.layer
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        
    }
    
    func createTimer2(){
        //timerを生成する.
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startVibrateInterval(timer:)), userInfo: nil, repeats: true)
    }
    //バイブレーション
    @objc func vibrate(){
       
         AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
       
    }
    
    @objc func startVibrateInterval(timer: Timer) {
        
        // どのバイブレーションを鳴らすか
        let systemSoundID = SystemSoundID(kSystemSoundID_Vibrate)
        
        // 繰り返し用のコールバックをセット
      
            
            self.vibrationCount =  self.vibrationCount - 1
            
            if ( self.vibrationCount > 0 ) {
                // 繰り返し再生
                AudioServicesPlaySystemSound(systemSoundID)
                print("繰り返し")
            }
            else {
                 print("終了です")
                // コールバックを解除
                AudioServicesRemoveSystemSoundCompletion(systemSoundID)
            }
        // 初回のバイブレーションを鳴らす
        AudioServicesPlaySystemSound(systemSoundID)
        
       
        
    }
    
    //音
    @objc func oto(){
        //カスタムサウンドのサウンドIDを保存するための変数
        var soundID: SystemSoundID = 0
        let soundUrl = Bundle.main.url(forResource: "go_jishin2", withExtension: "mp3")
        //サウンドIDを取得
        AudioServicesCreateSystemSoundID(soundUrl! as CFURL, &soundID)
        //取得したサウンドIDを指定して再生
        AudioServicesPlaySystemSoundWithCompletion(soundID) {
            //サウンドが鳴り終わった後の処理を記述
        }
       
    }
    
    func createPage1ViewController() -> go_over_ViewController{
        let sb:UIStoryboard = UIStoryboard(name: "go_over_ViewController",bundle: nil)
        let sController:go_over_ViewController = sb.instantiateInitialViewController() as! go_over_ViewController
        return sController
    }
    
    func createPage2ViewController() -> go_clearViewController{
        let sb:UIStoryboard = UIStoryboard(name: "go_clearViewController",bundle: nil)
        let sController:go_clearViewController = sb.instantiateInitialViewController() as! go_clearViewController
        return sController
    }
    
    
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
    @IBAction func backbtn(_ sender: Any) {
        mytimer.invalidate()
        self.dismiss(animated: true, completion: nil);
       
    }
    
}

