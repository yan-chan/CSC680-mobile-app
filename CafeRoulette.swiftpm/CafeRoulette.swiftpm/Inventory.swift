import SwiftUI

// Inventory View
struct Inventory: View {
    @Binding var money: Int 
    var inventory: [String: Int]
    var unlockedRecipes: [Recipe] 
    
    var availableIngredients: [String] 
    
    var body: some View {
        VStack {
            Text("Your Inventory")
                .font(.largeTitle)
                .padding()
            
            Text("Current Money: \(money)")
                .font(.title)
                .padding()
            
            
            // Show ingredients that can drop
            VStack(alignment: .leading) {
                Text("Ingredients that can drop:")
                    .font(.title2)
                    .padding(.top)
                
                // Dynamically show available ingredients
                ForEach(availableIngredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
            }
            .padding()
            
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
