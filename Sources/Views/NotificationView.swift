import SwiftUI
import Cocoa

struct NotificationView: View {
    @State private var timeRemaining = 53
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            // Blur effect overlay with color tint
            ZStack {
                VisualEffectView(material: .hudWindow, blendingMode: .behindWindow)
                Color.blue.opacity(0.2)
            }
            .ignoresSafeArea()

            VStack(spacing: 30) {
                // Calendar icon
                Image(systemName: "calendar")
                    .font(.system(size: 60))
                    .foregroundColor(.white.opacity(0.8))

                VStack(spacing: 15) {
                    // Meeting title
                    Text("Board Meeting")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)

                    // Time
                    Text("3:00 PM–4:00 PM")
                        .font(.system(size: 24))
                        .foregroundColor(.white.opacity(0.9))

                    // Countdown
                    Text("The event will start in \(timeRemaining) seconds")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.8))

                    // Location
                    Text("Conference Room")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }

                // Action buttons row
                HStack(spacing: 15) {
                    ActionButton(icon: "phone") {}
                    ActionButton(icon: "video") {}
                    ActionButton(icon: "ellipsis") {}
                }

                // OK button
                Button(action: dismissNotification) {
                    Text("OK")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 120, height: 45)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .keyboardShortcut(.defaultAction)
                .padding(.top, 20)

                // Snooze section
                SnoozeSection()
            }
            .padding(50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            startTimer()
            playNotificationSound()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            Task { @MainActor in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer?.invalidate()
                    timer = nil
                }
            }
        }
    }
    
    private func playNotificationSound() {
        Task { @MainActor in
            SoundManager.shared.playAlertSound(type: .custom)
        }
    }
    
    private func dismissNotification() {
        NSApplication.shared.terminate(nil)
    }
}