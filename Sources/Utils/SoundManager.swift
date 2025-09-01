import AVFoundation
import Cocoa
import Foundation

@MainActor
class SoundManager {
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    /// Play system notification sound
    func playNotificationSound() {
        NSSound.beep()
    }
    
    /// Play specific system sound
    func playSystemSound(_ soundName: NSSound.Name) {
        guard let sound = NSSound(named: soundName) else {
            // Fallback to beep if sound not found
            NSSound.beep()
            return
        }
        sound.play()
    }
    
    /// Play custom MP3 file
    func playCustomSound(filename: String) {
        guard let resourcePath = Bundle.module.path(forResource: "Resources/\(filename)", ofType: nil),
              let url = URL(string: "file://" + resourcePath) else {
            print("Could not find sound file: \(filename)")
            NSSound.beep() // Fallback to system beep
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error)")
            NSSound.beep() // Fallback to system beep
        }
    }
    
    /// Play custom notification sound with different options
    func playAlertSound(type: AlertSoundType = .notification) {
        switch type {
        case .notification:
            playSystemSound(.init("Blow"))
        case .urgent:
            playSystemSound(.init("Sosumi"))
        case .gentle:
            playSystemSound(.init("Tink"))
        case .system:
            NSSound.beep()
        case .custom:
            playCustomSound(filename: "hey_listen.mp3")
        }
    }
}

enum AlertSoundType {
    case notification
    case urgent
    case gentle
    case system
    case custom
}