//
//  GameScene.swift
//  Platformer
//
//  Created by Harmeet on 04/10/2020.
//  Copyright © 2020 MysteryCoder456. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var touching = true
    private var touch: CGPoint!

    private var player: SKNode!
    private var ground: SKNode!
    private var platforms: SKNode!
    
    override func didMove(to view: SKView) {
        
        touch = CGPoint(x: 0, y: 0)
        
        ground = childNode(withName: "ground")
        player = childNode(withName: "player")
        platforms = childNode(withName: "platforms")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = true
        let jump = 400
        touch = touches.first?.location(in: self)
        
        if touch.y > 0 {
            if isPlayerOnGround() {
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: jump))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { touching = false }
    
    func isPlayerOnGround() -> Bool {
        if (player.physicsBody?.allContactedBodies().contains(ground.physicsBody!))! {
            return true
        }
        
        for platform in platforms.children {
            if (player.physicsBody?.allContactedBodies().contains(platform.physicsBody!))! {
                return true
            }
        }
        
        return false
    }
    
    override func update(_ currentTime: TimeInterval) {
        print(touching)
        
        if touching {
            let speed = 800
            
            if (isPlayerOnGround()) {
                if touch.y <= 0 {
                    if touch.x < 0 {
                        player.physicsBody?.applyForce(CGVector(dx: -speed, dy: 0))
                        print("left!")
                    }
                    
                    if touch.x > 0 {
                        player.physicsBody?.applyForce(CGVector(dx: speed, dy: 0))
                        print("right!")
                    }
                }
            }
        }
    }
}
