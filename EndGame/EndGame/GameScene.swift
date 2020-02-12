//
//  GameScene.swift
//  EndGame
//
//  Created by Henry-chime chibuike on 2/11/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate {
    func restartGame() -> Void
}


class GameScene: SKScene,  SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var possibleEnemies = ["ball", "hammer", "tv"]
    var isGameOver = false
    var gameTimer: Timer?
    
    var sceneDelegate: GameSceneDelegate?
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.30, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
//
//        gameTimer = Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
    }
    
    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        
        if gameTimer?.timeInterval == 2.00 {
            
            print("gotten To 20 seconds")
        }
        
        if enemy.count == 20 {
            score += 100
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        // Called before each frame is rendered
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        }
        
        if isGameOver{
            isGameOver = true
            possibleEnemies.removeAll()
            let alert = UIAlertController(title: "Game Ended", message: "Do You want To Play Again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                _ in
                
                self.sceneDelegate?.restartGame()
            }))
            
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler:  {
                _ in
                
                let endGameAlert = UIAlertController(title: "GAME OVER", message: "Failure You Can't Even Play", preferredStyle: .alert)
                self.view?.window?.rootViewController?.present(endGameAlert, animated: true, completion: nil)
            }))
            
            alert.dismiss(animated: true, completion: nil)
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        player.removeFromParent()
        gameTimer?.invalidate()
        isGameOver = true
    }
    
}
