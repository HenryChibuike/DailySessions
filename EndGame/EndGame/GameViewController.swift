//
//  GameViewController.swift
//  EndGame
//
//  Created by Henry-chime chibuike on 2/11/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene: GameScene!
    var gameView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildScene()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func buildScene() {
        self.scene = nil
        gameView = nil
        gameView  = self.view as! SKView
        self.scene = SKScene(fileNamed: "GameScene") as? GameScene
//        self.scene.isGameOver = false
        // Set the scale mode to scale to fit the window
        self.scene.scaleMode = .aspectFill
        self.scene.sceneDelegate = self
        // Present the scene
        gameView.presentScene(self.scene)
        
        gameView.ignoresSiblingOrder = true
        
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        
    }
    
}

extension GameViewController: GameSceneDelegate {
    func restartGame() {
//        self.scene.removeFromParent()
        self.buildScene()
    }
}
