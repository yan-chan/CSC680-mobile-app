import SwiftUI

// Gacha View: Allows the user to unlock a new recipe by spending 50 money
struct Gacha: View {
    @Binding var money: Int
    @Binding var avatar: Avatar  // Pass avatar to track unlocked recipes
    @State private var popUpMessage: String? = nil  // Variable to store pop-up message
    @State private var showPopUp: Bool = false  // To control the pop-up visibility
    
    var body: some View {
        VStack {
            Text("Gacha Game")
                .font(.largeTitle)
                .padding()
            
            Text("Current Money: \(money)")
                .font(.title)
                .padding()
            
            // Button to unlock a new recipe for 50 money
            Button(action: {
                unlockRecipe()
            }) {
                Text("Unlock New Recipe (Cost 50 Money)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hexString: "#7C6E8D"))
                    .cornerRadius(10)
            }
            .padding()
            .disabled(money < 50) // Disable the button if the player doesn't have enough money
            
            // Feedback text based on success or failure of the Gacha
            if money < 50 {
                Text("Not enough money!")
                    .foregroundColor(.red)
                    .font(.title)
                    .padding()
            }
            
            Spacer()
        }
        .navigationTitle("Gacha")
        .alert(isPresented: $showPopUp) {
            Alert(
                title: Text("Recipe Unlocked!"),
                message: Text(popUpMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    // Function to unlock a new recipe
    func unlockRecipe() {
        if money >= 50 {
            money -= 50 // Deduct the money for unlocking
            
            // Define possible recipes to unlock
            let recipeOptions: [Recipe] = [
                Recipe(name: "Coffee", emoji: "☕", ingredients: ["Coffee Beans": 1, "Water": 1]),
                Recipe(name: "Cake", emoji: "🍰", ingredients: ["Flour": 1, "Sugar": 1, "Water": 1])
            ]
            
            // Set a 10% chance to unlock either Coffee or Cake recipe
            let chanceToUnlock = Int.random(in: 1...10) // Random number between 1 and 10
            
            if chanceToUnlock <= 1 { // 10% chance (1 in 10)
                // Randomly choose one of the recipe options
                let randomRecipe = recipeOptions.randomElement()!
                
                // Check if the recipe is already unlocked
                if avatar.unlockedRecipes.contains(where: { $0.name == randomRecipe.name }) {
                    // 25% refund
                    let refundAmount = 50 * 0.25 // 25% of 50 money = 12.5
                    money += Int(refundAmount) // Add the refund money back
                    popUpMessage = "\(randomRecipe.name) is already unlocked! You've received 25 money."
                } else {
                    // Add the unlocked recipe to avatar's unlockedRecipes if it's not already unlocked
                    avatar.unlockedRecipes.append(randomRecipe)
                    popUpMessage = "\(randomRecipe.name) recipe unlocked!"
                }
                
                // Show the pop-up message
                showPopUp = true
            } else {
                // Optionally show a failure message or handle other cases
                print("Better luck next time!")
            }
        }
    }
}
