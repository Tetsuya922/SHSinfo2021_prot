//
//  ARViewController.swift
//  SHSinfo2019
//
//  Created by tetsuya yoshikawa on 2020/09/05.
//  Copyright © 2020 SHS情報技術. All rights reserved.
//

import UIKit
import ARKit


class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
   
    var direc:Double = 0.0
    var boxNode :  LabelNode? = nil
    var boxNode2 :  LabelNode? = nil
    var boxNode3 :  LabelNode? = nil
    var boxNode4 :  LabelNode? = nil
    var boxNode5 :  LabelNode? = nil
    
    var lastGestureScale :Float = 1.0
    var lastGestureScale2 :Float = 1.0
    var lastGestureScale3 :Float = 1.0
    var lastGestureScale4 :Float = 1.0
    var lastGestureScale5 :Float = 1.0

    //方向
       private var newAngleY :Float = 0.0
       private var newAngleX :Float = 0.0
       private var currentAngleX :Float = 0.0
       private var currentAngleY :Float = 0.0
      private var localTranslatePosition :CGPoint!
    //近い避難所
    var hinanjyo5 = [HinanJyo]()
    var hinanjyo5_2 = [HinanJyo2]()
    
    let defaultConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        if #available(iOS 12.0, *) {
            configuration.environmentTexturing = .automatic
        } else {
            // Fallback on earlier versions
        }
        return configuration
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
       
        
        print(direc)
        //ジェスチャーをOn!
        self.registerGestureRecognizer()
        
        var hinanjyo2 = HinanJyo2()
       //上位５件をhinanjyo5にコピー
        var i:Int = 0
        let userDefaults = UserDefaults.standard
        let lat = userDefaults.double(forKey: "lat")
        let lon = userDefaults.double(forKey: "lon")
        
      //  if hinanjyo5.count != 0{
            for hi: HinanJyo in hinanjyo5 {
                hinanjyo2.name = hi.name
                hinanjyo2.kyori = hi.kyori
                hinanjyo2.direction = Double(self.angle(currentLatitude: CGFloat(lat), currentLongitude: CGFloat(lon), targetLatitude: CGFloat(hi.lat), targetLongitude: CGFloat(hi.lon)))
                
                hinanjyo5_2.append(hinanjyo2)
                hinanjyo2 = HinanJyo2()
                print(hinanjyo5_2[i].name,hinanjyo5_2[i].direction)
                i+=1
                }
       // }
        var a:CGFloat = 0.0
        for i in 0..<5 {
            //カメラ座標系で３０cm前
            let kyori1 = 2 + a*2/10
            let kakudo = hinanjyo5_2[i].direction - direc
            let z1 = (Float) (kyori1 * cos(toRadian(CGFloat(kakudo))))
            let x1 = (Float) (kyori1 * sin(toRadian(CGFloat(kakudo))))
          
            let infrontCamera = SCNVector3Make(0, 0, -0.3)
            guard let cameraNode = sceneView.pointOfView else {
                return
            }
            
             //ワールド座標系に変換
            let pointInWorld = cameraNode.convertPosition(infrontCamera, to: nil)
            
            //スクリーン座標系へ
            var screenPosition = sceneView.projectPoint(pointInWorld)
           
            screenPosition.x = Float(200.0)
            screenPosition.y = Float(0.0)
            //ワールド座標系
            var finalPosition = sceneView.unprojectPoint(screenPosition)
            finalPosition.x = x1
            finalPosition.y = finalPosition.y + Float(a * 0.5)
            finalPosition.z = -z1
           
            cameraNode.eulerAngles.y = Float(-(kakudo / 180 * 3.14))
            let kyori:String = String(Int(hinanjyo5_2[i].kyori))
            
            if i==0{
                boxNode =  LabelNode(text: hinanjyo5_2[i].name,text2: kyori+"[m]",Jishin: hinanjyo5[i].jishin,Kouzui: hinanjyo5[i].kouzui,Tsunami: hinanjyo5[i].tsunami,Jyo: hinanjyo5[i].jyo)
                boxNode!.position = finalPosition
                boxNode!.eulerAngles = cameraNode.eulerAngles
                sceneView.scene.rootNode.addChildNode(boxNode!)
            }else if i==1{
               boxNode2 =  LabelNode(text: hinanjyo5_2[i].name,text2: kyori+"[m]",Jishin: hinanjyo5[i].jishin,Kouzui: hinanjyo5[i].kouzui,Tsunami: hinanjyo5[i].tsunami,Jyo: hinanjyo5[i].jyo)
               boxNode2!.position = finalPosition
               boxNode2!.eulerAngles = cameraNode.eulerAngles
               sceneView.scene.rootNode.addChildNode(boxNode2!)
            }else if i==2{
               boxNode3 =  LabelNode(text: hinanjyo5_2[i].name,text2: kyori+"[m]",Jishin: hinanjyo5[i].jishin,Kouzui: hinanjyo5[i].kouzui,Tsunami: hinanjyo5[i].tsunami,Jyo: hinanjyo5[i].jyo)
               boxNode3!.position = finalPosition
               boxNode3!.eulerAngles = cameraNode.eulerAngles
               sceneView.scene.rootNode.addChildNode(boxNode3!)
            }else if i==3{
               boxNode4 =  LabelNode(text: hinanjyo5_2[i].name,text2: kyori+"[m]",Jishin: hinanjyo5[i].jishin,Kouzui: hinanjyo5[i].kouzui,Tsunami: hinanjyo5[i].tsunami,Jyo: hinanjyo5[i].jyo)
               boxNode4!.position = finalPosition
               boxNode4!.eulerAngles = cameraNode.eulerAngles
               sceneView.scene.rootNode.addChildNode(boxNode4!)
            }
            else{
                boxNode5 =  LabelNode(text: hinanjyo5_2[i].name,text2: kyori+"[m]",Jishin: hinanjyo5[i].jishin,Kouzui: hinanjyo5[i].kouzui,Tsunami: hinanjyo5[i].tsunami,Jyo: hinanjyo5[i].jyo)
                boxNode5!.position = finalPosition
                boxNode5!.eulerAngles = cameraNode.eulerAngles
                sceneView.scene.rootNode.addChildNode(boxNode5!)
            }
            
          
            
            
            
          a+=1
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        if #available(iOS 11.3, *) {
            configuration.planeDetection = [.horizontal, .vertical]
        } else {
            // Fallback on earlier versions
        } //水平面を認識  両方認識する場合[.horizontal, .vertical]
        sceneView.session.run(defaultConfiguration)
        
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* let z1 = (Float) (2 * cos(toRadian(CGFloat(hinanjyo5_2[0].direction))))
        let x1 = (Float) (2 * sin(toRadian(CGFloat(hinanjyo5_2[0].direction))))
         //カメラ座標系で３０cm前
        let infrontCamera = SCNVector3Make(x1, 0, z1)
              guard let cameraNode = sceneView.pointOfView else {
                  return
              }
              
               //ワールド座標系に変換
              let pointInWorld = cameraNode.convertPosition(infrontCamera, to: nil)
              
              //スクリーン座標系へ
              var screenPosition = sceneView.projectPoint(pointInWorld)
              //XY座標表示 スクリーン座標系
              guard let location = touches.first?.location(in: sceneView) else {
                         
                         return
              }
        screenPosition.x = Float(location.x)
        screenPosition.y = Float(location.y)
    
              //ワールド座標系
              let finalPosition = sceneView.unprojectPoint(screenPosition)
            //ノードを生成
            let boxNode =  LabelNode(text: "佐土原高校地域改良センター",text2: "25641.23")
            boxNode.position = finalPosition
            boxNode.eulerAngles = cameraNode.eulerAngles
        
            sceneView.scene.rootNode.addChildNode(boxNode)
        
     */
        }
    
   
    @available(iOS 12.0, *)
    private func setWorldMapToSession(worldMap: ARWorldMap){
        let configuration = ARWorldTrackingConfiguration()
        if #available(iOS 12.0, *) {
            configuration.initialWorldMap = worldMap
        } else {
            // Fallback on earlier versions
        }
        sceneView.session.run(configuration)
    }
   // 基準地の緯度経度から目的地の緯度経度の方角を計算する
     func angle(currentLatitude: CGFloat, currentLongitude: CGFloat, targetLatitude: CGFloat, targetLongitude: CGFloat) -> Int {
            
            let currentLatitude     = toRadian(currentLatitude)
            let currentLongitude    = toRadian(currentLongitude)
            let targetLatitude      = toRadian(targetLatitude)
            let targetLongitude     = toRadian(targetLongitude)
            
            let difLongitude = targetLongitude - currentLongitude
            let y = sin(difLongitude)
            let x = cos(currentLatitude) * tan(targetLatitude) - sin(currentLatitude) * cos(difLongitude)
            let p = atan2(y, x) * 180 / CGFloat.pi
            
            if p < 0 {
                return Int(360 + atan2(y, x) * 180 / CGFloat.pi)
            }
            return Int(atan2(y, x) * 180 / CGFloat.pi)
        }
     // 角度からラジアンに変換
        func toRadian(_ angle: CGFloat) -> CGFloat {
            return angle * CGFloat.pi / 180
        }
     //各ジェスチャー
       func registerGestureRecognizer() {

        let pinchGestureRecognizer = UIPinchGestureRecognizer(target:self, action: #selector(pinched))
           self.sceneView.addGestureRecognizer(pinchGestureRecognizer)

           let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
           self.sceneView.addGestureRecognizer(panGestureRecognizer)

           let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
           self.sceneView.addGestureRecognizer(longPressGestureRecognizer)

       }


       //長押し
       @objc func longPressed(recognizer: UILongPressGestureRecognizer) {
           print("長押し")
           guard let longPressedView = recognizer.view as? ARSCNView else { return }
           let touch = recognizer.location(in: longPressedView)
           self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
               if node.name == "node1" {
                   switch recognizer.state {
                   case .began:
                       localTranslatePosition = touch
                   case .changed:
                       let deltaX = Float(touch.x - self.localTranslatePosition.x)/1000
                       let deltaY = Float(touch.y - self.localTranslatePosition.y)/1000
                       node.localTranslate(by: SCNVector3(deltaX,0.0,deltaY))
                       self.localTranslatePosition = touch
                   default:
                       break
                   }
               }
           }


       }

       //拡大・縮小
       @objc func pinched(recognizer: UIPinchGestureRecognizer) {
       if recognizer.state == .began {
            lastGestureScale = 1
            lastGestureScale2 = 1
            lastGestureScale3 = 1
            lastGestureScale4 = 1
            lastGestureScale5 = 1
        }

         let newGestureScale: Float = Float(recognizer.scale)
         let newGestureScale2: Float = Float(recognizer.scale)
         let newGestureScale3: Float = Float(recognizer.scale)
         let newGestureScale4: Float = Float(recognizer.scale)
         let newGestureScale5: Float = Float(recognizer.scale)
        // ここで直前のscaleとのdiffぶんだけ取得しときます
        let diff = newGestureScale - lastGestureScale
         let diff2 = newGestureScale2 - lastGestureScale2
         let diff3 = newGestureScale3 - lastGestureScale3
         let diff4 = newGestureScale4 - lastGestureScale4
         let diff5 = newGestureScale5 - lastGestureScale5
        
         let currentScale = boxNode!.scale
        // diff分だけscaleを変化させる。1は1倍、1.2は1.2倍の大きさになります。
        boxNode!.scale = SCNVector3Make(
            currentScale.x * (1 + diff),
            currentScale.y * (1 + diff),
            currentScale.z * (1 + diff)
        )
        let currentScale2 = boxNode2!.scale
       // diff分だけscaleを変化させる。1は1倍、1.2は1.2倍の大きさになります。
       boxNode2!.scale = SCNVector3Make(
           currentScale2.x * (1 + diff2),
           currentScale2.y * (1 + diff2),
           currentScale2.z * (1 + diff2)
       )
        let currentScale3 = boxNode3!.scale
          // diff分だけscaleを変化させる。1は1倍、1.2は1.2倍の大きさになります。
          boxNode3!.scale = SCNVector3Make(
              currentScale3.x * (1 + diff3),
              currentScale3.y * (1 + diff3),
              currentScale3.z * (1 + diff3)
          )
        let currentScale4 = boxNode4!.scale
          // diff分だけscaleを変化させる。1は1倍、1.2は1.2倍の大きさになります。
          boxNode4!.scale = SCNVector3Make(
              currentScale4.x * (1 + diff4),
              currentScale4.y * (1 + diff4),
              currentScale4.z * (1 + diff4)
          )
        let currentScale5 = boxNode5!.scale
          // diff分だけscaleを変化させる。1は1倍、1.2は1.2倍の大きさになります。
          boxNode5!.scale = SCNVector3Make(
              currentScale5.x * (1 + diff5),
              currentScale5.y * (1 + diff5),
              currentScale5.z * (1 + diff5)
          )
        
        // 保存しとく
        lastGestureScale = newGestureScale
        lastGestureScale2 = newGestureScale2
        lastGestureScale3 = newGestureScale3
        lastGestureScale4 = newGestureScale4
        lastGestureScale5 = newGestureScale5
          
       }

       //方向転換
       @objc func panned(recognizer: UIPanGestureRecognizer) {
           print("方向転換")
           switch recognizer.state {
           case .changed:
               guard let pannedView = recognizer.view as? ARSCNView else { return }
               let translation = recognizer.translation(in: pannedView)

               self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                   if node.name == "node1" {
                       self.newAngleX = Float(translation.y) * (Float)(Double.pi)/180
                       self.newAngleX += self.currentAngleX
                       self.newAngleY = Float(translation.x) * (Float)(Double.pi)/180
                       self.newAngleY += self.currentAngleY
                       node.eulerAngles.x = self.newAngleX
                       node.eulerAngles.y = self.newAngleY
                   }
               }

           case .ended:
               self.currentAngleX = self.newAngleX
               self.currentAngleY = self.newAngleY
           default:
               break
           }
        }
    @IBAction func back(_ sender: Any) {
            self.dismiss(animated: true, completion: nil);
    }
    
}


