//
//  rakka_startViewController.swift
//  rakka
//
//  Created by 吉川哲也 on 2019/08/26.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class rakka_startViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var setumei1: UILabel!
    @IBOutlet weak var setumei2: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
     var page1Controller : rakkaViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        view1.backgroundColor = UIColor.rgba(red: 0, green: 123, blue: 255, alpha: 1)
        let screenWidth = view.frame.width
        let screenHeight = view2.frame.height
        let screenY = view2.frame.origin.y
        print(screenWidth)
        var fontSize:CGFloat = 15
        var bunbo:CGFloat = 4
        if screenWidth > 400{
            fontSize = 23
            bunbo = 2
        }else if screenWidth > 370{
             fontSize = 20
            bunbo = 3
        }
        
        titleLabel.text = "　防災キャッチ！"
        titleLabel.textColor = UIColor.rgba(red: 255, green: 140, blue: 0, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        
        setumei1.textAlignment = NSTextAlignment.center
        setumei1.text = "＜ルールせつめい＞\nひなんに必要なものを\nリュックにつめこもう！！！\n＜そうさせつめい＞\n ゆびでタッチして\nリュックを動かそう！\n\n・・・１０点もらえるよ・・・\n手ぶくろ・ライト・お水・かんパン"
        setumei1.frame = CGRect (x: 30, y: screenY-10, width: screenWidth-60, height:screenHeight / bunbo)
        setumei1.font = UIFont.systemFont(ofSize: fontSize)
        
        

        view2.addSubview(titleLabel)
        view2.addSubview(setumei1)
        view2.addSubview(setumei2)
        initImageView()
        
        setumei2.textAlignment = NSTextAlignment.center
        setumei2.text = "・・・２０点ひかれるよ・・・ \nボール・ゲーム"
        setumei2.font = UIFont.systemFont(ofSize: fontSize)
        setumei2.frame = CGRect (x: 30, y: img1.frame.origin.y+80, width: screenWidth-60, height:60)
        initImageView2()
        
        startBtn.backgroundColor = UIColor.rgba(red: 224, green: 235, blue: 175, alpha: 1)
        
        
         page1Controller = createPage1ViewController()
       
    }
    private func initImageView(){
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        let screenY = setumei1.frame.height
        print(setumei1.frame.height)
        print(screenY)
        let wid = screenWidth/5
        let wid1 = screenWidth/10
        // 画像の縦横サイズを取得
        img1.frame = CGRect(x: wid1, y: screenY, width: wid, height: wid)
        img2.frame = CGRect(x: wid1*3, y: screenY, width: wid, height: wid)
        img3.frame = CGRect(x: wid1*5, y: screenY, width: wid, height: wid)
        img4.frame = CGRect(x: wid1*7, y: screenY, width: wid, height: wid)
        // UIImageViewのインスタンスをビューに追加
        self.view2.addSubview(img1)
        self.view2.addSubview(img2)
        self.view2.addSubview(img3)
        self.view2.addSubview(img4)
        
    }
    private func initImageView2(){
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        let screenY = setumei2.frame.origin.y + 60
        print(screenY)
        let wid = screenWidth/5
        // 画像の縦横サイズを取得
        img5.frame = CGRect(x: screenWidth/4, y: screenY, width: wid, height: wid)
        img6.frame = CGRect(x: screenWidth*2/4, y: screenY, width: wid, height: wid)
        
        // UIImageViewのインスタンスをビューに追加
        self.view2.addSubview(img5)
        self.view2.addSubview(img6)
    }
    func createPage1ViewController() -> rakkaViewController{
        let sb:UIStoryboard = UIStoryboard(name: "rakkaViewController",bundle: nil)
        let sController:rakkaViewController = sb.instantiateInitialViewController() as! rakkaViewController
        return sController
    }
    
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
    @IBAction func startBtn(_ sender: Any) {
         displayContentController(content: page1Controller!, container: view)
    }
    @IBAction func modoruBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    



}

