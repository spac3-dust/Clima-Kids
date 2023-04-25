import SwiftUI

enum tabs {
    case learn, challenge
}

struct MainView: View {
    
    @State private var tabs: tabs = .learn
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // Switch statement for tabs
            switch tabs {
            case .learn:
                LearnTab()
            case .challenge:
                QuizTab()
            }
            
            // TabBar
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: 0.3)
                    .opacity(0.3)
                
                HStack(spacing: 0) {
                    Spacer()
                    TabButton(currentTab: $tabs, image: "graduationcap.fill", color: .pistachio, tab: .learn)
                    
                    TabButton(currentTab: $tabs, image: "leaf.fill", color: .pistachio, tab: .challenge)
                    Spacer()
                }
            }
            .frame(maxHeight: 60)
            .background(Color.tabBarBackground)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
