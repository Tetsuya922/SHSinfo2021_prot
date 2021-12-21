//
//  CheakBox.swift
//  SHSinfo2021
//
//  Created by 吉川哲也 on 2021/12/09.
//  Copyright © 2021 SHS情報技術. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    // Images
    let checkedImage = UIImage(named: "checked")! as UIImage
    let uncheckedImage = UIImage(named: "unchecked")! as UIImage
  
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
           self.setImage(checkedImage, for: UIControl.State.normal)
         
            } else {
           self.setImage(uncheckedImage, for: UIControl.State.normal)
          
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
     
        
    }
    
    func setChecked(_ check : Bool){
        isChecked = check
    }
    
   
}
