//
//  mondaiViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/08/06.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit
import AVFoundation

class mondaiViewController: UIViewController {
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var numText: UILabel!
    @IBOutlet weak var mondaiText: UILabel!
    @IBOutlet weak var maruBtn: UIButton!
    @IBOutlet weak var batuBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var view1: UIView!
    
    var mondaiNum : Int = 0
    var seikaiCount : Int = 0
    
    var CorrectAnswer = String()
    var kaisetu = String()
    var seikai = String()
   
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var audioPlayerInstance2 : AVAudioPlayer! = nil
    
     var names: [Int] = []
    
     var page1Controller : kaisetuViewController?
     //var page1Controller : KaisetuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backbtn.layer.cornerRadius = 15.0
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        numText.frame = CGRect(x:40,y:screenHeight/8,width: screenWidth-80,height: 30)
        mondaiText.frame = CGRect(x:20,y:screenHeight*2/8-50,width: screenWidth-20,height: 250)
        maruBtn.frame = CGRect(x:40,y:screenHeight*2/8+200,width: screenWidth-80,height: 60)
        batuBtn.frame = CGRect(x:40,y:screenHeight*3/8+200,width: screenWidth-80,height: 60)
        
        
        
        numText.textAlignment=NSTextAlignment.center
      //  mondaiText.textAlignment=NSTextAlignment.center
        mondaiText.numberOfLines=0
        
        maruBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        batuBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        
        //ボタンの色
        maruBtn.backgroundColor = UIColor.rgba(red:255,green:119,blue:0,alpha:1)
        batuBtn.backgroundColor = UIColor.rgba(red:255,green:119,blue:0,alpha:1)
        
        //コーナーを丸く
        maruBtn.layer.cornerRadius = 10.0
        batuBtn.layer.cornerRadius = 10.0
       
        
        
        // UIImage インスタンスの生成
        let image:UIImage = UIImage(named:"q_image_why")!
        // UIImageView 初期化
        let imageView = UIImageView(image:image)
    
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = image.size.width
        let imgHeight:CGFloat = image.size.height
        
