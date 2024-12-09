import SwiftUI
import PlaygroundSupport

// Extension to create Color from Hex
extension Color {
    init(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        if hexSanitized.count == 6 {
            let scanner = Scanner(string: hexSanitized)
            var hexInt: UInt64 = 0
            if scanner.scanHexInt64(&hexInt) {
                let red = Double((hexInt & 0xFF0000) >> 16) / 255.0
                let green = Double((hexInt & 0x00FF00) >> 8) / 255.0
                let blue = Double(hexInt & 0x0000FF) / 255.0
                self.init(red: red, green: green, blue: blue)
                return
            }
        }
        
        self.init(.clear)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Set background color for the entire screen
                Color(hexString: "#E0C6FF")
                    .edgesIgnoringSafeArea(.all)  // Fill the entire screen
                
                VStack {
                    // Custom Image: cake.png
                    Image("cakeHomeScreen") // Use the image you added to the asset catalog
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.top, 50)
                    
                    // Title Text below the image
                    Text("CafeRoulette")
                        .font(.largeTitle) // Set font size
                        .fontWeight(.bold) // Make the font bold
                        .foregroundColor(.white) // Set text color
                        .padding(.top, 20) // Add spacing from the image
                    
                    Spacer()
                    
                    // Play Button with Navigation Link
                    NavigationLink(destination: MainView()) {
                        Text("Play")
                            .font(.title)
                            .padding()
                            .background(Color(hexString: "#7C6E8D")) 
                            .foregroundColor(.white) // White text color
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

