import SwiftUI
import Combine

class QuizService: ObservableObject {
    
     /*
     Flow:
     
     1) User's answers are send down the 'answers' publisher's pipeline via 'service.answers.send(answer)' in 'PromptCards' view
     
     2) Those values are received throughout the entire session and acted upon by 'calcPoints()' and 'sortUserChoices()' respective subscribers
     
     3) 'sortUserChoices()' evaluates each answer whenever an answer is received and mutates 'results' tuple
     
     4) The subscriber in 'calcPoints()' sends each value to the 'saver' publisher via 'saver.send(totalPoints)'
      
     5) When the completion is sent in 'PromptCards,''sortUserChoices()' calls
      setEndMessage()' and an endMessage is configured ... 'calcPoints()' and 'sortUserChoices()' end their subscription ... at this point all calculations are finished
      
     6) 'save()' then saves the user's final emitted value via UserDefaults
     */
    
    // Publishers
    @Published var totalPoints = 0
    
    @Published var progress: Double = 0.0
    
    @Published var endMessage: String = ""
    
    var answers = PassthroughSubject<Responses, Never>()
    
    var saver = PassthroughSubject<Int, Never>()
    
    var cancellables = Set<AnyCancellable>()
    
    var results: (inCorrect: Int, correct: Int) = (0, 0) // Set all to 0 initally
    
    init() {
        calcPoints()
        sortUserChoices()
        save()
    }

    func setEndMessage() {
        if results.inCorrect > results.correct {
            endMessage = "There's always next time..."
        } else if results.correct > results.inCorrect {
            endMessage = "Great Job!"
        }
    }
    
    // Recieve user input and calculate points
    func calcPoints() {
        
        // Subscriber
        answers
            .sink { completion in
                switch completion{
                case .finished:
                    return
                }
            } receiveValue: { [unowned self] ans in
                
                if ans.isCorrect {
                    totalPoints += 1
                }

                saver.send(totalPoints)
                
                // Increase progress for Progress Bar
                progress += 1
                
            }
            .store(in: &cancellables)
    }
    
    // Recieve user input and sort it
    func sortUserChoices() {
        
        // Subscriber
        answers
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    setEndMessage() // Call on completion
                    return
                }
            } receiveValue: { [unowned self] ans in
                if !ans.isCorrect {
                    results.inCorrect += 1
                } else {
                    results.correct += 1
                }
            }
            .store(in: &cancellables)
        
    }
    
    // Save user's final total score with UserDefaults
    func save() {
        
        // Subscriber
        saver
            .collect() // Wait until all of user's answers have been recieved
            .map{ $0.last! } // Only the final total
            .sink { int in
                UserDefaults.standard.set(int, forKey: "userPoints")
                print("Score Saved: \(int)")
            }
            .store(in: &cancellables)
    }
    
}
