
import Foundation

class LearnViewModel: ObservableObject {
    
    @Published var timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    
    @Published var glaciarSequence = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
}
