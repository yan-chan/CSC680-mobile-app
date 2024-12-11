import SwiftUI

// Model for a recipe
struct Recipe: Identifiable {
    var id = UUID()  // Unique identifier for each recipe
    var name: String  // Name of the recipe (e.g., Cake, Coffee)
    var emoji: String  // Emoji representation of the recipe (e.g., 🍰, ☕)
    var ingredients: [String: Int]  // Ingredients needed to make the recipe
    var unlocked: Bool = false  // Whether the recipe is unlocked
}
