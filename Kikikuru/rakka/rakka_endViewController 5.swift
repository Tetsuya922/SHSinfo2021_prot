//
//  rakka_endViewController.swift
//  rakka
//
//  Created by 吉川哲也 on 2019/08/27.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class rakka_endViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var comentLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
     var page1Controller : rakka_startViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        print(backBtn.frame.origin.y)
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        let titleY = backBtn.frame.origin.y
        titleLabel.frame = CGRect(x: 0, y: titleY, width: screenWidth, height: screenHeight/4-titleY)
        titleLabel.text = "けっかはっぴょう！"
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.textColor = UIColor.rgba(red: 255, green: 140, blue: 0, alpha: 1)
        titleLabel.textAlignment = NSTextAlignment.center
        
        
        let scoreY = titleY + titleLabel.frame.height
        view2.frame = CGRect(x: 0, y: scoreY, width: screenWidth, height: screenHeight/4)
        view2.backgroundColor = UIColor.red
        
        /********結果********************/
        let userDefaluts = UserDefaults.standard
        let rakkaCount = userDefaluts.integer(forKey: "rakka_score")
        
        scoreLabel.frame = CGRect(x: 10, y: 10, width: screenWidth-20, height: screenHeight/4-20)
        scoreLabel.text = "あなたのスコアは\n" + String(rakkaCount) + "です！"
        scoreLabel.numberOfLines = 0
        scoreLabel.backgroundColor = UIColor.white
        scoreLabel.font = UIFont.systemFont(ofSize: 30)
        scoreLabel.textAlignment = NSTextAlignment.center
        
        let comentY = scoreY + view2.frame.height
        comentLabel.frame = CGRect(x: 10, y: comentY, width: screenWidth, height: screenHeight*1/3)
        var comentText:String = ""
        if rakkaCount >= 370{
            comentText = "おめでとう！\n君は防災マスターだ！"
        }else if rakkaCount >= 300{
            comentText = "おめでとう！\nこの調子でがんばろう！"
        }else if rakkaCount >= 150{
            comentText = "おめでとう！\nすごいね！"
        }else{
            comentText = "いらない物が\nあるみたいだよ！\nもう1度やってみよう！"
        }
        
        comentLabel.text = comentText
        comentLabel.font = UIFont.systemFont(ofSize: 30)
        comentLabel.numberOfLines = 0
        comentLabel.textAlignment = NSTextAlignment.center
        
        let btnY = comentY + comentLabel.frame.height
        startBtn.frame = CGRect(x: 0, y: btnY, width: screenWidth, height: screenHeight*1/6)
        startBtn.setTitle("スタート画面にもどる", for: .normal)
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        startBtn.setTitleColor(UIColor.black, for: .normal)
        startBtn.backgroundColor = UIColor.rgba(red: 224, green: 235, blue: 175, alpha: 1)
        
         page1Controller = createPage1ViewController()
        
    }
    func createPage1ViewController() -> rakka_startViewController{
        let sb:UIStoryboard = UIStoryboard(name: "rakka_startViewController",bundle: nil)
        let sController:rakka_startViewController = sb.instantiateInitialViewController() as! rakka_startViewController
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
