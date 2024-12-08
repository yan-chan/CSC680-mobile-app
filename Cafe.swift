import SwiftUI

// Model for items like flour, sugar, and water
struct Item: Identifiable {
    var id: UUID = UUID()  // A unique identifier for each item
    var name: String
    var emoji: String // Store emoji
    var position: CGPoint
}

// Model for the Avatar
struct Avatar {
    var position: CGPoint
    var inventory: [String: Int] = ["Flour": 0, "Sugar": 0, "Water": 0, "Cake": 0]
}

struct Cafe: View {
    @Binding var money: Int  // Pass money from MainView
    
    @State private var avatar = Avatar(position: CGPoint(x: 100, y: 100))  // Initial avatar position
    @State private var items: [Item] = []  // List of spawned items
    @State private var cakesBaked = 0
    
    // The map size
    let mapWidth: CGFloat = 400
    let mapHeight: CGFloat = 400
    
    // Functions for random item spawning and avatar movement
    func spawnItem() {
        let itemNames = ["Flour", "Sugar", "Water"]
        let itemEmojis = ["Flour": "🍞", "Sugar": "🍬", "Water": "💧"]
        let randomItemName = itemNames.randomElement()!
        let randomItemEmoji = itemEmojis[randomItemName]!
        let randomX = CGFloat.random(in: 0..<mapWidth)
        let randomY = CGFloat.random(in: 0..<mapHeight)
        let newItem = Item(name: randomItemName, emoji: randomItemEmoji, position: CGPoint(x: randomX, y: randomY))
        items.append(newItem)
    }

    func moveAvatar(dx: CGFloat, dy: CGFloat) {
        var newPosition = avatar.position
        newPosition.x += dx
        newPosition.y += dy
        
        // Ensure avatar stays within bounds of the map
        newPosition.x = min(max(newPosition.x, 0), mapWidth)
        newPosition.y = min(max(newPosition.y, 0), mapHeight)
        
        avatar.position = newPosition
    }
    
    func collectItem() {
        // Check if avatar's position overlaps any spawned items and collect them
        for i in items.indices {
            if avatar.position.distance(to: items[i].position) < 20 {  // 20 is the collection range
                let itemName = items[i].name
                avatar.inventory[itemName]! += 1
                items.remove(at: i)  // Remove item after collection
                break
            }
        }
    }

    func bakeCake() {
        // Check if the player has the ingredients
        if avatar.inventory["Flour"]! > 0 &&
            avatar.inventory["Sugar"]! > 0 &&
            avatar.inventory["Water"]! > 0 {
            
            // Bake a cake
            avatar.inventory["Flour"]! -= 1
            avatar.inventory["Sugar"]! -= 1
            avatar.inventory["Water"]! -= 1
            avatar.inventory["Cake"]! += 1
            cakesBaked += 1
        }
    }

    func sellCake() {
        if avatar.inventory["Cake"]! > 0 {
            avatar.inventory["Cake"]! -= 1
            money += 10  // Add money for selling a cake
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
                Rectangle()
                    .fill(Color.green)
                    .frame(width: mapWidth, height: mapHeight)
                    .overlay(
                        // Add the avatar
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 30, height: 30)
                            .position(avatar.position)
                    )
                
                // Items on the map
                ForEach(items) { item in
                    Text(item.emoji) // Display the emoji instead of colored circle
                        .font(.system(size: 30))  // Adjust emoji size
                        .position(item.position)
                }
            }
            .border(Color.black, width: 2)
            .padding()
            
            HStack {
                Button("Move Up") {
                    moveAvatar(dx: 0, dy: -10)
                }
                Button("Move Down") {
                    moveAvatar(dx: 0, dy: 10)
                }
                Button("Move Left") {
                    moveAvatar(dx: -10, dy: 0)
                }
                Button("Move Right") {
                    moveAvatar(dx: 10, dy: 0)
                }
            }
            
            HStack {
                Button("Collect Item") {
                    collectItem()
                }
                Button("Bake Cake") {
                    bakeCake()
                }
                Button("Sell Cake") {
                    sellCake()
                }
            }
            .padding()
        }
        .onAppear {
            // Spawn random items when the game starts
            for _ in 0..<5 {
                spawnItem()
            }
        }
        .navigationDestination(isPresented: .constant(true)) {
            Inventory(money: $money, inventory: avatar.inventory)
        }
    }
}

extension CGPoint {
    // Helper function to calculate the distance between two points
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(self.x - point.x, 2) + pow(self.y - point.y, 2))
    }
}

struct Inventory: View {
    @Binding var money: Int // Pass money from MainView
    var inventory: [String: Int]
    
    var body: some View {
        VStack {
            Text("Your Inventory")
                .font(.largeTitle)
                .padding()
            
            Text("Current Money: \(money)")
                .font(.title)
                .padding()
            
            Text("Flour: \(inventory["Flour"]!)")
            Text("Sugar: \(inventory["Sugar"]!)")
            Text("Water: \(inventory["Water"]!)")
            Text("Cakes: \(inventory["Cake"]!)")
            
            Spacer()
        }
        .navigationTitle("Inventory")
        .navigationBarTitleDisplayMode(.inline)
    }
}