        let amari = screenHeight-(screenHeight*3/8+200+60)
        print(amari)
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = amari / (imgWidth)
        let rect:CGRect =
            CGRect(x:0, y:0, width:imgWidth*scale, height:amari)
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight*3/8+200+60+amari/2)
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        // Do any additional setup after loading the view.
      
        let userDefaluts = UserDefaults.standard
        if userDefaluts.object(forKey: "hairetu1") != nil{
            //objectsを配列として確定させ、前回の保存内容を格納
            names = userDefaluts.object(forKey: "hairetu1") as? NSArray as! [Int]
            
        }
        mondaiNum = userDefaluts.integer(forKey: "mondaiCount")
        seikaiCount = userDefaluts.integer(forKey: "seikaiCount")
       print(mondaiNum,"です")
        
        if mondaiNum<6 {
              print("koko実行1")
            RandomQuestions()
        }
        
        //サウンド関係
        let soundFilePath1 = Bundle.main.path(forResource: "qmaru", ofType: "mp3")!
        let sound1:URL = URL(fileURLWithPath: soundFilePath1)
        let soundFilePath2 = Bundle.main.path(forResource: "qbatu", ofType: "mp3")!
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
        /***********************************/
        
        page1Controller = createPage1ViewController()
    }
    
    func RandomQuestions(){
      
        let RandomNumber = names[mondaiNum-1]   //hairetu[mondaiNum]
        print(RandomNumber)
        numText.text = "Q" + (mondaiNum).description
        
        switch(RandomNumber){
            
        case 1:
            mondaiText.text = "地震が起きた際、よく学校で教えられた『机やテーブルの下に隠れる』というのは正しい。○か×か。";
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu = "避難訓練では定番となっている行動パターンですが、これは違います。「地震が来たら落下物や転倒の恐れのある家具などのない安全な場所に移動します。" +
            "食器などがあるダイニングからは速やかに離れましょう。ただし、逃げ遅れた場合や安全な場所が近くにないときは机やテーブルの下に身を隠すのは最後の手段として有効です。"
            break
        case 2:
            mondaiText.text = "『地震が起きた直後、すぐに火を消す』○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu = "１９２３年の関東大震災の教訓から生まれた標語ですが、無理して消そうとしてやけどする事故が多いそうです。現在、東京消防庁では「その時１０のポイント」として" +
        "「グラっと来たら身の安全」「落ち着いて火の元確認初期消火」を正しい知識として導いています。揺れがおさまってから、あわてずに火の始末をしようと改められています。"
            break
        case 3:
            mondaiText.text = "地震が起きた際、エレベーターにいた場合、『全部の階のボタンを押す』○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "○"
            kaisetu = "「早く地上に降りたほうがいいので、一階のボタンを押す」という考えがあると思いますが、それは間違いです。子供のころに、降りる階のボタン以外を押してはダメといわれてきたために、" +
            "ちゅうちょする人もいるとは思いますが、エレベーターに閉じ込められる可能性があるので、すぐ降りるために、とりあえず全部の階を押して一番近くの階で降りることが正解です。"
            break
        case 4:
            mondaiText.text = "『小さな揺れでは津波は来ない』○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
        kaisetu="１８９６年の明治三陸沖地震では震度４程度のゆれでしたが、そのあとに押し寄せた津波で約２万人を超える方がなくなったので、" +
            "特に沿岸付近に住んでいる方は小さな揺れでも警戒することが必要です。"
            break
        case 5:
            mondaiText.text = "『南海トラフなどの巨大地震に備えて、最低３日分の非常食を用意するのが良い』○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu =  "これまで自治体では、最低３日分の非常食の備蓄を推奨してきました。ですが、とても広い範囲に被害が予測される南海トラフ巨大地震などにそなえるとなると、" + "５日間分以上の確保が必要です。家族の人数や年齢に合わせて必要な量を準備しましょう。"
        
            break
        case 6:
            mondaiText.text = "『火災が起きた時、煙に関係なく低い姿勢で逃げる』○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "○"
            kaisetu = "昔とは違い、今では少し煙が見えているくらいなら、転ばないように気を付けつつダッシュで逃げるのが正解です。低い姿勢でもたもたしているうちに、黒い煙（毒ガス）に" + "まかれてしまうのを防ぐためです。ただし、煙がすでに充満してしまっていたら、低い姿勢で口を押えて外に逃げるのが正解です。"
            break
        case 7:
            mondaiText.text = "気象庁が2019年５月末から運用を始めた『警戒レベル』についてですが、最大レベル５は『何が何でも避難』○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu = "警戒レベル５は正しくは、「命を守る最善の行動」です。警戒レベル４は「全員避難」ですがレベル５がこういう理由は、避難以上に命が大切だということです。過去に、避難経路が危険だったにもかかわらず、" + "無理やり避難しようとして川に流されるケースもありました。状況にあった最善の行動をすることが大切です"
            break
        case 8:
            mondaiText.text = "東北大震災をもとに伝えられた『津波でんでんこ』は、『みんなで協力して一緒に逃げる』である。○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu = "「でんでんこ」とは、各自のことです。海岸で大きな揺れを感じたときは、津波が来るから肉親（血縁が非常に近い人。親子・兄弟など。）にもかまわず、" + "各自てんでんばらばらに一刻も早く高台に逃げて、自分の命を守るというのが正解です。"
            break
        case 9:
            mondaiText.text = "木造住宅は『火に弱い』○か×か"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu = "木材は一定の厚みや太さがあれば、表面が焦げるだけでそれ以上はなかなか燃えません。木材の表面が炭化（炭になる）ことによって、木材が燃えにくくなるという性質が、" + "家を家事による倒壊から一定程度、守ってくれます。"
            break
        case 10:
            mondaiText.text = "落雷時、最も安全な退避行動は『車の中に逃げる』○か×か。"
                maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "○"
            kaisetu = "周りに何もないときは車に、逃げるのが最善の策ですが、周囲に建物がある場合はそちらを優先してください。"
            break
        case 11:
            mondaiText.text = "運転中に地震があったとき、徐々に減速して停止後、様子を確認して車外に行く。○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "○"
            kaisetu = "災害中は何が起こるかもわからず、すぐにブレーキをかけて降りたほうがいい時もあれば、" + "建物などが今にも倒れそうなときなど、状況がちがうので周りを見て動くことが大切です。"
            break
        case 12:
            mondaiText.text = "脚や腕をけがした場合、始めに心臓に近い上腕や太ももをひもなどできつく縛る。○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu = "問題中の行動は緊縛止血方法といって、適切に実行しないと神経や血管などを痛めることが多いので、緊急の場合のみするものです。" + "問題中のようなけがをした場合は傷口に清潔な布などを当てて１０分ほど手や指で圧迫するのが適切です。"
            break
        case 13:
            mondaiText.text = "自家発電があれば、停電しない。○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu = "規模の大きなマンションでは消防用設備の非常用電源として自家発電設備が設置されていることがありますが、各住戸に電源が供給されることはありません。"
            break
        case 14:
            mondaiText.text = "津波の到達予想時刻は津波が到達すると予想される場所の到達予想平均時間である。○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu = "津波の到達予想時刻は最も早く津波が到達する時刻です。同じ予報区の中でも、場所によっては数十分、場合によっては一時間以上遅れて津波が襲ってくることがあります。"
            break
        case 15:
            mondaiText.text = "台風の被害が比較的大きい場所は台風の中心である。○か×か。"
            maruBtn.setTitle("○", for: UIControl.State.normal)
            batuBtn.setTitle("✗", for: UIControl.State.normal)
            seikai = "×"
            kaisetu = "台風に全般的に言えることで台風の右側が風が強くて危険半円とも呼ばれています。それに対して、左側は加航半円と呼ばれ風が弱く、雨の降る量も少ないです。"
            break
        default:
            break
        }
    }
    
    @IBAction func maruBtn(_ sender: Any) {
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        //prefというキーで保存
        userDefaluts.set(mondaiNum+1, forKey: "mondaiCount")
        userDefaluts.set(self.kaisetu, forKey: "kaisetu")
        userDefaluts.set(self.seikai, forKey: "seikai")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        /********************/
        if(seikai == "○"){
            //もぎ
            mondaiNum+=1
            
            seikaiCount += 1
            userDefaluts.set(self.seikaiCount, forKey: "seikaiCount")
            let title = "正解！"
            let message = "答え：" + seikai
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("正解")
                /*画面遷移*/
                self.displayContentController(content: self.page1Controller!, container: self.view1)
                /************ここまで******************/
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance1.currentTime = 0
            audioPlayerInstance1.play()
           
            
           // audioPlayerInstance1.currentTime = 0
           // audioPlayerInstance1.play()
          /*  if(mondaiNum<=5){
                RandomQuestions()
            }*/
        }
        else{
            //もぎ
            mondaiNum+=1
            let title = "不正解..."
            let message = "答え：" + seikai
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("✗")
                /*画面遷移*/
                self.displayContentController(content: self.page1Controller!, container: self.view1)
                /************ここまで******************/
                
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance2.currentTime = 0
            audioPlayerInstance2.play()
            
         /*   if(mondaiNum<=5){
                RandomQuestions()
            }*/
        }
    }
    
    @IBAction func batuBtn(_ sender: Any) {
        /********値の保存************/
        let userDefaluts = UserDefaults.standard
        //prefというキーで保存
        userDefaluts.set(mondaiNum+1, forKey: "mondaiCount")
        userDefaluts.set(self.kaisetu, forKey: "kaisetu")
        userDefaluts.set(self.seikai, forKey: "seikai")
        //userDefaultsへの値の保存を明示的に行う
        userDefaluts.synchronize()
        /********************/
        if(seikai == "×"){
            //もぎ
            mondaiNum+=1
            
            seikaiCount += 1
            userDefaluts.set(self.seikaiCount, forKey: "seikaiCount")
            let title = "正解！"
            let message = "答え：" + seikai
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("正解")
                /*画面遷移*/
                self.displayContentController(content: self.page1Controller!, container: self.view1)
                /************ここまで******************/
                
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance1.currentTime = 0
            audioPlayerInstance1.play()
            
            // audioPlayerInstance1.currentTime = 0
            // audioPlayerInstance1.play()
          /*  if(mondaiNum<5){
                RandomQuestions()
            }*/
        }
        else{
            //もぎ
            mondaiNum+=1
            let title = "不正解！"
            let message = "答え：" + seikai
            let okText = "ok"
            let alert = UIAlertController(title:title,message: message,preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:okText,style: UIAlertAction.Style.cancel,handler: {
                (ACTION:UIAlertAction!) -> Void in
                print("✗")
                /*画面遷移*/
                self.displayContentController(content: self.page1Controller!, container: self.view1)
                /************ここまで******************/
                
            })
            alert.addAction(okButton)
            present(alert, animated:true,completion: nil)
            audioPlayerInstance2.currentTime = 0
            audioPlayerInstance2.play()
           /* if(mondaiNum<5){
                RandomQuestions()
            }*/
        }
    }
    @IBAction func backBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil);
    }
    
    func createPage1ViewController() -> kaisetuViewController{
        let sb:UIStoryboard = UIStoryboard(name: "kaisetuViewController",bundle: nil)
        let sController:kaisetuViewController = sb.instantiateInitialViewController() as! kaisetuViewController
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

}

