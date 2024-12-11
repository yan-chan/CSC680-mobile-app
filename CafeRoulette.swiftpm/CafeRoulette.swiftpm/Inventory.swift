import SwiftUI

// Inventory View
struct Inventory: View {
    @Binding var money: Int // Pass money from MainView
    var inventory: [String: Int] // Inventory passed from MainView
    var unlockedRecipes: [Recipe] // List of unlocked recipes passed from Cafe
    
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
            Text("Coffee Beans: \(inventory["Coffee Beans"] ?? 0)")
            
            Text("Unlocked Recipes:")
                .font(.title2)
                .padding()
            
            // Display unlocked recipes
            ForEach(unlockedRecipes) { recipe in
                Text("\(recipe.emoji) \(recipe.name)")
            }
            
            Spacer()
        }
        .navigationTitle("Inventory")
        .navigationBarTitleDisplayMode(.inline)
    }
}
