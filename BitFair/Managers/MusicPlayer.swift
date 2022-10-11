//
//  MusicPlayer.swift
//  BitFair
//
//  Created by Tanya Koldunova on 26.09.2022.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer?
var pressedPlayer: AVAudioPlayer?

func playBackgroundMusic() {
    if !UserDefaultsValues.musicOff {
    guard let url = Bundle.main.url(forResource: "backgroundSound",
                                    withExtension: "wav") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        guard let player = player else { return }
        player.volume = 0.5
        player.numberOfLoops = -1
        player.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}
func pressedButtonSound() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "pressSound",
                                    withExtension: "wav") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        pressedPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        guard let pressedPlayer = pressedPlayer else { return }
        pressedPlayer.volume = 0.75
        pressedPlayer.numberOfLoops = 0
        pressedPlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func stopPlaying() {
    player?.stop()
}
