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
    @Binding var avatar: Avatar  // Pass avatar data to track inventory
    
    @State private var items: [Item] = []  // List of spawned items
    @State private var timer: Timer?
    
    let mapWidth: CGFloat = 800
    let mapHeight: CGFloat = 600
    
    // Function to spawn random items on the map
    func spawnItem() {
        var itemNames = ["Flour", "Sugar", "Water"]
        
        // Include ingredients of unlocked recipes
        for recipe in avatar.unlockedRecipes {
            for ingredient in recipe.ingredients.keys {
                if !itemNames.contains(ingredient) {
                    itemNames.append(ingredient)
                }
            }
        }
        
        let itemEmojis = [
            "Flour": "🍞",
            "Sugar": "🍬",
            "Water": "💧",
            "Coffee Beans": "🫘",
            "Milk": "🥛",
            "Butter": "🧈",
            "Eggs": "🥚",
            "Almond Flour": "🌰",
            "Yeast": "🍞",
            "Fruit": "🍓",
            "Ice": "❄️",
            "Yogurt": "🍦"
        ]
        
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
    
    // Function to collect items and convert them into coins
    func collectItem() {
        for i in items.indices {
            if avatar.position.distance(to: items[i].position) < 20 {
                let itemName = items[i].name
                // Convert the collected item to coins automatically
                money += coinValue(for: itemName)
                items.remove(at: i)  // Remove item after collection
                break
            }
        }
    }
    
    // Define a function to assign coin values to items
    func coinValue(for item: String) -> Int {
        switch item {
        case "Flour":
            return 5
        case "Sugar":
            return 5
        case "Water":
            return 2
        case "Coffee Beans":
            return 10
        case "Milk":
            return 3
        case "Butter":
            return 4
        case "Eggs":
            return 3
        case "Almond Flour":
            return 7
        case "Yeast":
            return 6
        case "Fruit":
            return 2
        case "Ice":
            return 1
        case "Yogurt":
            return 2
        default:
            return 1
        }
    }
    
    var availableIngredients: [String] {
        var ingredients = ["Flour", "Sugar", "Water"]
        
        // Add ingredients of unlocked recipes dynamically
        for recipe in avatar.unlockedRecipes {
            for ingredient in recipe.ingredients.keys {
                if !ingredients.contains(ingredient) {
                    ingredients.append(ingredient)
                }
            }
        }
        
        return ingredients
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
            
            NavigationLink(destination: Inventory(
                money: $money,
                inventory: avatar.inventory,
                unlockedRecipes: avatar.unlockedRecipes,
                availableIngredients: availableIngredients // Pass the dynamic availableIngredients array
            )) {
                Text("Go to Inventory")
                    .padding()
                    .background(Color.pink)  // Change background color to pink
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
