//
//  SceneController.swift
//  CircleViews
//
//  Created by Prajwal Kedilaya on 9/27/15.
//  Copyright © 2015 Prajwal Kedilaya. All rights reserved.
//

import UIKit
import SpriteKit

class SceneController: UIViewController {
    
    var scene: BounceScene!
    
    //constants
    let kMinDistance: CGFloat = 25
    let kMinDuration: CGFloat = 0.1
    let kMinSpeed: CGFloat = 100
    let kMaxSpeed: CGFloat = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let spriteView = view as? SKView {
            scene = BounceScene()
            scene.size = spriteView.frame.size
            spriteView.presentScene(scene)
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // only single finger actions
        if touches.count == 1 {
            if let touch = touches.first {
                let point = touch.locationInNode(scene)
                if let node = scene.nodeAtPoint(point) as? SKSpriteNode {
                    node.physicsBody?.applyImpulse(CGVectorMake(CGFloat(5), CGFloat(5)))
                }
            }
        }
    }
}
