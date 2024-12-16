import SwiftUI

// Slot machine gameplay
struct Gamble: View {
    @Binding var money: Int // Pass money from MainView
    @State private var slot1 = "🍰"
    @State private var slot2 = "🍨"
    @State private var slot3 = "☕️"
    @State private var isSpinning = false
    @State private var winMessage = ""
    
    var body: some View {
        VStack {
            // Title and Money Display
            HStack {
                Spacer()
                Text("Money: \(money)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
            .padding(.top, 40)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue.opacity(0.4)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(30, antialiased: true)
            
            Spacer()
            
            // Slot Machine Display with a Background Container
            VStack {
                // Slot machine container
                HStack {
                    SlotSymbolView(symbol: slot1)
                    SlotSymbolView(symbol: slot2)
                    SlotSymbolView(symbol: slot3)
                }
                .padding()
                .background(Color.white.opacity(0.8)) // Slot machine background
                .cornerRadius(20)
                .shadow(radius: 12)
            }
            .padding()
            
            // Show win message
            if !winMessage.isEmpty {
                Text(winMessage)
                    .font(.title)
                    .foregroundColor(winMessage.contains("Win") ? .green : .red)
                    .padding(.top, 20)
                    .transition(.opacity)
                    .animation(.easeInOut, value: winMessage)
            }
            
            Spacer()
            
            // Spin Button with Light Blue Theme
            Button(action: {
                if money >= 10 {
                    // Spend 10 money to spin
                    money -= 10
                    isSpinning = true
                    spinSlots()
                }
            }) {
                Text("Spin - 10 Money")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .top, endPoint: .bottom)) // Gradient background in blue and cyan
                    .cornerRadius(30) // Rounded corners
                    .shadow(radius: 10) // Shadow for a soft, elevated look
                    .scaleEffect(isSpinning ? 0.95 : 1.0) // Slight scale effect when pressed
                    .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3), value: isSpinning) // Button press animation
            }
            .padding()
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 40)
            
        }
        .background(Color("E0F7FA")) // Light blue background color (hex for pastel blue)
        .edgesIgnoringSafeArea(.all) // Ensure background fills the whole screen
        .onChange(of: isSpinning) { newValue in
            if !newValue {
                // Reset win message after animation finishes
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    winMessage = ""
                }
            }
        }
    }
    
    // Slot Symbol View to wrap each slot in a styled box
    struct SlotSymbolView: View {
        var symbol: String
        
        var body: some View {
            Text(symbol)
                .font(.system(size: 100))
                .frame(width: 100, height: 100)
                .background(Color.white.opacity(0.7))
                .cornerRadius(15)
                .shadow(radius: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.blue.opacity(0.5), lineWidth: 2)
                )
        }
    }
    
    // Spin the Slots
    func spinSlots() {
        // Simulate slot machine spin with a delay
        withAnimation(.easeInOut(duration: 1.5).repeatCount(3, autoreverses: true)) {
            self.slot1 = self.randomSymbol()
            self.slot2 = self.randomSymbol()
            self.slot3 = self.randomSymbol()
        }
        
        // Wait for animation and check for win
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isSpinning = false
            self.slot1 = self.randomSymbol()
            self.slot2 = self.randomSymbol()
            self.slot3 = self.randomSymbol()
            
            // Check if all symbols match (win condition)
            if self.slot1 == self.slot2 && self.slot2 == self.slot3 {
                money += 50 // Winning
                winMessage = "You Win 50 Money!"
            } else {
                winMessage = "Try Again!"
            }
        }
    }
    
    // Random Symbol Picker
    func randomSymbol() -> String {
        let symbols = ["🍰", "🍨", "☕️", "🧁", "🧋"]
        return symbols.randomElement() ?? "🍰"
    }
}
