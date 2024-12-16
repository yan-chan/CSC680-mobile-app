
import SwiftUI

// Model for a recipe
struct Recipe: Identifiable {
    var id = UUID() 
    var name: String 
    var emoji: String 
    var ingredients: [String: Int] 
    var unlocked: Bool = false 
}

