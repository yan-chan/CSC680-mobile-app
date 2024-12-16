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
            
            // Show inventory counts
            VStack(alignment: .leading) {
                Text("Inventory:")
                Text("Flour: \(inventory["Flour"] ?? 0)")
                Text("Sugar: \(inventory["Sugar"] ?? 0)")
                Text("Water: \(inventory["Water"] ?? 0)")
                Text("Coffee Beans: \(inventory["Coffee Beans"] ?? 0)")
                Text("Milk: \(inventory["Milk"] ?? 0)")
                Text("Butter: \(inventory["Butter"] ?? 0)")
                Text("Eggs: \(inventory["Eggs"] ?? 0)")
                Text("Almond Flour: \(inventory["Almond Flour"] ?? 0)")
                Text("Yeast: \(inventory["Yeast"] ?? 0)")
                Text("Fruit: \(inventory["Fruit"] ?? 0)")
                Text("Ice: \(inventory["Ice"] ?? 0)")
                Text("Yogurt: \(inventory["Yogurt"] ?? 0)")
            }
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
