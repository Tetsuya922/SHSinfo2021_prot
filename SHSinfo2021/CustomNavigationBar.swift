//
//  CustomNavigationBar.swift
//  SHSinfo2018
//
//  Created by 吉川哲也 on 2018/06/01.
//  Copyright © 2018年 SHS情報技術. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
       // self.barTintColor = UIColor.blue    //バーの色
        //self.barTintColor = UIColor.rgba(red: 173, green: 220, blue: 247, alpha: 1)
        
        self.tintColor = UIColor.white    //バー上のアイテムの色
        //タイトルテキストの色
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
         self.barTintColor = UIColor.rgba(red: 173, green: 220, blue: 247, alpha: 1)    //バーの色
        //渡されるsizeは widthは決まっているがheightは決まっていない
        //super.sizeThatFits(size)でheightが決まる
        var newSize = super.sizeThatFits(size)
        //iphoneX用
        var topInset:CGFloat = 0
        if #available(iOS 11.0, *) {
            topInset = superview?.safeAreaInsets.top ?? 0
        }
        let addHeight:CGFloat = 40.0 + topInset    //通常よりどれだけ大きくするか
        newSize.height += addHeight
        
        return newSize
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //iOS11以上でのみ
        if #available(iOS 11.0, *) {
            for subview in self.subviews {
                let stringFromClass = NSStringFromClass(subview.classForCoder)
                if stringFromClass.contains("BarBackground") {
                    //ステータスバー分あげないと余白ができる。
                    let statusBarHeight = UIApplication.shared.statusBarFrame.height
                    let point = CGPoint(x:0,y:-statusBarHeight)
                    //ここでバーの高さを調節 (sizeThatFitsを呼び出す)
                    subview.frame = CGRect(origin: point, size: sizeThatFits(self.bounds.size))
                }else if stringFromClass.contains("BarContentView") {
                    //ここでサブビューの位置を調整
                    subview.frame.origin.y = 20.0    //付け加えた高さ分でちょうど良い！
                  
                  
                }
            }
        }
    }

}
/******　拡張設定　******************/
extension UIColor {
    class func rgba1(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
        
    }
}
