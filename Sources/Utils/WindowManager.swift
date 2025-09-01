import Cocoa

class CustomWindow: NSWindow {
    var onEnterPressed: (() -> Void)?
    
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 36 || event.keyCode == 76 { // Return or Enter
            print("Enter detected in custom window!")
            onEnterPressed?()
        } else {
            super.keyDown(with: event)
        }
    }
    
    override var canBecomeKey: Bool { return true }
    override var canBecomeMain: Bool { return true }
    override var acceptsFirstResponder: Bool { return true }
}

class WindowManager {
    @MainActor
    static func setupFullScreenOverlay(for window: NSWindow) {
        // Remove window controls (close, minimize, maximize buttons)
        window.styleMask.remove(.closable)
        window.styleMask.remove(.miniaturizable)
        window.styleMask.remove(.resizable)
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true

        // Set window level to appear above all other windows including menu bar
        window.level = .screenSaver

        // Make window cover ENTIRE screen including menu bar
        if let screen = NSScreen.main {
            window.setFrame(screen.frame, display: true, animate: false)
        }

        // Remove title bar completely
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden

        // Make window background transparent
        window.backgroundColor = NSColor.clear
        window.isOpaque = false

        // Bring to front and focus
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        // Force keyboard focus and accept events
        window.acceptsMouseMovedEvents = true
        
        // Ensure window becomes key window and set up key handling
        if let customWindow = window as? CustomWindow {
            customWindow.onEnterPressed = {
                NSApplication.shared.terminate(nil)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            window.makeKey()
            window.makeFirstResponder(window)
        }
    }
}