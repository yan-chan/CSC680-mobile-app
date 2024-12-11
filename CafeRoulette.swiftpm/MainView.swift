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
    
    var body: some View {
        NavigationView {
            ZStack {
                // Set the background color for the whole screen
                Color(hexString: "#E0C6FF")
                    .edgesIgnoringSafeArea(.all) // Ensure it fills the whole screen
                
                VStack {
                    Spacer()
                    
                    // Cafe Button navigation
                    NavigationLink(destination: Cafe(money: $money, avatar: $avatar)) {
                        Text("Cafe")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hexString: "#7C6E8D"))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                    
                    // Gamble Button Navigation
                    NavigationLink(destination: Gamble(money: $money)) {
                        Text("Gamble")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hexString: "#7C6E8D"))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                    
                    // Gacha Button Navigation
                    NavigationLink(destination: Gacha(money: $money, avatar: $avatar)) {
                        Text("Gacha")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hexString: "#7C6E8D"))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                    
                    // Inventory Button Navigation
                    NavigationLink(destination: Inventory(money: $money, inventory: avatar.inventory, unlockedRecipes: avatar.unlockedRecipes)) {
                        Text("Inventory")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hexString: "#7C6E8D"))
                            .cornerRadius(10)
                    }
                }
                .navigationTitle("Game Selection")
                .navigationBarTitleDisplayMode(.inline) // Center the title in the navigation bar
            }
        }
    }
}
