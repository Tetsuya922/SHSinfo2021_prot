//
//  ViewController.swift
//  sound_project_RainSetouver
//
//  Created by TomokiNishihara on 2018/07/19.
//  Copyright © 2018年 RainSetouver. All rights reserved.
//

import UIKit
import AVFoundation

class soundViewController: UIViewController {
    var buttonState=false;
    var player:AVAudioPlayer?;
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var Play_Text: UIButton!
    
    @IBOutlet weak var btnModoru: UIButton!
    
    @IBAction func PlayBack_Button(_ sender: Any) {
        if(buttonState){
            buttonState=false;
        }else{
            buttonState=true;
        }
        judgeButtonText();
        playSound();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //ボタン1行表示
        btnModoru.titleLabel?.numberOfLines = 1;
        btnModoru.backgroundColor = UIColor.rgba(red: 122, green: 174, blue: 252, alpha: 1)
        btnModoru.setTitleColor(UIColor.white, for: .normal)
        //buttonコーナーを丸く
        btnModoru.layer.cornerRadius = 5.0
        
        
    text.text="助けを呼びたいときに\n再生ボタンを押してください!"
        judgeButtonText();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }

    func judgeButtonText(){
    if(!buttonState){
    Play_Text.setTitle("再生", for: UIControlState.normal);
    }else{
    Play_Text.setTitle("停止", for: UIControlState.normal);
    }
    }
    func playSound(){
        if(buttonState){
            if let sound=NSDataAsset(name: "one"){
                player=try?AVAudioPlayer(data: sound.data);
                player?.numberOfLoops = -1;
                player?.play();
            }
        }else{
            player?.stop();
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let screen_width_rate=Double(UIScreen.main.bounds.width)/320.0;
        let screen_height_rate=Double(UIScreen.main.bounds.height)/568.0;
        
        text.frame=CGRect.init(x: 0, y: 68*screen_height_rate, width: 320*screen_width_rate, height: 165*screen_height_rate);
        Play_Text.frame=CGRect.init(x: 8*screen_width_rate, y: 281*screen_height_rate, width: 304*screen_width_rate, height: 235*screen_height_rate);
        let text_rate=(screen_width_rate+screen_height_rate)/2;
        text.font=text.font?.withSize(CGFloat(22.0*text_rate));
        Play_Text.titleLabel?.font=Play_Text.titleLabel?.font?.withSize(CGFloat(70*text_rate));
        bgView.frame=CGRect.init(x: 0, y: 20*screen_height_rate, width: 320*screen_width_rate, height: 548*screen_height_rate);
    }
    @IBAction func leftswipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
}

