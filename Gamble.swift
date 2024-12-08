import SwiftUI

// Slot machine gameplay
struct Gamble: View {
    @Binding var money: Int // Pass money from MainView
    @State private var slot1 = "🍰"
    @State private var slot2 = "🍨"
    @State private var slot3 = "☕️"
    
    var body: some View {
        VStack {
            Spacer()
            
            // Slot Machine Display
            HStack {
                Text(slot1)
                    .font(.system(size: 100))
                Text(slot2)
                    .font(.system(size: 100))
                Text(slot3)
                    .font(.system(size: 100))
            }
            
            Spacer()
            
            // Spin Button
            Button(action: {
                if money >= 10 {
                    // Spend 10 money to spin
                    money -= 10
                    spinSlots()
                }
            }) {
                Text("Spin - 10 Money")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .background(Color(hex: "#E0BBE4")) 
        .navigationTitle("Slot Machine")
        .navigationBarItems(trailing: Text("Money: \(money)"))
    }
    
    // Spin the Slots
    func spinSlots() {
        // Simulate slot machine spin with a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.slot1 = self.randomSymbol()
            self.slot2 = self.randomSymbol()
            self.slot3 = self.randomSymbol()
            
            // If all symbols match, win money
            if self.slot1 == self.slot2 && self.slot2 == self.slot3 {
                money += 500 // Winning
            }
        }
    }
    
    // Random Symbol Picker
    func randomSymbol() -> String {
        let symbols = ["🍰", "🍨", "☕️", "🧁", "🧋"]
        return symbols.randomElement() ?? "🍰"
    }
}

// Color extension to handle hex codes
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        if hexSanitized.count == 6 {
            var rgb: UInt64 = 0
            Scanner(string: hexSanitized).scanHexInt64(&rgb)
            self.init(
                .sRGB, 
                red: Double((rgb & 0xFF0000) >> 16) / 255.0,
                green: Double((rgb & 0x00FF00) >> 8) / 255.0,
                blue: Double(rgb & 0x0000FF) / 255.0,
                opacity: 1.0
            )
        } else {
            self.init(.white)
        }
    }
}

