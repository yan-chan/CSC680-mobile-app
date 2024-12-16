import SwiftUI

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

// Snowfall View to animate snowflakes
struct SnowfallView: View {
    let snowflakes = Array(repeating: Color.white, count: 100)
    
    @State private var positions: [CGPoint] = Array(repeating: CGPoint(x: Int.random(in: 0...400), y: Int.random(in: -50...0)), count: 100)
    @State private var horizontalOffsets: [CGFloat] = Array(repeating: CGFloat.random(in: -20...20), count: 100) // Random horizontal drift for each snowflake
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<snowflakes.count, id: \.self) { index in
                    Circle()
                        .fill(snowflakes[index])
                        .frame(width: CGFloat.random(in: 5...10), height: CGFloat.random(in: 5...10))
                        .position(positions[index])
                        .offset(x: horizontalOffsets[index]) // Apply horizontal drift
                        .onAppear {
                            startSnowfall(for: index, in: geometry.size)
                        }
                }
            }
        }
        .clipped()
    }
    
    private func startSnowfall(for index: Int, in size: CGSize) {
        let initialX = CGFloat.random(in: 0...size.width)
        let initialY = CGFloat.random(in: -50...0) // Start snowflakes just above the screen
        let finalY = size.height + 10 // Snowflakes should fall off the screen
        
        positions[index] = CGPoint(x: initialX, y: initialY) // Set the starting position of the snowflake
        
        // Apply a smooth animation with easing for a more natural movement
        withAnimation(Animation.easeInOut(duration: Double.random(in: 4...7)).repeatForever(autoreverses: false)) {
            // Snowflakes fall smoothly with horizontal drift
            positions[index] = CGPoint(x: initialX + horizontalOffsets[index], y: finalY)
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Set background color for the entire screen
                Color(hexString: "#E0C6FF")
                    .edgesIgnoringSafeArea(.all)
                
                SnowfallView() // Snowfall animation
                
                VStack {
                    // Custom Image: cake.png
                    Image("cakeHomeScreen") // Use the image you added to the asset catalog
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.top, 50)
                    
                    // Title Text below the image with a cafe-like font
                    Text("CafeRoulette")
                        .font(.custom("Lobster-Regular", size: 48)) // Example of using a custom cafe-like font
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20) // Add spacing from the image
                    
                    Spacer()
                    
                    // Play Button with Navigation Link
                    NavigationLink(destination: MainView()) {
                        Text("Play")
                            .font(.title)
                            .fontWeight(.heavy) // Bold text for a fun look
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(hexString: "##87CEEB"), Color(hexString: "#87CEEB")]), startPoint: .top, endPoint: .bottom)
                            ) 
                            .cornerRadius(30) 
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5) // Bold shadow for depth
                            .scaleEffect(1.1)
                            .rotationEffect(.degrees(5)) 
                            .animation(.easeInOut(duration: 0.2).repeatForever(autoreverses: true), value: UUID())
                            .padding(.bottom, 50)
                    }

                    .padding(.bottom, 50)
                }
            }
        }
    }
}

