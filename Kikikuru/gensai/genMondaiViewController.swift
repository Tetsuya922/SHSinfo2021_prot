//
//  genMondaiViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/08/10.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import AVFoundation

class genMondaiViewController: UIViewController {

    @IBOutlet weak var mondai: UILabel!
    @IBOutlet weak var mondaiBun: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet var view1: UIView!
    
    var mondaiNum : Int = 0
    var seikaiCount : Int = 0
    
    var CorrectAnswer = String()
    var kaisetu = String()
    var seikai = String()
    
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var audioPlayerInstance2 : AVAudioPlayer! = nil
    var audioPlayerInstance3 : AVAudioPlayer! = nil
    var audioPlayerInstance4 : AVAudioPlayer! = nil
    var audioPlayerInstance5 : AVAudioPlayer! = nil
    var audioPlayerInstance6 : AVAudioPlayer! = nil
    var audioPlayerInstance7 : AVAudioPlayer! = nil
   
    
    var mon: [Int] = []
    var page1Controller : genKekkaViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        print(screenHeight)
        var fontsize:CGFloat = 15
        if screenHeight > 600{
            fontsize = 25
        }
        else{
            fontsize = 20
        }
        /********問題番号********************/
        mondai.text="問題："
       
        mondai.frame = CGRect(x: 20, y: 50, width:screenWidth-20, height: 60)
        //中央
        mondai.textAlignment = NSTextAlignment.center
        //フォントサイズを画面のおおきさごとに設定
        mondai.font = UIFont.systemFont(ofSize: fontsize )
        
        /********問題文********************/
        mondaiBun.numberOfLines = 0
        mondaiBun.text=""
        
        let height2 = screenHeight*2/5
        mondaiBun.frame = CGRect(x: 20, y: 100, width:screenWidth-20, height: height2)
       //左寄せ
        mondaiBun.textAlignment = NSTextAlignment.left
        //フォントサイズを画面のおおきさごとに設定
        mondaiBun.font = UIFont.systemFont(ofSize: fontsize )
        
