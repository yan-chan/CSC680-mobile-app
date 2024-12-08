import SwiftUI

// MainView: Game Selection Page
struct MainView: View {
    @State private var money = 100 // Starting money
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                //Cafe Button navigation
                NavigationLink(destination: Gamble(money: $money)) {
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
                
                // Inventory Button Navigation
                NavigationLink(destination: Inventory(money: $money)) {
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

