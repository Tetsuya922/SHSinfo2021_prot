//
//  explainViewController.swift
//  SHSinfo2021
//
//  Created by 吉川哲也 on 2021/12/09.
//  Copyright © 2021 SHS情報技術. All rights reserved.
//

import UIKit

class explainViewController: UIViewController {

    @IBOutlet weak var explainImage: UIImageView!
    @IBOutlet weak var explainText: UILabel!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }

    
    var indexNum:Int=0
    
    @IBOutlet weak var backButton_outlet: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("w: \(UIScreen.main.bounds.size.width) h: \(UIScreen.main.bounds.size.height)");
        showExplain(indexNum: indexNum);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
     
        //buttonコーナーを丸く
        backButton_outlet.layer.cornerRadius = 15.0
        
    }
    func showExplain(indexNum:Int){
        
        switch(indexNum){
        case 0:
            explainImage.image=UIImage(named: "kaityuu")!;
            nameLabel.text = "懐中電灯"
            explainText.text="大きな地震が起きると家具や家電が倒れてきたり、ガラスが割れて床に飛び散ったりします。このような地震が夜にくると部屋が真っ暗で避難するのも大変です。そんなときに懐中電灯があると辺りを照らすことができるので、危ないものを避けて避難することができます。"
            break
        case 1:
            explainImage.image=UIImage(named: "mobairu")!;
            nameLabel.text = "モバイルバッテリー"
            explainText.text="情報収集したり家族の安否を確認したりするためには、スマホは必需品です。しかし、災害時に停電が起こるとスマホの充電ができなくなります。そのために、モバイルバッテリーがあると停電中でも心の余裕を持つことができます。"
            break
        case 2:
            explainImage.image=UIImage(named: "denti")!;
            nameLabel.text = "予備の電池"
            explainText.text="ライトやラジオも電池がないと使うことができません。予備があれば電池の減りなど気にせず使えることができ、安心します。乾電池は液漏れ防止のものを選びましょう。"
            break
        case 3:
            explainImage.image=UIImage(named: "radio")!
            nameLabel.text = "ラジオ"
            explainText.text="停電時や災害の際、テレビが見れなくなったり、ネットが繋がらなかったり、情報を得たとしてもそれがデマ情報だった場合もあります。スマホと違って消費電力が少なく、被災した地域をメインに情報を伝えることができます。"
            break
        case 4:
            explainImage.image=UIImage(named: "kityouhin")!
            nameLabel.text = "貴重品"
            explainText.text="・現金（硬貨）・通帳\n" +
            "・身分証明書・各種カード\n" +
            "・印鑑\n" +
            "・家や車の予備鍵\n" + "停電時にはキャッシュカードが使えない可能性があるので、現金を用意しておきましょう。小銭を多めにしておくと、固定電話やスマホを使えないときに公衆電話を使うときなどに便利です。また、免許証や保険証といった身分証明書があると、被災後のさまざまな届出をする際にスムーズにことが運びます。"
            break
        case 5:
            explainImage.image=UIImage(named: "fuku")!
            nameLabel.text = "衣類"
            explainText.text="雨の時に、災害がおこると服が濡れてしまい風邪をひくかもしれません。コンパクトにまとまるダウンジャケット、ダウンパンツなど暖かく軽量のものがおすすめです。できる限り替えの服もいれておくといいです。"
            break
        case 6:
            explainImage.image=UIImage(named: "hozon")!
            nameLabel.text = "保存食"
            explainText.text="・缶詰・乾パン\n・飲料水\n・アルファ米\n・チョコレート\n自宅が倒壊した場合は避難所での生活を送ることになります。救援物資が届くまで最短でも3日かかると想定しましょう。"

            break
        case 7:
            explainImage.image=UIImage(named: "raita")!
            nameLabel.text = "ライター"
            explainText.text="震災時には、電気ガスが使えない可能性があります。その状況で生き延びるために火を起こすことが重要です。また、食べ物を温めたり、食べられる物を確保して加熱して食べる必要が出てくるかもしれません。"
            break
           
                            
        case 8:
            explainImage.image=UIImage(named: "tebukuro")!
            nameLabel.text = "防寒グッズ"
            explainText.text="・毛布\n・カイロ\n・アルミホイル\n冬に災害が起こった場合には、寒さで寝れなかったり風邪をひいたりします。また、お年寄りや赤ちゃん、体が弱い人は、低体温症になる可能性があります。"
            break
        
                            
        case 9:
            explainImage.image=UIImage(named: "kyuukyuu")!
            nameLabel.text = "救急用品"
            explainText.text="大きな災害が発生するとケガをする可能性が高くなります。災害直後は医療体制も混乱することが考えられるため、応急手当てができるように救急セットを用意しておきましょう。"
            break
                          
        case 10:
            explainImage.image=UIImage(named: "keitai")!
            nameLabel.text = "携帯電話"
            explainText.text="情報を収集したり家族の安否を確認するために必要になります。"
            break
          
        case 11:
            explainImage.image=UIImage(named: "kami")!
            nameLabel.text = "衛生用品"
            explainText.text="・ウェットティッシュ・トイレットペーパー\n" +
            "・歯ブラシ\n" +
            "・タオル\n" +
            "・マスク\n"+"・生理用品\n"+"災害発生時には水の供給がストップして、入浴や歯磨きなどが十分にできなくなるかもしれません。体が不衛生な状態が続くと健康を害しやすいため、衛生用品の準備には万全にしておきましょう。"
            break
                            
        case 12:
            explainImage.image=UIImage(named: "pfudebako")!
            nameLabel.text = "筆記用具"
            explainText.text="避難所で私物に名前を書いたり、伝言を残したりする時に必要になります。"
            break
           
        case 13:
            explainImage.image=UIImage(named: "baby")!
            nameLabel.text = "赤ちゃんに必要なもの"
            explainText.text="・粉ミルク・離乳食・哺乳瓶・スプーン\n"+"・バスタオル・ガーゼ・着替え\n"+"・おむつ・お尻ふき\n" + "・母子手帳\n"+"・おもちゃ"
            break
          
                            
        case 14:
            explainImage.image=UIImage(named: "inu")!
            nameLabel.text = "犬に必要なもの"
            explainText.text="・非常食・飲料水\n" +
            "・避難用具（ケージ、クレート、キャリーケース）\n" +
            "・鑑札・迷子札\n" +
            "・薬\n" +
            "・タオル、新聞紙"
            break
            
            
            
        default:
            explainImage.image=UIImage(named: "kaityuu")!;
            explainText.text="エラー"
            break
        }
    }
}
