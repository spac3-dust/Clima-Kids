import SwiftUI

struct LearnTab: View {
    
    @State var showLearnView: Bool = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            MainHeader(title: "Climate Change", description: "For Kids")
            
                Image("polarGlobalWarming")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding()
                    .shadow(radius: 0.5, x: 5, y: 5)
            
            Spacer()
            
            VStack {
                Text("Climate Change")
                    .foregroundColor(.black)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .padding()
                
                Text("A Byte-Sized Lesson!")
                    .foregroundColor(.darkGray)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    
                Button {
                    showLearnView.toggle()
                } label: {
                    Text("Begin")
                        .fontWeight(.heavy)
                        .myButtonStyle()
                }
                .buttonStyle(.plain)
                .padding()
            }
            .padding(.bottom)
        }
        .background(Color.background)
        .fullScreenCover(isPresented: $showLearnView) {
            LearnView()
        }
    }
}

struct LearnTab_Previews: PreviewProvider {
    static var previews: some View {
        LearnTab()
    }
}
