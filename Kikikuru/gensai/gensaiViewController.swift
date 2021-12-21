//
//  gensaiViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/08/10.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import AVFoundation

class gensaiViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var setumeiBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
    var page1Controller : genRouleViewController?
    var page2Controller : genMondaiViewController?
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var audioPlayerInstance2 : AVAudioPlayer! = nil
    
     var mondai = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        titleLabel.text="クイズ減災王"
        let width1 = screenWidth*8/10
        titleLabel.frame = CGRect(x: 0, y: 0, width:width1, height: 100)
        titleLabel.center = CGPoint(x: screenWidth/2, y: 100)
        
        //buttonコーナーを丸く
        setumeiBtn.layer.cornerRadius = 10.0
        setumeiBtn.frame = CGRect(x: 10, y: 200, width: screenWidth * 5 / 10, height:  screenWidth * 5 / 10)
        setumeiBtn.backgroundColor = UIColor.rgba(red: 65, green: 105, blue: 225, alpha: 1)
        setumeiBtn.layer.borderWidth = 5.0
        setumeiBtn.layer.borderColor = UIColor.rgba(red: 25, green: 25, blue: 112, alpha: 1).cgColor
        //改行させる
        setumeiBtn.titleLabel?.numberOfLines = 0
        setumeiBtn.setTitle("ルールの説明\n\nこちらを\nタッチ！", for: .normal)
        //フォントサイズ 色
        setumeiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        setumeiBtn.setTitleColor(UIColor.rgba(red: 25, green: 25, blue: 112, alpha: 1), for: .normal)
        //中央
        setumeiBtn.titleLabel?.textAlignment = NSTextAlignment.center
        
        //image追加
        initImageView()
        
        //スタートボタン
        //改行させる
        startBtn.titleLabel?.numberOfLines = 0
        startBtn.setTitle("タッチして\nクイズをはじめる", for: .normal)
        //フォントサイズ 色
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        startBtn.setTitleColor(UIColor.red, for: .normal)
        //配置
        startBtn.frame = CGRect(x: 0, y: 0, width:screenWidth*8/10, height: 100)
        startBtn.center = CGPoint(x: screenWidth/2, y: screenHeight-100)
        //中央
        startBtn.titleLabel?.textAlignment = NSTextAlignment.center
        
         page1Controller = createPage1ViewController()
         page2Controller = createPage2ViewController()
        
        hairetu_build()
        let userDefaluts = UserDefaults.standard
        //   というキーで保存
        userDefaluts.set(mondai, forKey: "gen_hairetu1")
        userDefaluts.set(0,forKey: "gen_seikaiCount")
        userDefaluts.set(1, forKey: "gen_mondaiCount")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        
        //音
        let soundFilePath1 = Bundle.main.path(forResource: "gen_start", ofType: "mp3")!
        let sound1:URL = URL(fileURLWithPath: soundFilePath1)
        let soundFilePath2 = Bundle.main.path(forResource: "gen_sentaku", ofType: "mp3")!
        let sound2:URL = URL(fileURLWithPath: soundFilePath2)
        //インスタンスを作成
        do{
            audioPlayerInstance1 = try AVAudioPlayer(contentsOf: sound1, fileTypeHint:nil)
            audioPlayerInstance2 = try AVAudioPlayer(contentsOf: sound2, fileTypeHint:nil)
            
        }catch{
            print("インスタンス生成失敗")
        }
        audioPlayerInstance1.prepareToPlay()
        audioPlayerInstance2.prepareToPlay()
        
    }
    private func initImageView(){
        // UIImage インスタンスの生成
        let img1:UIImage = UIImage(named:"gen_sakujira1.jpg")!
        // UIImageView 初期化
        let image = UIImageView(image:img1)
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = img1.size.width
        let imgHeight:CGFloat = img1.size.height
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = ( screenWidth * 4 / 10 ) / imgWidth
        let rect:CGRect =
            CGRect(x:0, y:0, width:imgWidth*scale, height:imgHeight*scale)
        // ImageView frame をCGRectで作った矩形に合わせる
        image.frame = rect;
        // 画像の中心を画面の中心に設定
        image.center = CGPoint(x:screenWidth * 3/4, y:screenHeight/2)
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(image)
        
    }

    @IBAction func rouleBtn(_ sender: Any) {
        displayContentController(content: page1Controller!, container: view)
        audioPlayerInstance2.currentTime = 0
        audioPlayerInstance2.play()
    }
    @IBAction func backBtn(_ sender: Any) {
          self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func startbtn(_ sender: Any) {
        displayContentController(content: page2Controller!, container: view)
        audioPlayerInstance1.currentTime = 0
        audioPlayerInstance1.play()
    }
    
    func createPage1ViewController() -> genRouleViewController{
        let sb:UIStoryboard = UIStoryboard(name: "genRouleViewController",bundle: nil)
        let sController:genRouleViewController = sb.instantiateInitialViewController() as! genRouleViewController
        return sController
    }
    func createPage2ViewController() -> genMondaiViewController{
        let sb:UIStoryboard = UIStoryboard(name: "genMondaiViewController",bundle: nil)
        let sController:genMondaiViewController = sb.instantiateInitialViewController() as! genMondaiViewController
        return sController
    }
    
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
    func hairetu_build(){
        
        for num in 0...20{
            let RandomNumber :Int = Int(arc4random() % 21)
            let buff = mondai[num]
            mondai[num] = mondai[RandomNumber]
            mondai[RandomNumber] = buff
            
        }
        
        for num in 0...14{
            print( mondai[num] )
        }
        
    }

}
