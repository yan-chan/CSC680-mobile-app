struct Inventory: View {
    @Binding var money: Int // Pass money from MainView
    var inventory: [String: Int] // Inventory passed from MainView

    var body: some View {
        VStack {
            Text("Your Inventory")
                .font(.largeTitle)
                .padding()

            Text("Current Money: (money)")
                .font(.title)
                .padding()

            Text("Flour: (inventory["Flour"]!)")
            Text("Sugar: (inventory["Sugar"]!)")
            Text("Water: (inventory["Water"]!)")
            Text("Cakes: (inventory["Cake"]!)")

            Spacer()
        }
        .navigationTitle("Inventory")
        .navigationBarTitleDisplayMode(.inline)
    }
}