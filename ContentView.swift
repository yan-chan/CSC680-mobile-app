import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Logo
                Image(systemName: "star.fill") // Replace with your logo image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 50)
                
                Spacer()
                
                // Play Button with Navigation Link
                NavigationLink(destination: MainView()) {
                    Text("Play")
                        .font(.title)
                        .padding()
                        .background(Color.pink) // Pink background color
                        .foregroundColor(.white) // White text color
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
            }
            
        }
    }
}

