import SwiftUI

// MainView: Game Selection Page
struct MainView: View {
    @State private var money = 10000 // Starting money
    @State private var avatar = Avatar(position: CGPoint(x: 100, y: 100))  // Initial avatar position
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                // Cafe Button navigation
                NavigationLink(destination: Cafe(money: $money, avatar: $avatar)) {
                    Text("Cafe")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
                
                // Gamble Button Navigation
                NavigationLink(destination: Gamble(money: $money)) {
                    Text("Gamble")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
                
                // Gacha Button Navigation
                NavigationLink(destination: Gacha(money: $money, avatar: $avatar)) {
                    Text("Gacha")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
                
                // Inventory Button Navigation
                NavigationLink(destination: Inventory(money: $money, inventory: avatar.inventory, unlockedRecipes: avatar.unlockedRecipes)) {
                    Text("Inventory")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Game Selection") // Title for the game selection page
        }
    }
}
