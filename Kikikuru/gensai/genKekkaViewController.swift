//
//  genKekkaViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/08/11.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class genKekkaViewController: UIViewController {
    @IBOutlet weak var happyou: UILabel!
    @IBOutlet weak var kekka: UILabel!
    @IBOutlet weak var hanteiLabel: UILabel!
    @IBOutlet weak var titleBack: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
     var page1Controller : gensaiViewController?
    
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
        /********結果発表********************/
        happyou.text="結果発表"
        
        happyou.frame = CGRect(x: 20, y: 100, width:screenWidth-20, height: 60)
        //中央
        happyou.textAlignment = NSTextAlignment.left
        //フォントサイズを画面のおおきさごとに設定
        happyou.font = UIFont.systemFont(ofSize:40 )
        
        
        
        /********結果********************/
        let userDefaluts = UserDefaults.standard
        let seikaiCount = userDefaluts.integer(forKey: "gen_seikai")
     
        kekka.text = seikaiCount.description + " / 5"
        
        let height2 = 50
        kekka.frame = CGRect(x: 0, y: 0, width:Int(screenWidth-20), height: height2)
        kekka.center = CGPoint(x: screenWidth/2, y: screenHeight*3/10)
        //中央寄せ
        kekka.textAlignment = NSTextAlignment.center
        //フォントサイズを画面のおおきさごとに設定
        kekka.font = UIFont.systemFont(ofSize: 30)
        /********判定********************/
        //改行の設定
        hanteiLabel.numberOfLines = 0
        switch seikaiCount {
            case 0 :
                hanteiLabel.text="判定・不合格\n少しずつ覚えていこう"
                break
            case 1 :
                hanteiLabel.text="判定・不合格\nもう一度！"
                break
            case 2 :
                hanteiLabel.text="判定・不合格\nもう一度！"
                break
            case 3:
                hanteiLabel.text="判定・合格\n合格おめでとう！"
                break
            case 4:
                hanteiLabel.text="判定・合格\n中々の知識量だ！"
                break
            case 5:
                hanteiLabel.text="判定・減災王\n君こそ減災王だ！"
                break
            default:
                hanteiLabel.text="判定・エラー\nもう一度挑戦しよう"
                break
        }
       
        
        
        hanteiLabel.frame = CGRect(x: 0, y: 0, width:Int(screenWidth-20), height: 200)
        hanteiLabel.center = CGPoint(x: screenWidth/2, y: screenHeight*5/10)
        //中央寄せ
        hanteiLabel.textAlignment = NSTextAlignment.center
        //フォントサイズを画面のおおきさごとに設定
        hanteiLabel.font = UIFont.systemFont(ofSize: 30)
        
        /********ボタン１********************/
        //buttonコーナーを丸く
        titleBack.layer.cornerRadius = 10.0
        titleBack.frame = CGRect(x: 0, y: 0, width: screenWidth * 8 / 10, height:  screenHeight * 1 / 10)
        titleBack.center = CGPoint(x: screenWidth/2, y: screenHeight*8/10)
        titleBack.backgroundColor = UIColor.rgba(red: 65, green: 105, blue: 225, alpha: 1)
        titleBack.layer.borderWidth = 2.0
        titleBack.layer.borderColor = UIColor.rgba(red: 25, green: 25, blue: 112, alpha: 1).cgColor
        titleBack.setTitle("タイトルに戻る", for: .normal)
        //フォントサイズ 色
        titleBack.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        titleBack.setTitleColor(UIColor.rgba(red: 15, green: 15, blue: 15, alpha: 1), for: .normal)
        //中央
        titleBack.titleLabel?.textAlignment = NSTextAlignment.center
        //フォントサイズを画面のおおきさごとに設定
        titleBack.titleLabel?.font = UIFont.systemFont(ofSize: fontsize)
        initImageView()
        page1Controller = createPage1ViewController()
    }
    private func initImageView(){
        // UIImage インスタンスの生成
        let img1:UIImage = UIImage(named:"gen_sakujira2.jpg")!
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
            CGRect(x:screenWidth * 3/5, y:30, width:imgWidth*scale, height:imgHeight*scale)
        // ImageView frame をCGRectで作った矩形に合わせる
        image.frame = rect;
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(image)
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func menuback(_ sender: Any) {
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
