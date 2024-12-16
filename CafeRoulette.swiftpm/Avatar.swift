
import SwiftUI

// Avatar model to hold player data, inventory, and unlocked recipes
struct Avatar {
    var position: CGPoint
    var inventory: [String: Int] = ["Flour": 0, "Sugar": 0, "Water": 0, "Cake": 0, "Coffee Beans": 0]
    var unlockedRecipes: [Recipe] = []  // Track unlocked recipes
}
