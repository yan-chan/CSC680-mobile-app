import SwiftUI

struct Gacha: View {
    @Binding var money: Int
    @Binding var avatar: Avatar  
    @State private var popUpMessage: String? = nil  
    @State private var showPopUp: Bool = false 
    @State private var buttonScale: CGFloat = 1.0 
    @State private var showAnimation: Bool = false
    @State private var animationType: AnimationType = .none
    @State private var animationOpacity: Double = 1.0 
    
    enum AnimationType {
        case win, lose, none
    }
    
    var body: some View {
        ZStack {
            // Background gradient with soft pink tones
            LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.white.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Gacha Game")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.pink)
                    .padding()
                    .shadow(radius: 10)
                
                Text("Current Money: \(money)")
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                    .foregroundColor(.pink)
                    .padding(.top, 10)
                
                Spacer()
                
                // Button to unlock a new recipe for 50 money
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        buttonScale = 1.1 // Scale effect on button press
                    }
                    unlockRecipe()
                }) {
                    Text("Unlock New Recipe (Cost 50 Money)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hexString: "#F7A6C1"))
                        .cornerRadius(12)
                        .shadow(color: .pink.opacity(0.5), radius: 10, x: 0, y: 10)
                        .scaleEffect(buttonScale)
                        .onChange(of: buttonScale) { newValue in
                            if newValue == 1.1 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    buttonScale = 1.0 // Reset button scale
                                }
                            }
                        }
                }
                .padding(.horizontal, 30)
                .disabled(money < 50) // Disable the button if the player doesn't have enough money
                
                // Feedback text based on success or failure of the Gacha
                if money < 50 {
                    Text("Not enough money!")
                        .foregroundColor(.red)
                        .font(.title3)
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showPopUp) {
                Alert(
                    title: Text("Recipe Unlocked!"),
                    message: Text(popUpMessage ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            // Animation in the center (higher up on the screen)
            if showAnimation {
                VStack {
                    if animationType == .win {
                        // Win animation (green checkmark)
                        Text("✅")
                            .font(.system(size: 100))
                            .foregroundColor(.green)
                            .scaleEffect(showAnimation ? 1.5 : 1)
                            .opacity(animationOpacity)  // Bind opacity for fading
                            .onAppear {
                                // Reset opacity to full at the beginning
                                animationOpacity = 1.0
                                
                                // Fade out after 1 second
                                withAnimation(.easeOut(duration: 1).delay(1)) {
                                    animationOpacity = 0.0
                                }
                            }
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: showAnimation)
                    } else if animationType == .lose {
                        // Lose animation (red cross)
                        Text("❌")
                            .font(.system(size: 100))
                            .foregroundColor(.red)
                            .scaleEffect(showAnimation ? 1.5 : 1)
                            .opacity(animationOpacity)  // Bind opacity for fading
                            .onAppear {
                                // Reset opacity to full at the beginning
                                animationOpacity = 1.0
                                
                                // Fade out after 1 second
                                withAnimation(.easeOut(duration: 1).delay(1)) {
                                    animationOpacity = 0.0
                                }
                            }
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: showAnimation)
                    }
                }
                .padding(.top, 50) // Adjust to make the animation higher up
                .transition(.scale)
            }
        }
    }
    
    // Function to unlock a new recipe
    func unlockRecipe() {
        if money >= 50 {
            money -= 50 // Deduct the money for unlocking
            
            // Define possible recipes to unlock
            let recipeOptions: [Recipe] = [
                Recipe(name: "Coffee", emoji: "☕", ingredients: ["Coffee Beans": 1, "Water": 1]),
                Recipe(name: "Cake", emoji: "🍰", ingredients: ["Flour": 1, "Sugar": 1, "Water": 1]),
                Recipe(name: "Latte", emoji: "🥛", ingredients: ["Coffee Beans": 1, "Milk": 1, "Water": 1]),
                Recipe(name: "Croissant", emoji: "🥐", ingredients: ["Flour": 2, "Butter": 1]),
                Recipe(name: "Muffin", emoji: "🧁", ingredients: ["Flour": 1, "Sugar": 1, "Eggs": 1, "Butter": 1]),
                Recipe(name: "Bagel", emoji: "🥯", ingredients: ["Flour": 2, "Yeast": 1]),
                Recipe(name: "Macaron", emoji: "🍪", ingredients: ["Almond Flour": 1, "Egg Whites": 1, "Sugar": 1]),
                Recipe(name: "Pancake", emoji: "🥞", ingredients: ["Flour": 2, "Milk": 1, "Eggs": 1]),
                Recipe(name: "Biscotti", emoji: "🍪", ingredients: ["Flour": 2, "Almonds": 1, "Sugar": 1]),
                Recipe(name: "Smoothie", emoji: "🍹", ingredients: ["Fruit": 1, "Yogurt": 1, "Ice": 1])
            ]
            
            // Set a 10% chance to unlock any recipe
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
                    animationType = .lose 
                } else {
                    // Add the unlocked recipe to avatar's unlockedRecipes if it's not already unlocked
                    avatar.unlockedRecipes.append(randomRecipe)
                    popUpMessage = "\(randomRecipe.name) recipe unlocked!"
                    animationType = .win
                }
                
                // Show the pop-up message
                showPopUp = true
                
                // Reset animation state before showing it again
                animationOpacity = 1.0 
                showAnimation = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showAnimation = true 
                }
                
            } else {
                // Optionally show a failure message or handle other cases
                print("Better luck next time!")
                animationType = .lose
                showAnimation = true 
            }
        }
    }
}
