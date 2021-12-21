//
//  Mochi.swift
//  SHSinfo2021
//
//  Created by 吉川哲也 on 2021/12/09.
//  Copyright © 2021 SHS情報技術. All rights reserved.
//

import UIKit

class Mochi: UIViewController , UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    @IBOutlet weak var myTableview: UITableView!
    let prefectures = ["懐中電灯", "モバイルバッテリー", "予備の電池", "ラジオ", "貴重品", "衣類・下着", "保存食","ライター", "防寒グッズ", "救急用品", "携帯電話", "衛生用品", "筆記用具", "赤ちゃんに必要なもの","犬に必要なもの"]
    let mochiImage = ["kaityuu","mobairu","denti2","radio","kityouhin","fuku","hozon","raita","mafuro","kyuukyuu","keitai","kami","pfudebako","baby","inu"]
    var mochiFlag = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    var count = 0
    
    override func viewDidLoad() {
           super.viewDidLoad()
            myTableview.dataSource = self
            myTableview.delegate = self
        
        let userDefaults=UserDefaults.standard;
        if(userDefaults.object(forKey: "ITEM2") != nil){
            loadValues();
        }
        for i in 0..<15 {
            if mochiFlag[i] == true{
                count = count+1
            }
        }
        countLabel.text = String(count) + "/15"
        
        //buttonコーナーを丸く
        backBtn.layer.cornerRadius = 15.0
        
        /*::::::::::::長押し::::::::::::::::::::::::::*/
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
                longPressGesture.minimumPressDuration = 0.5
                 longPressGesture.allowableMovement = 10
                myTableview.addGestureRecognizer(longPressGesture)
        /*********************************************************************************************/
       }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
  
    func loadValues(){
        let userDefaults = UserDefaults.standard;
        mochiFlag = userDefaults.object(forKey: "ITEM2") as! Array<Bool>;
        print("LOAD")
    }
    func saveValues(){
        let userDefaults = UserDefaults.standard;
        userDefaults.set(mochiFlag, forKey: "ITEM2");
        userDefaults.synchronize();
        print("保存")
    }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    /* 長押しした際に呼ばれるメソッド */
        
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
           guard longPressGesture.state == .ended else {
               return
           }
           
           let point = longPressGesture.location(in: myTableview)
           guard let indexPath = myTableview.indexPathForRow(at: point) else {
               return
           }
           print("CellLongTapped, index=\(indexPath.row)")
           myTableview.deselectRow(at: indexPath, animated: true)


        let storyBoard:UIStoryboard=UIStoryboard(name: "explainViewController", bundle: Bundle.main);
        //let v:explain_view_controll=storyBoard.instantiateInitialViewController() as! explain_view_controll;
        let v:explainViewController = storyBoard.instantiateInitialViewController() as! explainViewController;
        v.modalTransitionStyle=UIModalTransitionStyle.flipHorizontal;
        v.indexNum = indexPath.row  //値渡し
        self.present(v, animated: true, completion: nil);
        
       }

       // TableViewに表示するセルの数を返却します。
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.prefectures.count;
       }

       // 各セルを生成して返却します。
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // セルを取得する
            let cell: CustomCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CustomCellTableViewCell
           cell.imageView?.image=nil;
           cell.myLabel?.text = self.prefectures[indexPath.row]
           cell.myImageView?.image = UIImage(named:self.mochiImage[indexPath.row])
         
           cell.backgroundColor = UIColor.rgba(red: 122, green: 196, blue: 205, alpha: 0.9)
           
           var flag =  self.mochiFlag[indexPath.row]
    
           if flag == true {
               cell.imageView?.image=UIImage(named: "checked");
            } else {
                cell.imageView?.image=UIImage(named: "unchecked");
            }
     
         return cell
       }
    //タップされたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell=tableView.cellForRow(at: indexPath);
        
     
        
        if(mochiFlag[indexPath.row]){
            mochiFlag[indexPath.row]=false;
        }else{
            mochiFlag[indexPath.row]=true;
        }
      
        if(mochiFlag[indexPath.row]){
            cell?.imageView?.image=UIImage(named: "checked");
           count = count+1
            countLabel.text = String(count) + "/15"
        
        }else{
            cell?.imageView?.image=UIImage(named: "unchecked");
            count = count-1
             countLabel.text = String(count) + "/15"
        }
     
  saveValues()
    }
    func numberOfSections(in tableView: UITableView) -> Int { // sectionの数を決める
            return 1
        }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            // Cellの高さを決める
            return 100
        }
   }

