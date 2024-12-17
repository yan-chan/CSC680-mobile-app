import SwiftUI

// Inventory View
struct Inventory: View {
    @Binding var money: Int
    var inventory: [String: Int]
    var unlockedRecipes: [Recipe]
    var availableIngredients: [String]
    
    var body: some View {
        ZStack {
            // Light yellow background with a subtle gradient
            LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.3), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Your Inventory")
                    .font(.custom("Comic Sans MS", size: 36))  // Playful, anime-style font
                    .fontWeight(.bold)
                    .foregroundColor(Color.pink)
                    .padding(.top, 30)
                
                Text("Current Money: \(money)")
                    .font(.custom("Comic Sans MS", size: 22))
                    .fontWeight(.medium)
                    .foregroundColor(Color.pink)
                    .padding()
                
                // Ingredients section
                VStack(alignment: .leading) {
                    Text("Ingredients that can drop:")
                        .font(.custom("Comic Sans MS", size: 22))
                        .foregroundColor(Color.pink)
                        .padding(.top, 10)
                    
                    ForEach(availableIngredients, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient)
                                .font(.custom("Comic Sans MS", size: 18))
                                .foregroundColor(.black)
                            Spacer()
                
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                    }
                }
                .padding()
                
                // Unlocked Recipes Section
                VStack(alignment: .leading) {
                    Text("Unlocked Recipes:")
                        .font(.custom("Comic Sans MS", size: 22))
                        .foregroundColor(Color.pink)
                        .padding(.top, 20)
                    
                    ForEach(unlockedRecipes) { recipe in
                        HStack {
                            Text(recipe.emoji)
                                .font(.system(size: 30))
                            Text(recipe.name)
                                .font(.custom("Comic Sans MS", size: 18))
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.bottom, 8)
                    }
                }
                .padding()

                Spacer()
            }
        }
        .navigationTitle("Inventory")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}