        /********ボタン１********************/
        //buttonコーナーを丸く
        btn1.layer.cornerRadius = 10.0
        btn1.frame = CGRect(x: 10, y: screenHeight * 10 / 20, width: screenWidth * 6 / 10, height:  screenHeight * 3 / 20)
        btn1.backgroundColor = UIColor.rgba(red: 255, green: 153, blue: 153, alpha: 1)
        //改行させる
        btn1.titleLabel?.numberOfLines = 0
        btn1.setTitle("避難行動の確認", for: .normal)
        //フォントサイズ 色
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn1.setTitleColor(UIColor.rgba(red: 25, green: 25, blue: 112, alpha: 1), for: .normal)
        //中央
        btn1.titleLabel?.textAlignment = NSTextAlignment.center
        //フォントサイズを画面のおおきさごとに設定
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: fontsize-5)
        /********ボタン2********************/
        //buttonコーナーを丸く
        btn2.layer.cornerRadius = 10.0
        btn2.frame = CGRect(x: 10, y: screenHeight * 13 / 20, width: screenWidth * 6 / 10, height:  screenHeight * 3 / 20)
        btn2.backgroundColor = UIColor.rgba(red: 159, green: 255, blue: 255, alpha: 1)
        //改行させる
        btn2.titleLabel?.numberOfLines = 0
        btn2.setTitle("避難行動の確認", for: .normal)
        //フォントサイズ 色
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn2.setTitleColor(UIColor.rgba(red: 25, green: 25, blue: 112, alpha: 1), for: .normal)
        //中央
        btn2.titleLabel?.textAlignment = NSTextAlignment.center
        //フォントサイズを画面のおおきさごとに設定
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: fontsize-5)
        /********ボタン3********************/
        //buttonコーナーを丸く
        btn3.layer.cornerRadius = 10.0
        btn3.frame = CGRect(x: 10, y: screenHeight * 16 / 20, width: screenWidth * 6 / 10, height:  screenHeight * 3 / 20)
        btn3.backgroundColor = UIColor.rgba(red: 255, green: 255, blue: 159, alpha: 1)
        //改行させる
        btn3.titleLabel?.numberOfLines = 0
        btn3.setTitle("避難行動の確認", for: .normal)
        //フォントサイズ 色
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn3.setTitleColor(UIColor.rgba(red: 25, green: 25, blue: 112, alpha: 1), for: .normal)
        //中央
        btn3.titleLabel?.textAlignment = NSTextAlignment.center
        //フォントサイズを画面のおおきさごとに設定
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: fontsize-5)
        
        let userDefaluts = UserDefaults.standard
        if userDefaluts.object(forKey: "gen_hairetu1") != nil{
            //objectsを配列として確定させ、前回の保存内容を格納
            mon = userDefaluts.object(forKey: "gen_hairetu1") as? NSArray as! [Int]
            
        }
        mondaiNum = userDefaluts.integer(forKey: "gen_mondaiCount")
        seikaiCount = userDefaluts.integer(forKey: "gen_seikaiCount")
        print(mondaiNum,"です")
        
        if mondaiNum<6 {
            print("koko実行1")
            RandomQuestions()
        }
        //イメージ
        initImageView()
        page1Controller = createPage1ViewController()
        
        //音
        let soundFilePath1 = Bundle.main.path(forResource: "gen_syutudai", ofType: "wav")!
        let sound1:URL = URL(fileURLWithPath: soundFilePath1)
        let soundFilePath2 = Bundle.main.path(forResource: "gen_pinpon", ofType: "mp3")!
        let sound2:URL = URL(fileURLWithPath: soundFilePath2)
        let soundFilePath3 = Bundle.main.path(forResource: "gen_bu", ofType: "mp3")!
        let sound3:URL = URL(fileURLWithPath: soundFilePath3)
        let soundFilePath4 = Bundle.main.path(forResource: "gen_zero", ofType: "mp3")!
        let sound4:URL = URL(fileURLWithPath: soundFilePath4)
        let soundFilePath5 = Bundle.main.path(forResource: "gen_hugoukaku", ofType: "mp3")!
        let sound5:URL = URL(fileURLWithPath: soundFilePath5)
        let soundFilePath6 = Bundle.main.path(forResource: "gen_goukaku", ofType: "mp3")!
        let sound6:URL = URL(fileURLWithPath: soundFilePath6)
        let soundFilePath7 = Bundle.main.path(forResource: "gen_perfect", ofType: "mp3")!
        let sound7:URL = URL(fileURLWithPath: soundFilePath7)
       
       
        //インスタンスを作成
        do{
            audioPlayerInstance1 = try AVAudioPlayer(contentsOf: sound1, fileTypeHint:nil)
            audioPlayerInstance2 = try AVAudioPlayer(contentsOf: sound2, fileTypeHint:nil)
            audioPlayerInstance3 = try AVAudioPlayer(contentsOf: sound3, fileTypeHint:nil)
            audioPlayerInstance4 = try AVAudioPlayer(contentsOf: sound4, fileTypeHint:nil)
            audioPlayerInstance5 = try AVAudioPlayer(contentsOf: sound5, fileTypeHint:nil)
            audioPlayerInstance6 = try AVAudioPlayer(contentsOf: sound6, fileTypeHint:nil)
            audioPlayerInstance7 = try AVAudioPlayer(contentsOf: sound7, fileTypeHint:nil)
            
        }catch{
            print("インスタンス生成失敗")
        }
        audioPlayerInstance1.prepareToPlay()
        audioPlayerInstance2.prepareToPlay()
        audioPlayerInstance3.prepareToPlay()
        audioPlayerInstance4.prepareToPlay()
        audioPlayerInstance5.prepareToPlay()
        audioPlayerInstance6.prepareToPlay()
        audioPlayerInstance7.prepareToPlay()
    }
    
    @IBAction func btn1(_ sender: Any) {
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        //prefというキーで保存
        userDefaluts.set(mondaiNum+1, forKey: "gen_mondaiCount")
        userDefaluts.set(self.kaisetu, forKey: "gen_kaisetu")
        userDefaluts.set(self.seikai, forKey: "gen_seikai")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        /********************/
        
        if(seikai == btn1.titleLabel?.text){
            //もぎ
            mondaiNum+=1
            seikaiCount += 1
            userDefaluts.set(self.seikaiCount, forKey: "gen_seikai")
            //userDefaultsへの値の保存を明示的に行う
            userDefaluts.synchronize()
            
            let title = "正解です！"
            let message = "答え　" + seikai + "\n\n解説\n" + kaisetu
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("正解")
                if(self.mondaiNum<=5){
                    self.RandomQuestions()
                    self.audioPlayerInstance1.currentTime = 0
                    self.audioPlayerInstance1.play()
                }
                else{
                    /*画面遷移*/
                    self.displayContentController(content: self.page1Controller!, container: self.view1)
                    /*音*/
                    switch self.seikaiCount{
                        case 0:
                            self.audioPlayerInstance4.currentTime = 0
                            self.audioPlayerInstance4.play()
                            break
                        case 1:
                            self.audioPlayerInstance5.currentTime = 0
                            self.audioPlayerInstance5.play()
                            break
                        case 2:
                            self.audioPlayerInstance5.currentTime = 0
                            self.audioPlayerInstance5.play()
                            break
                        case 3:
                            self.audioPlayerInstance6.currentTime = 0
                            self.audioPlayerInstance6.play()
                            break
                        case 4:
                            self.audioPlayerInstance6.currentTime = 0
                            self.audioPlayerInstance6.play()
                            break
                        case 5:
                            self.audioPlayerInstance7.currentTime = 0
                            self.audioPlayerInstance7.play()
                            break
                        default:
                            self.audioPlayerInstance4.currentTime = 0
                            self.audioPlayerInstance4.play()
                            break
                    }
                    /************ここまで******************/
                }
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance2.currentTime = 0
            audioPlayerInstance2.play()
        }
        else{
            //もぎ
            mondaiNum+=1
            let title = "間違っています！"
             let message = "答え　" + seikai + "\n\n解説\n" + kaisetu
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("✗")
                if(self.mondaiNum<=5){
                    self.RandomQuestions()
                    self.audioPlayerInstance1.currentTime = 0
                    self.audioPlayerInstance1.play()
                }
                else{
                    /*画面遷移*/
                    self.displayContentController(content: self.page1Controller!, container: self.view1)
                    /************ここまで******************/
                    /*音*/
                    switch self.seikaiCount{
                    case 0:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    case 1:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 2:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 3:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 4:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 5:
                        self.audioPlayerInstance7.currentTime = 0
                        self.audioPlayerInstance7.play()
                        break
                    default:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    }
                }
                
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance3.currentTime = 0
            audioPlayerInstance3.play()
        }
        
        
        
       
        
    }
    
    @IBAction func btn2(_ sender: Any) {
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        //prefというキーで保存
        userDefaluts.set(mondaiNum+1, forKey: "gen_mondaiCount")
        userDefaluts.set(self.kaisetu, forKey: "gen_kaisetu")
        userDefaluts.set(self.seikai, forKey: "gen_seikai")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        /********************/
        
        if(seikai == btn2.titleLabel?.text){
            //もぎ
            mondaiNum+=1
            seikaiCount += 1
            userDefaluts.set(self.seikaiCount, forKey: "gen_seikai")
            //userDefaultsへの値の保存を明示的に行う
            userDefaluts.synchronize()
            
            let title = "正解です！"
            let message = "答え　" + seikai + "\n\n解説\n" + kaisetu
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("正解")
                if(self.mondaiNum<=5){
                    self.RandomQuestions()
                    self.audioPlayerInstance1.currentTime = 0
                    self.audioPlayerInstance1.play()
                }
                else{
                    /*画面遷移*/
                    self.displayContentController(content: self.page1Controller!, container: self.view1)
                    /************ここまで******************/
                    /*音*/
                    switch self.seikaiCount{
                    case 0:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    case 1:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 2:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 3:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 4:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 5:
                        self.audioPlayerInstance7.currentTime = 0
                        self.audioPlayerInstance7.play()
                        break
                    default:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    }
                }
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance2.currentTime = 0
            audioPlayerInstance2.play()
        }
        else{
            //もぎ
            mondaiNum+=1
            let title = "間違っています！"
            let message = "答え　" + seikai + "\n\n解説\n" + kaisetu
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("✗")
                if(self.mondaiNum<=5){
                    self.RandomQuestions()
                    self.audioPlayerInstance1.currentTime = 0
                    self.audioPlayerInstance1.play()
                }
                else{
                    /*画面遷移*/
                    self.displayContentController(content: self.page1Controller!, container: self.view1)
                    /************ここまで******************/
                    /*音*/
                    switch self.seikaiCount{
                    case 0:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    case 1:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 2:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 3:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 4:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 5:
                        self.audioPlayerInstance7.currentTime = 0
                        self.audioPlayerInstance7.play()
                        break
                    default:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    }
                }
                
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance3.currentTime = 0
            audioPlayerInstance3.play()
        }
        
       
    }
    
    @IBAction func btn3(_ sender: Any) {
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        //prefというキーで保存
        userDefaluts.set(mondaiNum+1, forKey: "gen_mondaiCount")
        userDefaluts.set(self.kaisetu, forKey: "gen_kaisetu")
        userDefaluts.set(self.seikai, forKey: "gen_seikai")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        /********************/
        
        if(seikai == btn3.titleLabel?.text){
            //もぎ
            mondaiNum+=1
            seikaiCount += 1
            userDefaluts.set(self.seikaiCount, forKey: "gen_seikai")
            //userDefaultsへの値の保存を明示的に行う
            userDefaluts.synchronize()
            
            let title = "正解です！"
            let message = "答え　" + seikai + "\n\n解説\n" + kaisetu
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("正解")
                if(self.mondaiNum<=5){
                    self.RandomQuestions()
                    self.audioPlayerInstance1.currentTime = 0
                    self.audioPlayerInstance1.play()
                }
                else{
                    /*画面遷移*/
                    self.displayContentController(content: self.page1Controller!, container: self.view1)
                    /************ここまで******************/
                    /*音*/
                    switch self.seikaiCount{
                    case 0:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    case 1:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 2:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 3:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 4:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 5:
                        self.audioPlayerInstance7.currentTime = 0
                        self.audioPlayerInstance7.play()
                        break
                    default:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    }
                }
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance2.currentTime = 0
            audioPlayerInstance2.play()
        }
        else{
            //もぎ
            mondaiNum+=1
            let title = "間違っています！"
            let message = "答え　" + seikai + "\n\n解説\n" + kaisetu
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("✗")
                if(self.mondaiNum<=5){
                    self.RandomQuestions()
                    self.audioPlayerInstance1.currentTime = 0
                    self.audioPlayerInstance1.play()
                }
                else{
                    /*画面遷移*/
                    self.displayContentController(content: self.page1Controller!, container: self.view1)
                    /************ここまで******************/
                    /*音*/
                    switch self.seikaiCount{
                    case 0:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    case 1:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 2:
                        self.audioPlayerInstance5.currentTime = 0
                        self.audioPlayerInstance5.play()
                        break
                    case 3:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 4:
                        self.audioPlayerInstance6.currentTime = 0
                        self.audioPlayerInstance6.play()
                        break
                    case 5:
                        self.audioPlayerInstance7.currentTime = 0
                        self.audioPlayerInstance7.play()
                        break
                    default:
                        self.audioPlayerInstance4.currentTime = 0
                        self.audioPlayerInstance4.play()
                        break
                    }
                }
                
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance3.currentTime = 0
            audioPlayerInstance3.play()
        }
    }
    
    private func initImageView(){
        // UIImage インスタンスの生成
        let img1:UIImage = UIImage(named:"gen_sakujira3.png")!
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
            CGRect(x:screenWidth * 3/5, y:screenHeight/2, width:imgWidth*scale, height:imgHeight*scale)
        // ImageView frame をCGRectで作った矩形に合わせる
        image.frame = rect;
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(image)
        
        // UIImage インスタンスの生成
        let img2:UIImage = UIImage(named:"gen_sakujira4.png")!
        // UIImageView 初期化
        let image2 = UIImageView(image:img2)
       
        // 画像の縦横サイズを取得
        let imgWidth2:CGFloat = img2.size.width
        let imgHeight2:CGFloat = img2.size.height
        // 画像サイズをスクリーン幅に合わせる
        let scale2:CGFloat = ( screenWidth * 4 / 10 ) / imgWidth2
        let rect2:CGRect =
            CGRect(x:screenWidth * 3/5, y:screenHeight/2 + imgHeight*scale, width:imgWidth2*scale2, height:imgHeight2*scale2)
        // ImageView frame をCGRectで作った矩形に合わせる
        image2.frame = rect2;
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(image2)
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    func createPage1ViewController() -> genKekkaViewController{
        let sb:UIStoryboard = UIStoryboard(name: "genKekkaViewController",bundle: nil)
        let sController:genKekkaViewController = sb.instantiateInitialViewController() as! genKekkaViewController
        return sController
    }
    
    
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
    func RandomQuestions(){
        
        let RandomNumber = mon[mondaiNum-1]   //hairetu[mondaiNum]
        print(RandomNumber)
        mondai.text = "問：" + (mondaiNum).description
        
        switch(RandomNumber){
            
        case 1:
            mondaiBun.text = "2019年6月,1～5の警戒レベルで\n避難情報が発令され始めます。" +
            "\n警戒レベルが２のとき,私たちは何をするべきでしょう？"
            btn1.setTitle("避難行動の確認", for: UIControl.State.normal)
            btn2.setTitle("今すぐ安全な場所へ避難", for: UIControl.State.normal)
            btn3.setTitle("安全への心構えを高くする", for: UIControl.State.normal)
            seikai = "避難行動の確認"
            kaisetu = "心構えを高くするは「レベル１」\n避難行動の確認は「レベル２」\n安全な場所へ避難は「レベル４」\n\n" +
            "     警戒レベルは理解して\n     初めて役に立つ情報です。\n    しっかり覚えておきましょう！"
            break
        case 2:
            mondaiBun.text = "外にいる時に大地震が起きた場合\n一番正しい避難場所は？"
            btn1.setTitle("コンビニエンスストア", for: UIControl.State.normal)
            btn2.setTitle("ガソリンスタンド", for: UIControl.State.normal)
            btn3.setTitle("交番", for: UIControl.State.normal)
            seikai = "ガソリンスタンド"
            kaisetu = "ガソリンスタンドは\n    火にも地震にも強い施設です！\n" +
                "\n実際に阪神淡路大震災でも\n" +
                "地震によって引き起こされた火災が\n" +
            "ガソリンスタンドで焼け止まりに\n\n　…という実例もあります。"
            break
        case 3:
            mondaiBun.text = "寝ている時に大地震が起きた！\n最初に取るべき行動は？"
            btn1.setTitle("すぐに家の外へ脱出し\n道路の脇にしゃがんで避難", for: UIControl.State.normal)
            btn2.setTitle("起きて机の下に避難する", for: UIControl.State.normal)
            btn3.setTitle("(布団をかぶったまま)\n四つん這いで頭を守る", for: UIControl.State.normal)
            seikai = "(布団をかぶったまま）\n四つん這いで頭を守る"
            kaisetu = "寝ているときは\n         布団の中が一番安全です。"
            break
        case 4:
            mondaiBun.text = "災害(火災)時のビニール袋の正しい使い方は\n次のうちどれか？"
            btn1.setTitle("頭からかぶり\n火災のときの煙を\n吸わないようにする", for: UIControl.State.normal)
            btn2.setTitle("膨らませて\n防災頭巾の代わりに使う", for: UIControl.State.normal)
            btn3.setTitle("水を入れて\n火元に投げつけ、火を消す", for: UIControl.State.normal)
            seikai = "頭からかぶり\n火災のときの煙を\n吸わないようにする"
            kaisetu = "空気を入れてかぶると\n　　　　　２～３分呼吸できます。"
            break
        case 5:
            mondaiBun.text = "2019年6月,1～5の警戒レベルで\n避難情報が発令され始めます。" +
            "\n警戒レベルが１のとき\n私たちは何をするべきでしょう？"
            btn1.setTitle("今すぐ安全な場所へ避難", for: UIControl.State.normal)
            btn2.setTitle("安全への心構えを高くする", for: UIControl.State.normal)
            btn3.setTitle("避難行動の確認", for: UIControl.State.normal)
            seikai = "安全への心構えを高くする"
            kaisetu = "心構えを高くするは「レベル１」\n避難行動の確認は「レベル２」\n安全な場所へ避難は「レベル４」\n\n" +
            "警戒レベルは理解して\n     初めて役に立つ情報です。\n    しっかり覚えておきましょう！"
            break
        case 6:
            mondaiBun.text = "2019年6月,1～5の警戒レベルで避難情報が発令され始めます。" +
            "\n警戒レベルが４のとき\n私たちは何をするべきでしょう？"
            btn1.setTitle("安全への心構えを高くする", for: UIControl.State.normal)
            btn2.setTitle("避難行動の確認", for: UIControl.State.normal)
            btn3.setTitle("今すぐ安全な場所へ避難", for: UIControl.State.normal)
            seikai = "今すぐ安全な場所へ避難"
            kaisetu =  "警戒レベルは理解して\n     初めて役に立つ情報です。\n    しっかり覚えておきましょう！"
            break
        case 7:
            mondaiBun.text = "2019年6月,1～5の警戒レベルで避難情報が発令され始めます。" +
            "\n警戒レベルが３のとき\n私たちは何をするべきでしょう？"
            btn1.setTitle("避難に時間を要する人は\n避難を開始する", for: UIControl.State.normal)
            btn2.setTitle("防災マップ等を使い\n避難行動の確認", for: UIControl.State.normal)
            btn3.setTitle("命を守るための\n最善の行動を取る", for: UIControl.State.normal)
            seikai = "準備が整い次第\n避難を開始する"
            kaisetu = "防災マップ等を使い\n避難行動の確認は「レベル２」\n" +
            "避難に時間を要する人は\n避難を開始するは「レベル３」\n" +
                "命を守るための\n最善の行動を取るは「レベル５」\n\n" +
            "警戒レベルは理解して\n     初めて役に立つ情報です。\n    しっかり覚えておきましょう！"
            break
        case 8:
            mondaiBun.text = "2019年6月,1～5の警戒レベルで避難情報が発令され始めます。" +
            "\n警戒レベルが５のとき\n私たちは何をするべきでしょう？"
            btn1.setTitle( "準備が整い次第\n避難を開始する", for: UIControl.State.normal)
            btn2.setTitle("命を守るための\n最善の行動を取る", for: UIControl.State.normal)
            btn3.setTitle("今すぐ安全な場所へ避難", for: UIControl.State.normal)
            seikai = "命を守るための\n最善の行動を取る"
            kaisetu = "命を守るための\n最善の行動を取るは「レベル５」\n" +
                "安全な場所へ避難は「レベル４」\n" +
                "準備が整い次第避難を開始するは「レベル３」\n\n" +
            "警戒レベルは理解して\n     初めて役に立つ情報です。\n    しっかり覚えておきましょう！"
            break
        case 9:
            mondaiBun.text = "次の選択肢の中で\n「二次災害」に当てはまる\n災害はどれか？"
            btn1.setTitle("豪雨", for: UIControl.State.normal)
            btn2.setTitle("地震", for: UIControl.State.normal)
            btn3.setTitle("津波", for: UIControl.State.normal)
            seikai = "津波"
            kaisetu = "一次災害とは\n災害が起こったおよその原因のこと\n\n" +
                "二次災害とは\n原因に関係する災害が\nさらに起こること\n\n" +
                "この場合\n「地震」は一次災害\n" +
                "「津波」は「地震」によって\n      引き起こされた二次災害\n" +
            "「豪雨」は一次災害\n…となります。"
            break
        case 10:
            mondaiBun.text = "ニュースでよく見る気象警報。いろんな警報の中で、「波浪警報」は具体的に何についての警報か？"
            btn1.setTitle("高波", for: UIControl.State.normal)
            btn2.setTitle("高潮", for: UIControl.State.normal)
            btn3.setTitle("洪水", for: UIControl.State.normal)
            seikai = "高波"
            kaisetu = "波浪警報は\n「主に高波、沿岸施設の被害」\n　　  　での警報です。\n\n" +
            "ちなみに高潮は「高潮」\n洪水は「洪水」で\nそれぞれ発令されます。"
            break
        case 11:
            mondaiBun.text = "気象災害の防止・軽減に重要なのが気象庁の観測所。\n" +
                "複数の気象要素を観測するため" +
            "設けられたシステムは何と呼ぶ？"
            btn1.setTitle("ラジオゾンデ", for: UIControl.State.normal)
            btn2.setTitle("アメダス", for: UIControl.State.normal)
            btn3.setTitle("ウィンドプロファイラ", for: UIControl.State.normal)
            seikai = "アメダス"
            kaisetu = "アメダス(AMeDAS)とは\n" +
                "「地域気象観測システム」と呼び\n" +
                "複数の観測を\n自動的に行うシステムです。\n" +
                "アメダスは1974年に\n運用開始してから\n" +
                "現在、降水量を観測する観測所は\n" +
            "約1300か所あります。"
            break
        case 12:
            mondaiBun.text = "夏から秋ごろにかけて発生する「台風」" +
            "では台風になれる条件は何？"
            btn1.setTitle("１時間雨量が\n約１７㎜以上", for: UIControl.State.normal)
            btn2.setTitle("他の選択肢ふたつの条件を\n満たしていることが条件", for: UIControl.State.normal)
            btn3.setTitle("最大風速が\n約１７メートル毎秒以上", for: UIControl.State.normal)
            seikai = "最大風速が\n約１７メートル毎秒以上"
            kaisetu = "気象庁では「台風」は\n" +
                "「最大風速が\n約１７メートル毎秒以上」を\n" +
            "　　条件としています。"
            break
        case 13:
            mondaiBun.text = "地震発生後、柱に足が挟まれ長時間身動きできない人がいる。\nこの人を助ける適切な対処法は？"
            
            btn1.setTitle("足に挟まれた柱を\n取り除いて助け出す", for: UIControl.State.normal)
            btn2.setTitle("挟んでいる足を\nマッサージする", for: UIControl.State.normal)
            btn3.setTitle("そのままで\n救助隊の到着を待つ", for: UIControl.State.normal)
            seikai = "そのままで\n救助隊の到着を待つ"
            kaisetu = "長時間の下敷きになると\n" +
                "体内に毒素が発生します。\n" +
                "急に毒素を取り除くと\n血液に毒素がまわって\n" +
                "心臓停止を\n引き起こすことがあります。\n" +
            "これを「クラッシュシンドローム」といいます。"
            break
        case 14:
            mondaiBun.text = "地震の際の電話は" +
                "不調の場合が多いが" +
                "災害用のダイヤルが存在する。\n" +
            "そのダイヤルの番号は何？"
            btn1.setTitle("１７１", for: UIControl.State.normal)
            btn2.setTitle("１７７", for: UIControl.State.normal)
            btn3.setTitle("１１７", for: UIControl.State.normal)
            seikai = "１７１"
            kaisetu = "災害用伝言ダイヤルは、\n" +
                "被災地にいる人の電話番号をもとに\n" +
                "安否などを録音出来るサービス。\n\n" +
                "使い方は\n「１７１」に電話\n伝言の録音・再生\n被災地の人の電話番号を入力" +
            "\n\n…で伝言を録音・再生できます。"
            break
        case 15:
            mondaiBun.text = "地震後、自宅から避難する前の\nとるべき行動は次のうちどれか？"
            btn1.setTitle("部屋の照明類を\nすべて地面に置く", for: UIControl.State.normal)
            btn2.setTitle("ブレーカーを落とす", for: UIControl.State.normal)
            btn3.setTitle("ガスの元栓を閉める", for: UIControl.State.normal)
            seikai = "ブレーカーを落とす"
            kaisetu = "通電が再開されたとき\nショートした配線が\n火災を起こす原因になるので\n" +
            "しっかりブレーカーは\n落としてから避難しましょう。"
            break
        case 16:
            mondaiBun.text = "地震でがれきに足を挟まれた！\n人は自分の状態に気づいてない。\n" +
            "効率よく助けを呼ぶにはどうすれば良いか？"
            btn1.setTitle("大声で助けを求める",  for: UIControl.State.normal)
            btn2.setTitle("がれきをどかして\n見える状態にする", for: UIControl.State.normal)
            btn3.setTitle( "石などのがれきで\n音を鳴らす", for: UIControl.State.normal)
            seikai =  "石などのがれきで\n音を鳴らす"
            kaisetu = "大声を出すのは体力を消費し、\nかなり効率が悪い方法です。\n\n" +
                "がれきをどかすのは\n状況を悪化する恐れがあります。\n\n" +
            "がれきを使うのは\nおよそ音のいい金属を\n使ってやるのがよい方法です。"
            break
        case 17:
            mondaiBun.text = "地震が発生すると地震動が発生しますが、\n" +
            "地震動について述べた説明はどれ？"
            btn1.setTitle("長い地震動は\n高い建物を大きく揺らす", for: UIControl.State.normal)
            btn2.setTitle("短い地震動は\n高い建物を大きく揺らす", for: UIControl.State.normal)
            btn3.setTitle( "他の選択肢は\nどちらも間違いである", for: UIControl.State.normal)
            seikai = "長い地震動は\n高い建物を大きく揺らす"
            kaisetu = "短い周期の地震動は\n低い建物が共振し、\n" +
                "長い周期の地震動は\n高い建物が共振します。\n\n" +
            "この中でも長い周期の\n地震動のことを\n「長周期地震動」といいます。"
            break
        case 18:
            mondaiBun.text = "周期が長い地震動の正しい特徴はどれか？"
            btn1.setTitle("高い建物を揺らす\n範囲が短い", for: UIControl.State.normal)
            btn2.setTitle("硬い地層であるほど\n揺れが大きくなる", for: UIControl.State.normal)
            btn3.setTitle("長時間にわたって\n高い建物が大きく揺れる", for: UIControl.State.normal)
            seikai = "長時間にわたって\n高い建物が大きく揺れる"
            kaisetu = "長い周期の波は\n遠くまで伝わります。\n\n" +
                "波は柔らかい地層ほど\n揺れが大きくなります。\n\n" +
                "周期が長い地震動は\n波がゆるやかなので\n" +
            "長時間にわたって\n高い建物が大きく揺れます。"
            break
        case 19:
            mondaiBun.text = "日本には遠地津波観測計という\n" +
                "津波を遠地から早く検知する\n" +
                "機械が設置されています。\n" +
            "機械が置かれているのはどこ？"
            btn1.setTitle("南鳥島", for: UIControl.State.normal)
            btn2.setTitle("与那国島", for: UIControl.State.normal)
            btn3.setTitle("沖ノ鳥島", for: UIControl.State.normal)
            seikai = "南鳥島"
            kaisetu =  "南鳥島には\n遠地から来る津波を\nより早く捉えるため、\n遠地津波観測計を\n設置しています。\n\n" +
                "ちなみに\n南鳥島は日本の中で\n一番東にある小島です。\n" +
                "与那国島は「西」\n" +
            "沖ノ鳥島は「南」\n…となっています。"
            break
        case 20:
            mondaiBun.text = "日本で地震が発生しない場所はズバリあるのか？\nそれともない？"
            btn1.setTitle("ある", for: UIControl.State.normal)
            btn2.setTitle("ない", for: UIControl.State.normal)
            btn3.setTitle("解明されていない", for: UIControl.State.normal)
            seikai = "ない"
            kaisetu = "日本で地震が発生しない場所は\nズバリないです。\n" +
                "小さな規模の地震ならば\nどこでも発生します。\n" +
                "過去に大きい地震が起きた後\n地表の痕跡が残らないので\n" +
                "大きい地震が起きない場所はある\nと" +
            "いえる場所はありません。"
            break
        case 21:
            mondaiBun.text = "津波の特徴について述べた\n適切な回答を選べ。"
            btn1.setTitle("0.1メートルの津波で\nたとえ健康な人でも\n立つことができない", for: UIControl.State.normal)
            btn2.setTitle( "津波の起きる回数で\n複数回起きることはない", for: UIControl.State.normal)
            btn3.setTitle("津波が起きる海の\n水深が深いほど\nスピードが速くなる", for: UIControl.State.normal)
            seikai = "津波が起きる海の\n水深が深いほど\nスピードが速くなる"
            kaisetu = "津波は起きる海の水深によって\nスピードが上下します。\n" +
                "起きる海によっては\n時速115kmに達することも。\n\n" +
                "津波は複数回によって\n起きることもあるので\n注意が必要です。\n\n" +
            "津波は0.5mあるだけで\nたとえ健康な人でも\n立つことができません。"
            
        default:
            break

        }
        
    }
        
}
