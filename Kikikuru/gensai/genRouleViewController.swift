//
//  genRouleViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/08/10.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import AVFoundation

class genRouleViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    var page1Controller : gensaiViewController?
    
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var audioPlayerInstance2 : AVAudioPlayer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
       
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        titleLabel.text="ルール説明"
        let width1 = screenWidth*8/10
        titleLabel.frame = CGRect(x: 0, y: 0, width:width1, height: 100)
        titleLabel.center = CGPoint(x: screenWidth/2, y: 100)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        
        
        //buttonコーナーを丸く
        btn1.layer.cornerRadius = 10.0
        btn1.frame = CGRect(x: 0, y: 0, width: screenWidth * 8 / 10, height:  screenHeight * 1 / 15)
        btn1.center = CGPoint(x: screenWidth/2, y: screenHeight*3/10)
        btn1.backgroundColor = UIColor.rgba(red: 152, green: 251, blue: 152, alpha: 1)
        btn1.layer.borderWidth = 2.0
        btn1.layer.borderColor = UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1).cgColor
        btn1.setTitle("「減災王」とは？", for: .normal)
        //フォントサイズ 色
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn1.setTitleColor(UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1), for: .normal)
        //中央
        btn1.titleLabel?.textAlignment = NSTextAlignment.center
        
        //btn2コーナーを丸く
        btn2.layer.cornerRadius = 10.0
        btn2.frame = CGRect(x: 0, y: 0, width: screenWidth * 8 / 10, height:  screenHeight * 1 / 15)
        btn2.center = CGPoint(x: screenWidth/2, y: screenHeight*4/10)
        btn2.backgroundColor = UIColor.rgba(red: 152, green: 251, blue: 152, alpha: 1)
        btn2.layer.borderWidth = 2.0
        btn2.layer.borderColor = UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1).cgColor
        btn2.setTitle("出題形式", for: .normal)
        //フォントサイズ 色
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn2.setTitleColor(UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1), for: .normal)
        //中央
        btn2.titleLabel?.textAlignment = NSTextAlignment.center
        
        //btn3コーナーを丸く
        btn3.layer.cornerRadius = 10.0
        btn3.frame = CGRect(x: 0, y: 0, width: screenWidth * 8 / 10, height:  screenHeight * 1 / 15)
        btn3.center = CGPoint(x: screenWidth/2, y: screenHeight*5/10)
        btn3.backgroundColor = UIColor.rgba(red: 152, green: 251, blue: 152, alpha: 1)
        btn3.layer.borderWidth = 2.0
        btn3.layer.borderColor = UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1).cgColor
        btn3.setTitle("出題数", for: .normal)
        //フォントサイズ 色
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn3.setTitleColor(UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1), for: .normal)
        //中央
        btn3.titleLabel?.textAlignment = NSTextAlignment.center
        
        //btn4コーナーを丸く
        btn4.layer.cornerRadius = 10.0
        btn4.frame = CGRect(x: 0, y: 0, width: screenWidth * 8 / 10, height:  screenHeight * 1 / 15)
        btn4.center = CGPoint(x: screenWidth/2, y: screenHeight*6/10)
        btn4.backgroundColor = UIColor.rgba(red: 152, green: 251, blue: 152, alpha: 1)
        btn4.layer.borderWidth = 2.0
        btn4.layer.borderColor = UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1).cgColor
        btn4.setTitle("合格条件", for: .normal)
        //フォントサイズ 色
        btn4.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn4.setTitleColor(UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1), for: .normal)
        //中央
        btn4.titleLabel?.textAlignment = NSTextAlignment.center
        
        //btn5コーナーを丸く
        btn5.layer.cornerRadius = 10.0
        btn5.frame = CGRect(x: 0, y: 0, width: screenWidth * 8 / 10, height:  screenHeight * 1 / 15)
        btn5.center = CGPoint(x: screenWidth/2, y: screenHeight*7/10)
        btn5.backgroundColor = UIColor.rgba(red: 152, green: 251, blue: 152, alpha: 1)
        btn5.layer.borderWidth = 2.0
        btn5.layer.borderColor = UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1).cgColor
        btn5.setTitle("減災王の条件", for: .normal)
        //フォントサイズ 色
        btn5.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn5.setTitleColor(UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1), for: .normal)
        //中央
        btn5.titleLabel?.textAlignment = NSTextAlignment.center
        
        //btn６コーナーを丸く
        btn6.layer.cornerRadius = 10.0
        btn6.frame = CGRect(x: 0, y: 0, width: screenWidth * 8 / 10, height:  screenHeight * 1 / 15)
        btn6.center = CGPoint(x: screenWidth/2, y: screenHeight*8/10)
        btn6.backgroundColor = UIColor.rgba(red: 65, green: 105, blue: 225, alpha: 1)
        btn6.layer.borderWidth = 2.0
        btn6.layer.borderColor = UIColor.rgba(red: 25, green: 25, blue: 112, alpha: 1).cgColor
        btn6.setTitle("スタート画面に", for: .normal)
        //フォントサイズ 色
        btn6.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn6.setTitleColor(UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1), for: .normal)
        //中央
        btn6.titleLabel?.textAlignment = NSTextAlignment.center
        
        page1Controller = createPage1ViewController()
        
        //音
        let soundFilePath1 = Bundle.main.path(forResource: "gen_kaisetukun", ofType: "mp3")!
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
    
    @IBAction func btn1(_ sender: Any) {
        audioPlayerInstance1.currentTime = 0
        audioPlayerInstance1.play()
        let title = "「減災王」とは？"
        let message = "地震・津波・天候の災害…。\n\n" +
            "この国「日本」は\n災害大国で有名です。\n\n" +
        "「こんな時災害が起きたら\n                  一体どうすれば…」\n\n" +
        "そんな災害時への対処法を\n　　　　クイズにしてみました。\n\n" +
        "いろんな災害に対処できる達人\n　　　　「減災王」を目指して\n　　　　　　頑張りましょう！"//「減災王」とは？

        let okText = "OK"
        let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
            (ACTION:UIAlertAction!) -> Void in
            
          
        })
        alert.addAction(okButton)
        present(alert, animated:true,completion: nil)
    }
    
    @IBAction func btn2(_ sender: Any) {
        audioPlayerInstance1.currentTime = 0
        audioPlayerInstance1.play()
        let title = "出題形式"
        let message =  "「減災王」は防災三択クイズです。\n\n"
            + "適切な答えと思う選択肢を選んで\n"
            + "ボタンをタップしてください。\n\n"
            + "出題の種類は「災害・防災」で\n　　　　　　幅広く出題します。"//出題形式
        let okText = "OK"
        let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
            (ACTION:UIAlertAction!) -> Void in
            
            
        })
        alert.addAction(okButton)
        present(alert, animated:true,completion: nil)
    }
    
    @IBAction func btn3(_ sender: Any) {
        audioPlayerInstance1.currentTime = 0
        audioPlayerInstance1.play()
        let title = "出題数"
        let message =  "出題パターンは全部で20問\n\nそのうち出題する数は5問です。"
        let okText = "OK"
        let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
            (ACTION:UIAlertAction!) -> Void in
            
            
        })
        alert.addAction(okButton)
        present(alert, animated:true,completion: nil)
    }
    
    @IBAction func btn4(_ sender: Any) {
        audioPlayerInstance1.currentTime = 0
        audioPlayerInstance1.play()
        let title = "合格条件"
        let message = "5問中3問以上正解で\n「合格」です。\n\n正解数によっては\n下の一言も変わるようです。"
        
        let okText = "OK"
        let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
            (ACTION:UIAlertAction!) -> Void in
            
            
        })
        alert.addAction(okButton)
        present(alert, animated:true,completion: nil)
    }
    
    @IBAction func btn5(_ sender: Any) {
        audioPlayerInstance1.currentTime = 0
        audioPlayerInstance1.play()
        let title = "減災王の条件"
        let message =  "\n出題される5問を\n すべて正解すること。\n (特別な判定が起こる)"
        let okText = "OK"
        let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
            (ACTION:UIAlertAction!) -> Void in
            
            
        })
        alert.addAction(okButton)
        present(alert, animated:true,completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
         self.dismiss(animated: true, completion: nil);
    }
    @IBAction func btn6(_ sender: Any) {
        audioPlayerInstance2.currentTime = 0
        audioPlayerInstance2.play()
           displayContentController(content: page1Controller!, container: view)
        
    }
    func createPage1ViewController() -> gensaiViewController{
        let sb:UIStoryboard = UIStoryboard(name: "gensaiViewController",bundle: nil)
        let sController:gensaiViewController = sb.instantiateInitialViewController() as! gensaiViewController
        return sController
    }
    
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
}
