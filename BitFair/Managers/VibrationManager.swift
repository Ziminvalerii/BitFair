//
//  VibrationManager.swift
//  BitFair
//
//  Created by Tanya Koldunova on 11.10.2022.
//

import Foundation
import AudioToolbox


func playVibration() {
    if !UserDefaultsValues.vibrationOff {
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
