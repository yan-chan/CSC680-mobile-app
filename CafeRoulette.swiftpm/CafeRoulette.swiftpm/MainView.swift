import SwiftUI

// MainView: Game Selection Page
struct MainView: View {
    @State private var money = 10000 // Starting money
    @State private var avatar = Avatar(position: CGPoint(x: 100, y: 100))  // Initial avatar position
    
    init() {
        // Customize navigation bar appearance here
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white // Set the title color to white
        ]
        UINavigationBar.appearance().backgroundColor = UIColor.clear
    }
    
    // Define available ingredients dynamically based on unlocked recipes
    var availableIngredients: [String] {
        var ingredients = ["Flour", "Sugar", "Water"]
        
        // Add Coffee Beans if the Coffee recipe is unlocked
        if avatar.unlockedRecipes.contains(where: { $0.name == "Coffee" }) {
            ingredients.append("Coffee Beans")
        }
        
        return ingredients
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background color with a light lavender shade
                Color(UIColor(hex: "#E0C6FF"))
                    .edgesIgnoringSafeArea(.all) // Ensure it fills the whole screen
                
                VStack {
                    Spacer()
                    
                    // Cafe Button navigation
                    NavigationLink(destination: Cafe(money: $money, avatar: $avatar)) {
                        Text("Cafe")
                            .font(.custom("Comic Sans MS", size: 24)) // Playful, bolder font
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(UIColor(hex: "#7C6E8D"))) // Solid background color
                            .cornerRadius(15)
                            .shadow(radius: 10) // Shadow for depth
                            .scaleEffect(1.05) // Slightly increase button size on press
                            .animation(.spring(), value: 1) // Animation for button press
                    }
                    .padding(.bottom, 30)
                    
                    // Gamble Button Navigation
                    NavigationLink(destination: Gamble(money: $money)) {
                        Text("Gamble")
                            .font(.custom("Comic Sans MS", size: 24)) // Playful, bolder font
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(UIColor(hex: "#7C6E8D"))) // Solid background color
                            .cornerRadius(15)
                            .shadow(radius: 10) // Shadow for depth
                            .scaleEffect(1.05) // Slightly increase button size on press
                            .animation(.spring(), value: 1) // Animation for button press
                    }
                    .padding(.bottom, 30)
                    
                    // Gacha Button Navigation
                    NavigationLink(destination: Gacha(money: $money, avatar: $avatar)) {
                        Text("Gacha")
                            .font(.custom("Comic Sans MS", size: 24)) // Playful, bolder font
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(UIColor(hex: "#7C6E8D"))) // Solid background color
                            .cornerRadius(15)
                            .shadow(radius: 10) // Shadow for depth
                            .scaleEffect(1.05) // Slightly increase button size on press
                            .animation(.spring(), value: 1) // Animation for button press
                    }
                    .padding(.bottom, 30)
                    
                    // Inventory Button Navigation
                    NavigationLink(destination: Inventory(
                        money: $money,
                        inventory: avatar.inventory,
                        unlockedRecipes: avatar.unlockedRecipes,
                        availableIngredients: availableIngredients // Pass the dynamic availableIngredients array
                    )) {
                        Text("Inventory")
                            .font(.custom("Comic Sans MS", size: 24)) // Playful, bolder font
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(UIColor(hex: "#7C6E8D"))) // Solid background color
                            .cornerRadius(15)
                            .shadow(radius: 10) // Shadow for depth
                            .scaleEffect(1.05) // Slightly increase button size on press
                            .animation(.spring(), value: 1) // Animation for button press
                    }
                    .padding(.bottom, 30) // Same bottom padding as other buttons
                    
                    Spacer()
                }
                .navigationTitle("Game Selection")
                .navigationBarTitleDisplayMode(.inline) // Center the title in the navigation bar
            }
        }
    }
}

// Use UIColor initializer directly without the custom Color extension
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        var hexValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&hexValue)
        
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
