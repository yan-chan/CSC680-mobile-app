import SwiftUI

// Inventory, Show current money
struct Inventory: View {
    @Binding var money: Int // Pass money from MainView
    var inventory: [String: Int] // Inventory passed from MainView
    
    var body: some View {
        VStack {
            Text("Your Inventory")
                .font(.largeTitle)
                .padding()
            
            Text("Current Money: \(money)")
                .font(.title)
                .padding()
            
            Text("Flour: \(inventory["Flour"] ?? 0)")
            Text("Sugar: \(inventory["Sugar"] ?? 0)")
            Text("Water: \(inventory["Water"] ?? 0)")
            Text("Cakes: \(inventory["Cake"] ?? 0)")
            
            Spacer()
        }
        .navigationTitle("Inventory")
        .navigationBarTitleDisplayMode(.inline)
    }
}
