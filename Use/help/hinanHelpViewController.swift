//
//  hinanHelpViewController.swift
//  SHSinfoAR
//
//  Created by tetsuya yoshikawa on 2020/10/17.
//  Copyright © 2020 SHS情報技術. All rights reserved.
//

import UIKit

class hinanHelpViewController:UIViewController ,UIScrollViewDelegate{

   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var btnModoru: UIButton!
   var imageView1:UIImageView!
   
   var page1Controller : UseViewController?

   override func viewDidLoad() {
       super.viewDidLoad()
       print("ビューサイズ")
       print(view.frame.size.width)
       
      
       //表示のサイズ スクロールビュー
       scrollView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y + 0  , width: view.frame.size.width, height: view.frame.size.height)
       //1つめの画像添付
       var image1 = UIImage(named: "ar4.png")
       image1 = UIImage(named: "ar4.png")
       imageView1 = UIImageView(image: image1)
    let imageViewHeight1 = image1!.size.height * scrollView.frame.size.width / image1!.size.width
       imageView1.frame = CGRect(x:scrollView.frame.origin.x, y: scrollView.frame.origin.y, width: scrollView.frame.size.width, height: imageViewHeight1)
       imageView1.contentMode = .scaleAspectFill
       self.scrollView.addSubview(imageView1)
       var yy = scrollView.frame.origin.y
     

       //中身のサイズ
       scrollView.contentSize = CGSize(width: view.frame.width, height: imageViewHeight1)
       
       //戻るボタン
       //ボタン２行表示
       btnModoru.titleLabel?.numberOfLines = 2;
       btnModoru.backgroundColor = UIColor.rgba(red: 122, green: 174, blue: 252, alpha: 1)
       btnModoru.setTitleColor(UIColor.white, for: .normal)
       //buttonコーナーを丸く
       btnModoru.layer.cornerRadius = 15.0
       page1Controller = createPage1ViewController()
       
       
       // スクロールの跳ね返り
       scrollView.bounces = false
       //デリゲート
       scrollView.delegate = self
    
       scrollView.maximumZoomScale = 3.0
       scrollView.minimumZoomScale = 1.0
       self.view.addSubview(scrollView)
       
       
       
       
       // Do any additional setup after loading the view.
   }
   
   func viewForZooming(in scrollView: UIScrollView) -> UIView? {
       return self.imageView1
   }
   override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
   }

   @IBAction func btnBack(_ sender: Any) {
       //displayContentController(content: page1Controller!, container: view)
       self.dismiss(animated: true, completion: nil);
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
   /***************画面遷移**************************/
   func createPage1ViewController() -> UseViewController{
       let sb:UIStoryboard = UIStoryboard(name: "UseViewController",bundle: nil)
       let sController:UseViewController = sb.instantiateInitialViewController() as! UseViewController
       return sController
   }
   
   @IBAction func leftSwipe(_ sender: Any) {
       self.dismiss(animated: true, completion: nil);
   }
   
  

}
