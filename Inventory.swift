import SwiftUI

// Inventory,Show current money
struct Inventory: View {
    @Binding var money: Int // Pass money from MainView
    
    var body: some View {
        VStack {
            Text("Your Inventory")
                .font(.largeTitle)
                .padding()
            
            Text("Current Money: \(money)")
                .font(.title)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Inventory")
        .navigationBarTitleDisplayMode(.inline)
    }
}


