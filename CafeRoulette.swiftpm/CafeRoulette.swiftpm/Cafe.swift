import SwiftUI

// Model for items like flour, sugar, and water
struct Item: Identifiable {
    var id: UUID = UUID()  // A unique identifier for each item
    var name: String
    var emoji: String // Store emoji
    var position: CGPoint
}

struct Cafe: View {
    @Binding var money: Int
    @Binding var avatar: Avatar  // Pass avatar data to track inventory and unlocked recipes
    
    @State private var items: [Item] = []  // List of spawned items
    @State private var timer: Timer?
    
    let mapWidth: CGFloat = 800
    let mapHeight: CGFloat = 600
    
    // Function to spawn random items on the map
    func spawnItem() {
        var itemNames = ["Flour", "Sugar", "Water"]
        
        // If the Coffee recipe is unlocked, include Coffee Beans in itemNames
        if avatar.unlockedRecipes.contains(where: { $0.name == "Coffee" }) {
            itemNames.append("Coffee Beans")
        }
        
        let itemEmojis = ["Flour": "🍞", "Sugar": "🍬", "Water": "💧", "Coffee Beans": "🫘"]
        let randomItemName = itemNames.randomElement()!
        let randomItemEmoji = itemEmojis[randomItemName]!
        
        // Ensure item spawns inside the map
        let randomX = CGFloat.random(in: 0..<mapWidth - 30) // Adjusted for item size (e.g., 30px)
        let randomY = CGFloat.random(in: 0..<mapHeight - 30) // Adjusted for item size (e.g., 30px)
        
        let newItem = Item(name: randomItemName, emoji: randomItemEmoji, position: CGPoint(x: randomX, y: randomY))
        items.append(newItem)
    }
    
    // Function to move avatar based on drag gesture
    func moveAvatar(to position: CGPoint) {
        var newPosition = position
        newPosition.x = min(max(newPosition.x, 0), mapWidth)
        newPosition.y = min(max(newPosition.y, 0), mapHeight)
        
        avatar.position = newPosition
        collectItem() // Check if avatar collects any item after moving
    }
    
    // Function to collect items
    func collectItem() {
        for i in items.indices {
            if avatar.position.distance(to: items[i].position) < 20 {
                let itemName = items[i].name
                avatar.inventory[itemName]! += 1
                items.remove(at: i)  // Remove item after collection
                break
            }
        }
    }
    
    // Function to bake recipes
    func bakeRecipe(recipe: Recipe) {
        guard recipe.unlocked else { return }  // Ensure the recipe is unlocked
        
        var canMakeRecipe = true
        for (ingredient, quantity) in recipe.ingredients {
            if avatar.inventory[ingredient, default: 0] < quantity {
                canMakeRecipe = false
                break
            }
        }
        
        if canMakeRecipe {
            // Deduct ingredients from inventory
            for (ingredient, quantity) in recipe.ingredients {
                avatar.inventory[ingredient]! -= quantity
            }
            
            // Add the resulting product (e.g., cake or coffee) to inventory
            let resultItem = recipe.name == "Cake" ? "Cake" : "Coffee"
            avatar.inventory[resultItem]! += 1
        }
    }
    
    // Function to sell Coffee for 10 money
    func sellCoffee() {
        // Safely unwrap the inventory value for "Coffee"
        if let coffeeCount = avatar.inventory["Coffee"], coffeeCount > 0 {
            avatar.inventory["Coffee"]! -= 1  // Decrease the coffee count
            money += 10  // Add money for selling coffee
        } else {
            print("No coffee to sell")
        }
    }
    
    // Function to sell Cake for 20 money
    func sellCake() {
        if avatar.inventory["Cake"]! > 0 {
            avatar.inventory["Cake"]! -= 1
            money += 20
        }
    }
    
    var body: some View {
        VStack {
            // Money display
            Text("Money: \(money)")
                .font(.largeTitle)
                .padding()
            
            // Avatar position display
            Text("Avatar Position: (\(Int(avatar.position.x)), \(Int(avatar.position.y)))")
                .padding()
            
            ZStack {
                // Map background
                Image("Map1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: mapWidth, height: mapHeight)
                    .clipped()
                
                // Add the avatar image
                Image("p1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .position(avatar.position)
                
                // Items on the map
                ForEach(items) { item in
                    Text(item.emoji)
                        .font(.system(size: 30))
                        .position(item.position)
                }
            }
            .border(Color.black, width: 2)
            .padding()
            
            HStack {
                Button("Bake Cake") {
                    if let cakeRecipe = avatar.unlockedRecipes.first(where: { $0.name == "Cake" }) {
                        bakeRecipe(recipe: cakeRecipe)
                    }
                }
                Button("Bake Coffee") {
                    // Only allow baking if the Coffee recipe is unlocked
                    if let coffeeRecipe = avatar.unlockedRecipes.first(where: { $0.name == "Coffee" }) {
                        bakeRecipe(recipe: coffeeRecipe)
                    }
                }
            }
            .padding()
            
            // Sell Buttons
            HStack {
                Button("Sell Coffee (10 money)") {
                    // Disable the button if Coffee is not unlocked or if player has no coffee
                    if avatar.unlockedRecipes.contains(where: { $0.name == "Coffee" }) {
                        sellCoffee()
                    }
                }
                .padding()
                .background(avatar.unlockedRecipes.contains(where: { $0.name == "Coffee" }) ? Color.green : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(!avatar.unlockedRecipes.contains(where: { $0.name == "Coffee" })) // Disable button if Coffee is locked
                
                Button("Sell Cake (20 money)") {
                    sellCake()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: Inventory(money: $money, inventory: avatar.inventory, unlockedRecipes: avatar.unlockedRecipes)) {
                Text("Go to Inventory")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            // Spawn random items when the game starts
            for _ in 0..<5 {
                spawnItem()
            }
            
            // Start the timer to spawn items periodically
            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                spawnItem()
            }
        }
        .onDisappear {
            // Stop the timer when the view disappears
            timer?.invalidate()
        }
        .gesture(DragGesture()
            .onChanged { value in
                moveAvatar(to: value.location)
            })
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(self.x - point.x, 2) + pow(self.y - point.y, 2))
    }
}
