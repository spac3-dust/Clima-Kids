
import SwiftUI

struct QuizTab: View {
    
    // Create a state object
    @StateObject private var qVM = QuizTabVM()
    
    // Counter for images
    @State private var imageCounter = 0
    
    @State private var messageCounter = 0
    
    @State private var credits = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            MainHeader(title: "Climate Quiz", description: "A Quick Quiz")
            
            GeometryReader { proxy in
                VStack {
                    VStack {
                        Image(qVM.imagesArray[imageCounter])
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 1)
                            .padding(15)
                            .onReceive(qVM.timer) { _ in
                                withAnimation(.easeOut) {
                                    // Increment the count to go through the images
                                    imageCounter = imageCounter == qVM.imagesArray.count - 1 ? 0 : imageCounter + 1
                                }
                            }
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height * 0.6)
                    .background(Circle().padding().foregroundColor(.lightGreen).shadow(radius: 0.5, x: 5, y: 5))
                    
                    VStack {
                        Text("The Quiz")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            
                        HStack {
                            Text("Previous Attempt: \(qVM.yourPoints)/7 pts")
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.semibold)
                                .padding(10)
                                .foregroundColor(.darkGray)
                                .background(Color.tabBarBackground)
                                .cornerRadius(15)
                                .shadow(radius: 0.7)
                            
                            Button {
                                credits = true
                            } label: {
                                Text("Credits")
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.semibold)
                                    .padding(10)
                                    .foregroundColor(.darkGray)
                                    .background(Color.tabBarBackground)
                                    .cornerRadius(15)
                                    .shadow(radius: 0.7)
                                    
                            }
                            .buttonStyle(.plain)
                            
                        }
      
                        Text(qVM.messagesArray[messageCounter])
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.darkGray)
                            .padding()
                            .onReceive(qVM.timer1) { _ in
                                withAnimation(.easeOut) {
                                    // Increment the count to go through the images
                                    messageCounter = messageCounter == qVM.messagesArray.count - 1 ? 0 : messageCounter + 1
                                }
                            }
                        
                        Button {
                            qVM.showChallenge.toggle()
                        } label: {
                            Text("Start")
                                .fontWeight(.heavy)
                                .myButtonStyle()
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height * 0.35)
                }
            }
        }
        .background(Color.background)
        .fullScreenCover(isPresented: $qVM.showChallenge, content: QuizView.init)
        .fullScreenCover(isPresented: $credits, content: CreditsView.init)
    }
}

struct CreditsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        SubHeader(dismiss: dismiss, title: "Credits")
        
        ScrollView(showsIndicators: false) {
            Image("support")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .shadow(radius: 0.5, x: 3, y: 3)
            
            Text("Support Illustration")
                .font(.system(.headline, design: .rounded))
            
            Text("by Pixel True")
                .font(.system(.caption, design: .rounded))
            
            Text("CC BY 4.0")
                .font(.system(.caption, design: .rounded))
            
            Image("plantTrees")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .shadow(radius: 0.5, x: 3, y: 3)
            
            Text("Plant a tree Illustration")
                .font(.system(.headline, design: .rounded))
            
            Text("by Pixel True")
                .font(.system(.caption, design: .rounded))
            
            Text("CC BY 4.0")
                .font(.system(.caption, design: .rounded))
            
            Image("polarGlobalWarming")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .shadow(radius: 0.5, x: 3, y: 3)
                .padding()
            
            Text("Image by macrovector on FreePik")
                .font(.system(.headline, design: .rounded))
            
        }
    }
}

struct QuizTab_Previews: PreviewProvider {
    static var previews: some View {
        QuizTab()
    }
}

