
import SwiftUI

enum LearnStages {
    case intro, definition, causes, effects, conclusion
}

struct LearnView: View {
    
    @StateObject private var lVM = LearnViewModel()
    
    @State var stage: LearnStages = .intro
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            SubHeader(dismiss: dismiss, title: "Climate Change")
                .background(Color.darkPistachio)
            
            switch stage {
            case .intro:
                Intro(VM: lVM, stage: $stage)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .definition:
                Definition(VM: lVM, stage: $stage)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .causes:
                Causes(stage: $stage)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .effects:
                Effects(stage: $stage)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .conclusion:
                Conclusion(dismiss: dismiss)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .animation(.default, value: stage)
        .background(Color.background)
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