extension ViewController: ARSCNViewDelegate{
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    }
}

    
   class LabelNode: SCNNode {

    init(text: String, text2:String,Jishin:Int,Kouzui:Int,Tsunami:Int,Jyo:Int) {
           super.init()

            
        
           //*******************************************************
           // テキストノードの生成
           //*******************************************************
           let str = SCNText(string: text, extrusionDepth: 0.11)
           str.font = UIFont(name: "HiraginoSans-W6", size: 0.3);
           let textNode = SCNNode(geometry: str)

           
          // テキストを配置する場所を決める
           let (min, max) = (textNode.boundingBox)
           let textBoundsWidth = (max.x - min.x)
           let textBoundsheight = (max.y - min.y)
           let z = CGFloat(0) // 目の前0メートルの距離
          
        
        
        
           let str2 = SCNText(string: text2, extrusionDepth: 0.11)
           str2.font = UIFont(name: "HiraginoSans-W6", size: 0.3);
           let textNode2 = SCNNode(geometry: str2)
          // テキストを配置する場所を決める
           let (min2, max2) = (textNode2.boundingBox)
           let textBoundsWidth2 = (max2.x - min2.x)
           let textBoundsheight2 = (max2.y - min2.y)
           let z2 = CGFloat(0) // 目の前0メートルの距離
           var wid :CGFloat
            if textBoundsWidth>textBoundsWidth2{
                wid = CGFloat(textBoundsWidth)
            }else { wid = CGFloat(textBoundsWidth2)}
        
            let x1 =  (wid * 1.1 / 2) - CGFloat(textBoundsWidth) / 2
            textNode.pivot = SCNMatrix4MakeTranslation(textBoundsWidth/2 + min.x, textBoundsheight/2 + min.y, 0)
            textNode.position = SCNVector3(-x1, 0, z)
            // 色を設定
            textNode.geometry?.materials.append(SCNMaterial())
        textNode.geometry?.materials.first?.diffuse.contents = UIColor.white
        
           let x2 =  wid*1.1/2 - CGFloat(textBoundsWidth2) / 2
           textNode2.pivot = SCNMatrix4MakeTranslation(textBoundsWidth2/2 + min.x, textBoundsheight2/2 + min.y, 0)
           textNode2.position = SCNVector3(-x2, -0.3, z2)
           // 色を設定
           textNode2.geometry?.materials.append(SCNMaterial())
        textNode2.geometry?.materials.first?.diffuse.contents = UIColor.white

          //*******************************************************
          // パネルノードの生成
          //*******************************************************
          // バウンディングボックスから縦横の長さを取得する
           let (min3, max3) = (textNode.boundingBox)
           let w1 = CGFloat(max3.x - min3.x)
           //let h1 = CGFloat(max3.y - min3.y)
            let (min4, max4) = (textNode2.boundingBox)
            let w2 = CGFloat(max4.x - min4.x)
           // let h2 = CGFloat(max4.y - min4.y)
        
            var w : CGFloat
            if w1>w2  { w = w1}
            else { w = w2 }
        
            if w < 1.4{
            w = 1.4
            }
           let h = 0.5
        
        let panelNode = SCNNode(geometry:SCNBox(width: 1.1*w+0.1, height:CGFloat(2*h+0.1), length: 0.1, chamferRadius: 0))
        panelNode.position = SCNVector3(x:0,y:0,z:0)
          //  Float(w/10), y:-Float(h/2), z:0)
          // 色を設定
          panelNode.geometry?.materials.append(SCNMaterial())
          panelNode.geometry?.materials.first?.diffuse.contents = UIColor.rgba(red: 25, green: 170, blue: 7, alpha: 1.0)
                
        let panelNode1 = SCNNode(geometry:SCNBox(width: 1.1*w+0.2, height:CGFloat(2*h+0.2), length: 0.07, chamferRadius: 0))
        panelNode1.position = SCNVector3(x:0,y:0,z:0)
            //SCNVector3(x: Float(w/10), y:-Float(h/2), z:0)
          // 色を設定
          panelNode1.geometry?.materials.append(SCNMaterial())
          panelNode1.geometry?.materials.first?.diffuse.contents = UIColor.white
        
        //*******************************************************
          // イメージノードの生成
          //*******************************************************
        if Jishin==1 {
           let image1 = UIImage(named: "jishin2.png")
           let node1 = SCNNode()
           let geometry1 = SCNPlane(width: 0.3,height: 0.3)
           geometry1.firstMaterial?.diffuse.contents = image1
           node1.geometry = geometry1
           node1.position = SCNVector3(x: -Float(w/2)+0.05, y:0.3 , z:0.06)
           addChildNode(node1)
        }
        if Kouzui==1 {
          let image2 = UIImage(named: "kouzui.png")
          let node2 = SCNNode()
          let geometry2 = SCNPlane(width: 0.3,height: 0.3)
          geometry2.firstMaterial?.diffuse.contents = image2
          node2.geometry = geometry2
          node2.position = SCNVector3(x: -Float(w/2)+0.05+0.32, y:0.3 , z:0.06)
          addChildNode(node2)
        }
        if Tsunami==1 {
          let image3 = UIImage(named: "tunami.png")
          let node3 = SCNNode()
           let geometry3 = SCNPlane(width: 0.3,height: 0.3)
          geometry3.firstMaterial?.diffuse.contents = image3
          node3.geometry = geometry3
          node3.position = SCNVector3(x: -Float(w/2)+0.05+0.64, y:0.3 , z:0.06)
          addChildNode(node3)
        }
        if Jyo==1 {
          let image4 = UIImage(named: "jyo2.png")
          let node4 = SCNNode()
          let geometry4 = SCNPlane(width: 0.6,height: 0.3)
          geometry4.firstMaterial?.diffuse.contents = image4
          node4.geometry = geometry4
          node4.position = SCNVector3(x: -Float(w/2)+0.05+0.96+0.15, y:0.3 , z:0.06)
          addChildNode(node4)
        }
           addChildNode(textNode)
           addChildNode(textNode2)
           addChildNode(panelNode1)
           addChildNode(panelNode)
           
           
           
           
        
           //*******************************************************
           // サイズを調整する
           //*******************************************************
        let ratio = 0.5 / w
           scale = SCNVector3(ratio, ratio, ratio)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}


