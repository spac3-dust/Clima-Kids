
import Foundation

class QuizTabVM: ObservableObject {
    
    // Timer for incrementing 'count'
    @Published var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    @Published var timer1 = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @Published var showChallenge = false
    
    @Published var yourPoints: Int = UserDefaults.standard.integer(forKey: "userPoints")
    
    let imagesArray: [String] = ["reducePlastic", "recycling1", "plantTrees", "support",] // Iterate through these images
    
    let messagesArray: [String] = ["Review what you learned", "Get as many right as you can", "Each question is worth 1 point", "Whenever you're ready, Start!"]

}
