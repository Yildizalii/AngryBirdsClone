//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Ali on 22.02.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird2 = SKSpriteNode()
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var score = 0
    var scoreLabel = SKLabelNode()
    var gameStart = false
    var originalPosition : CGPoint?
    
    enum ColliderType : UInt32 {
        case bird = 1
        case box = 2
        case ground = 4
        case tree = 8
    }
    
    override func didMove(to view: SKView) {
        
        
         // Bird
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self

        bird = childNode(withName: "bird") as! SKSpriteNode
        let birdTexture = SKTexture(imageNamed: "bird")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 7)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        originalPosition = bird.position
        bird.physicsBody?.contactTestBitMask = ColliderType.bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.box.rawValue
        //Box1
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 5 , height: boxTexture.size().height / 5 )
        
            

            box1 = childNode(withName: "box1") as! SKSpriteNode
            box1.physicsBody = SKPhysicsBody(rectangleOf: size)
            box1.physicsBody?.isDynamic = true
            box1.physicsBody?.affectedByGravity = true
            box1.physicsBody?.allowsRotation = true
            box1.physicsBody?.mass = 0.4
            box1.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
            
            box2 = childNode(withName: "box2") as! SKSpriteNode
            box2.physicsBody = SKPhysicsBody(rectangleOf: size)
            box2.physicsBody?.isDynamic = true
            box2.physicsBody?.affectedByGravity = true
            box2.physicsBody?.allowsRotation = true
            box2.physicsBody?.mass = 0.4
            
            box2.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
            box3 = childNode(withName: "box3") as! SKSpriteNode
            box3.physicsBody = SKPhysicsBody(rectangleOf: size)
            box3.physicsBody?.isDynamic = true
            box3.physicsBody?.affectedByGravity = true
            box3.physicsBody?.allowsRotation = true
            box3.physicsBody?.mass = 0.4
            box3.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
            
            box4 = childNode(withName: "box4") as! SKSpriteNode
            box4.physicsBody = SKPhysicsBody(rectangleOf: size)
            box4.physicsBody?.isDynamic = true
            box4.physicsBody?.affectedByGravity = true
            box4.physicsBody?.allowsRotation = true
            box4.physicsBody?.mass = 0.4
            box4.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
            
        
            box5 = childNode(withName: "box5") as! SKSpriteNode
            box5.physicsBody = SKPhysicsBody(rectangleOf: size)
            box5.physicsBody?.isDynamic = true
            box5.physicsBody?.affectedByGravity = true
            box5.physicsBody?.allowsRotation = true
            box5.physicsBody?.mass = 0.4
            box5.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text =  "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4 )
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.bird.rawValue || contact.bodyB .collisionBitMask == ColliderType.bird.rawValue {
            score += 1
            scoreLabel.text = String(score)
        }
    }
    func touchDown(atPoint pos : CGPoint) {
    }
    func touchMoved(toPoint pos : CGPoint) {
    }
    func touchUp(atPoint pos : CGPoint) {
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStart == false {
            
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNode = nodes(at: touchLocation)
                
                if touchNode.isEmpty == false {
                    for node in touchNode {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStart == false {
        
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNode = nodes(at: touchLocation)
                
                if touchNode.isEmpty == false {
                    for node in touchNode {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStart == false {
            
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNode = nodes(at: touchLocation)
                
                if touchNode.isEmpty == false {
                    for node in touchNode {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                              let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                gameStart = true
                            }
                            
                        }
                    }
                }
            }
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if let birdPHysicsBody = bird.physicsBody {
            if birdPHysicsBody.velocity.dx <= 2 && birdPHysicsBody.velocity.dy <= 2 && birdPHysicsBody.angularVelocity <= 2 && gameStart == true {
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                gameStart = false
                score = 0
                scoreLabel.text = String(score)
            
            }
        }
    }

}
