import SwiftUI
import Cocoa

@main
struct KibishiApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            NotificationView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .defaultSize(width: NSScreen.main?.frame.width ?? 1920, height: NSScreen.main?.frame.height ?? 1080)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Replace the default window with our custom window
        if let window = NSApplication.shared.windows.first {
            let customWindow = CustomWindow(
                contentRect: window.frame,
                styleMask: window.styleMask,
                backing: .buffered,
                defer: false
            )
            
            customWindow.contentView = window.contentView
            
            // Apply all the full-screen overlay settings to the custom window
            WindowManager.setupFullScreenOverlay(for: customWindow)
            
            window.close()
        }
    }
}