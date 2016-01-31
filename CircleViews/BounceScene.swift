//
//  BounceScene.swift
//  CircleViews
//
//  Created by Prajwal Kedilaya on 9/24/15.
//  Copyright © 2015 Prajwal Kedilaya. All rights reserved.
//

import UIKit
import SpriteKit

class BounceScene: SKScene {
    var contentCreated = false
    
    let numCircles = 20
    let diameter: CGFloat = 75
    
    let loSpeed = 15
    let medSpeed = 50
    let hiSpeed = 150
    
    var startNode: SKSpriteNode?
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            createContents()
            contentCreated = true
        }
    }
    
    func createContents(){
        backgroundColor = UIColor.whiteColor()
        
        //constraints on edges of frame to bounce off walls
        let pBody = SKPhysicsBody (edgeLoopFromRect: frame)
        physicsBody = pBody
        
        for i in 1...numCircles{
            
            //add circle with image
            let shape = SKSpriteNode(imageNamed: "smiling.png")
            shape.name = String(i)
            
            //set color to white
            shape.size = CGSizeMake(diameter, diameter)
            
            //random initial position for circle
            shape.position = CGPoint (x: CGFloat(arc4random()%UInt32(size.width)), y: CGFloat(arc4random()%UInt32(size.height)))
            
            //add shape to scene
            addChild(shape)
            
            //set size of interacting physics element 
            shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
            
            //random initial velocity
            let xVelocity = CGFloat(medSpeed+random()%10)
            let yVelocity = CGFloat(medSpeed+random()%10)
            shape.physicsBody?.velocity = CGVectorMake(xVelocity,yVelocity)
            
            //slowing down other circles on contact
            shape.physicsBody!.friction = 0.0
            
            //amount of speed kept after bounce
            shape.physicsBody!.restitution = 1.0
            
            //mass is constant, no matter size of circle
            shape.physicsBody!.mass = 0.5
            
            //gravity effects
            shape.physicsBody?.affectedByGravity = false
            
            //rotation when bouncing off each other
            shape.physicsBody!.allowsRotation = false
            
            //damping of speed from environment
            shape.physicsBody?.linearDamping = 0.1
            shape.physicsBody?.angularDamping = 0.1
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        //stops circles from stopping at edges of screen
        for node in children {
            if node.physicsBody!.velocity.dx < 2.5 {
                let strength = 1.0 * (node.position.x < frame.width / 2 ? 1 : -1)
                node.physicsBody!.velocity.dx += strength
            }
            else if node.physicsBody!.velocity.dy < 2.5 {
                let strength = 1.0 * (node.position.y < frame.height / 2 ? 1 : -1)
                node.physicsBody!.velocity.dy += strength
            }
        }
    }
    
    func toggleAnimation(){
        view!.paused = !view!.paused
    }
}
