//
//  GameSceneManager+Contact.swift
//  BitFair
//
//  Created by Tanya Koldunova on 26.09.2022.
//

import SpriteKit

extension GameSceneManager : SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == PhysicsBitMask.coint.bitMask | PhysicsBitMask.player.bitMask {
            handleContactBtwPlayerCoins(contact)
        } else if collision == PhysicsBitMask.player.bitMask | PhysicsBitMask.enemy.bitMask {
            handleContactBtwPlayerEnemy(contact)
        } else if collision == PhysicsBitMask.enemy.bitMask | PhysicsBitMask.weapon.bitMask {
            handleContactBtwEnemyWeapon(contact)
        } else if collision == PhysicsBitMask.enemyHead.bitMask | PhysicsBitMask.player.bitMask {
            handleContactBtwEnemyHeadPlayer(contact)
        } else if collision == PhysicsBitMask.player.bitMask | PhysicsBitMask.finish.bitMask {
            handleContactBtwPlayerFinish(contact)
        } else if collision == PhysicsBitMask.bonusGround.bitMask | PhysicsBitMask.player.bitMask {
            handleContactBtwPlayerBonusGround(contact)
        } else if collision == PhysicsBitMask.enemyWeapon.bitMask | PhysicsBitMask.player.bitMask {
            handleContactBtwHeroWeapon(contact)
        } else if collision == PhysicsBitMask.player.bitMask | PhysicsBitMask.ground.bitMask {
            handleContactBtwPlayerGround(contact)
        } else if collision == PhysicsBitMask.player.bitMask | PhysicsBitMask.starts.bitMask {
            handleContactBtwPlayerStars(contact)
        } else if collision == PhysicsBitMask.weapon.bitMask | PhysicsBitMask.ground.bitMask ||  collision == PhysicsBitMask.enemyWeapon.bitMask | PhysicsBitMask.ground.bitMask {
            handleContactBtwWeaponGround(contact)
        }
    }
    
    
    private func handleContactBtwPlayerCoins(_ contact: SKPhysicsContact) {
        let playCointsSound = SKAction.playSoundFileNamed("getCoinsSound.wav", waitForCompletion: false)
            if contact.bodyA.categoryBitMask == PhysicsBitMask.coint.bitMask {
                contact.bodyA.node?.removeFromParent()
                cointsCount += 1
            } else {
                contact.bodyB.node?.removeFromParent()
                cointsCount += 1
            }
            if !UserDefaultsValues.soundOff {
                self.scene?.run(playCointsSound)
            }
    }
    
    private func handleContactBtwPlayerEnemy(_ contact: SKPhysicsContact) {
        var player: SKNode?
        var enemy: SKNode?
        if contact.bodyA.categoryBitMask == PhysicsBitMask.enemy.bitMask {
            enemy = contact.bodyA.node
            player = contact.bodyB.node
        } else {
            player = contact.bodyA.node
            enemy = contact.bodyB.node
        }
        if let enemy = enemy as? EnemyProtocol, let player = player as? CharacterProtocol {
                let painAction = SKAction.playSoundFileNamed("painSound.mp3", waitForCompletion: false)
                if !UserDefaultsValues.soundOff {
                    self.scene?.run(painAction)
                }
                player.setUpHit()
                hpDelegate?.receiveMessage(with: 1)
                contactInterval = Date().timeIntervalSince1970
            }
    }
    
    private func handleContactBtwEnemyHeadPlayer(_ contact: SKPhysicsContact) {
        var player: SKNode?
        var enemyHead: SKNode?
        if contact.bodyA.categoryBitMask == PhysicsBitMask.enemyHead.bitMask {
            enemyHead = contact.bodyA.node
            player = contact.bodyB.node
        } else {
            player = contact.bodyA.node
            enemyHead = contact.bodyB.node
        }
        
        if let enemy = enemyHead?.parent as? EnemyProtocol {
                let hitAction = SKAction.playSoundFileNamed("hitSound.wav", waitForCompletion: false)
                if !UserDefaultsValues.soundOff {
                    self.scene?.run(hitAction)
                }
                enemy.hp -= enemy.hp
                enemy.setUpKillAction()
                enemy.removeFromParent()
                switch enemy.reward {
                case .coins(let coins):
                    cointsCount += coins
                case .stars(let stars):
                    starsCount += stars
                    starsDelegate?.receiveMessage(with: stars)
                case .none:
                    return
                case .some(.no):
                    return
                }
        }
        
    }
    
    private func handleContactBtwEnemyWeapon(_ contact: SKPhysicsContact) {
        let painAction = SKAction.playSoundFileNamed("painSound.mp3", waitForCompletion: false)
        if !UserDefaultsValues.soundOff {
        self.scene?.run(painAction)
        }
        var enemy: SKNode?
        var weapon: SKNode?
        if contact.bodyA.categoryBitMask == PhysicsBitMask.enemy.bitMask {
            enemy = contact.bodyA.node
            weapon = contact.bodyB.node
        } else {
            weapon = contact.bodyA.node
            enemy = contact.bodyB.node
        }
        if let enemy = enemy as? EnemyProtocol, let weapon = weapon as? WeaponeProtocol {
            enemy.hp -= weapon.damage
            if enemy.hp <= 0 {
                enemy.removeFromParent()
            }
        }
        weapon?.removeFromParent()
    }
    
    private func handleContactBtwPlayerFinish(_ contatc: SKPhysicsContact) {
        if !touchedOnce {
            levelManager.completeCurrentLevel = true
            touchedOnce = true
            contactManager?.handleGameResult()
        }
    }
    
    private func handleContactBtwPlayerBonusGround(_ contact: SKPhysicsContact) {
        guard let scene = scene else {return}
        var player: SKNode?
        var bonusGround: SKNode?
        if contact.bodyA.categoryBitMask == PhysicsBitMask.player.bitMask {
            player = contact.bodyA.node
            bonusGround = contact.bodyB.node
        } else {
            bonusGround = contact.bodyA.node
            player = contact.bodyB.node
        }
        if let player = player as? CharacterProtocol, let bonusGround = bonusGround as? SKSpriteNode {
            
            if let ground = bonusGround.parent as? BonusGroundNode {
                let neededPos = scene.size.height/2 - ground.position.y + ground.size.height/2
                let range = -neededPos - 1 ... -neededPos + 1
                if range.contains(contact.contactPoint.y) {
                    ground.handleContact(name: bonusGround.name ?? "")
                }
            }
        }
    }
    
    private func handleContactBtwHeroWeapon(_ contact: SKPhysicsContact) {
        let painAction = SKAction.playSoundFileNamed("painSound.mp3", waitForCompletion: false)
        if !UserDefaultsValues.soundOff {
        self.scene?.run(painAction)
        }
        var player: SKNode?
        var weapon: SKNode?
        if contact.bodyA.categoryBitMask == PhysicsBitMask.player.bitMask {
            player = contact.bodyA.node
            weapon = contact.bodyB.node
        } else {
            weapon = contact.bodyA.node
            player = contact.bodyB.node
        }
        if let player = player as? CharacterProtocol, let weapon = weapon as? WeaponeProtocol {
            player.setUpHit()
            hpDelegate?.receiveMessage(with: weapon.damage)
            weapon.removeFromParent()
        }
    }
    
    private func handleContactBtwPlayerGround(_ contact: SKPhysicsContact) {
        guard let scene = scene else {return}
        var player: SKNode?
        var ground: SKNode?
        if contact.bodyA.categoryBitMask == PhysicsBitMask.player.bitMask {
            player = contact.bodyA.node
            ground = contact.bodyB.node
        } else {
            ground = contact.bodyA.node
            player = contact.bodyB.node
        }
        if let player = player as? CharacterProtocol, let ground = ground as? TipGround {
            if ground.state == .leftRight || ground.state == .upDown {
                player.move(toParent: ground)
            } else {
                player.move(toParent: scene)
            }
        } else {
            player?.move(toParent: scene)
        }
    }
    
    private func handleContactBtwPlayerStars(_ contact: SKPhysicsContact) {
        guard let scene = scene else {return}
        let starCollectAction = SKAction.playSoundFileNamed("starCollect.mp3", waitForCompletion: false)
            if !UserDefaultsValues.soundOff {
                self.scene?.run(starCollectAction)
            }
            if contact.bodyA.categoryBitMask == PhysicsBitMask.starts.bitMask {
                contact.bodyA.node?.removeFromParent()
                starsCount += 1
            } else {
                contact.bodyB.node?.removeFromParent()
                starsCount += 1
            }
            starsDelegate?.receiveMessage(with: 1)
    }
    
    private func handleContactBtwWeaponGround(_ contact: SKPhysicsContact) {
        guard let scene = scene else {return}
        if contact.bodyA.categoryBitMask == PhysicsBitMask.ground.bitMask {
            contact.bodyB.node?.removeFromParent()
        } else {
            contact.bodyA.node?.removeFromParent()
        }
    }
    
    
    
}

