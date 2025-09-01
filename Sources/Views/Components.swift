import SwiftUI
import Cocoa

struct ActionButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.white.opacity(0.7))
                .frame(width: 50, height: 50)
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct SnoozeSection: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Snooze")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.8))

            HStack(spacing: 15) {
                Button("1 minute") {}
                    .buttonStyle(SnoozeButtonStyle())

                Button("5 minutes") {}
                    .buttonStyle(SnoozeButtonStyle())

                Button("Until Event") {}
                    .buttonStyle(SnoozeButtonStyle())

                Button(action: {}) {
                    Image(systemName: "gear")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.7))
                }
            }

            Button("⚙ Customize this Event") {

            }
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.7))
            .padding(.top, 10)
        }
        .padding(.top, 30)
    }
}

struct SnoozeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.8))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct KeyEventHandling: NSViewRepresentable {
    let onEnter: () -> Void
    
    func makeNSView(context: Context) -> NSView {
        let view = KeyHandlerView()
        view.onEnter = onEnter
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        if let view = nsView as? KeyHandlerView {
            view.onEnter = onEnter
        }
    }
}

class KeyHandlerView: NSView {
    var onEnter: (() -> Void)?
    
    override var acceptsFirstResponder: Bool { true }
    override var canBecomeKeyView: Bool { true }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        // Aggressively capture focus
        DispatchQueue.main.async {
            self.window?.makeFirstResponder(self)
        }
        
        // Try again after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.window?.makeFirstResponder(self)
        }
    }
    
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        
        // Try to become first responder when added to view hierarchy
        DispatchQueue.main.async {
            self.window?.makeFirstResponder(self)
        }
    }
    
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 36 || event.keyCode == 76 { // Return or Enter
            onEnter?()
        } else {
            super.keyDown(with: event)
        }
    }
    
    // Handle all key events, not just keyDown
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        if event.keyCode == 36 || event.keyCode == 76 {
            onEnter?()
            return true
        }
        return super.performKeyEquivalent(with: event)
    }
}