//
//  UserDefaultsValues.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import Foundation


public struct UserDefaultsValues {
    enum Keys {
        static let cointsCounKey = "com.cointsCount.key"
        static let charactersKeys = "com.charachterKeys.key"
        static let playingCharacterKey = "com.playingCharacterKey.key"
        static let levelInfoKey = "com.levelInfoKey"
        static let soundOffKey = "com.soundOff.key"
    }
    
    static var cointsCount: Float {
        get {
            return UserDefaults.standard.float(forKey: Keys.cointsCounKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.cointsCounKey)
        }
    }
    
    static var availableCharactersKeys: [String] {
        get {
            UserDefaults.standard.object(forKey: Keys.charactersKeys) as? [String] ?? [StoreModel.simpleCharacter.rawValue]
        } set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.charactersKeys)
        }
    }
    
    static var currentCharactesKey: String {
        get {
            UserDefaults.standard.string(forKey: Keys.playingCharacterKey) ?? StoreModel.simpleCharacter.rawValue
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.playingCharacterKey)
        }
    }
    
    static var availableCharacters: [StoreModel] {
        get {
            var availableCharacters = [StoreModel]()
            for key in UserDefaultsValues.availableCharactersKeys {
                if let character = StoreModel(rawValue: key) {
                availableCharacters.append(character)
                }
            }
            return availableCharacters
        } set {
            var characterKeys = [String]()
            for item in newValue {
                characterKeys.append(item.rawValue)
            }
            if characterKeys.count == 0 {
                characterKeys.append(StoreModel.simpleCharacter.rawValue)
            }
            UserDefaultsValues.availableCharactersKeys = characterKeys
        }
    }
    
    static var levelInfo: [String:Int] {
        get {
            UserDefaults.standard.object(forKey: Keys.levelInfoKey) as? [String:Int] ?? [String:Int]()
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.levelInfoKey)
        }
    }
    
    static var playingCharacter: StoreModel {
        get {
            let player = StoreModel(rawValue: UserDefaultsValues.currentCharactesKey)!
            return player
        } set {
            UserDefaultsValues.currentCharactesKey = newValue.rawValue
        }
    }
    
    static var soundOff: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.soundOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.soundOffKey)
        }
    }
 }
