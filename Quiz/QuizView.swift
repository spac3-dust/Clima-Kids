
import SwiftUI
import Combine
import Subsonic

enum QuizStages {
    case start, during, end
}

struct QuizView: View {
    
    @StateObject var service = QuizService()
    
    @State var stage: QuizStages = .start
    
    @Environment(\.dismiss) var dismiss
    
    var prompts = Prompts.prompts
    
    
    var body: some View {
        VStack(spacing: 0) {
            SubHeader(dismiss: dismiss, title: "The Quiz")
            
            ProgressView(value: service.progress, total: Double(prompts.count))
                .tint(Color.progressBar)
                .animation(.easeIn, value: service.progress)
                .frame(maxWidth: .infinity)
            
            VStack {
                switch stage {
                case .start:
                    StartCard(stage: $stage)
                        .padding()
                case .during:
                    PromptCards(prompts: prompts, service: service, stage: $stage)
                        .padding()
                case .end:
                    EndCard(service: service)
                        .padding()
                }
            }
            .animation(.easeInOut(duration: 0.5), value: stage)
        }
        .background(Color.background)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct StartCard: View {
    
    @Binding var stage: QuizStages
    
    var body: some View {
        
        VStack {
            VStack {
                VStack {
                    Text("Whenever You're Ready!")
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.darkGray)
                        .fontWeight(.heavy)
                        .italic()
                        .multilineTextAlignment(.center)
                        .shadow(radius: 0.5)
                        .padding()
                }
                .padding(.horizontal)
                
                Button {
                    stage = .during
                    play(sound: "Button.mp3")
                } label: {
                    Text("Begin")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .myButtonStyle()
                }
                .buttonStyle(.plain)
            }
            .background(Circle().foregroundColor(.lightGreen).shadow(radius: 0.5, x: 3, y: 3).frame(width: 300, height: 300))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PromptCards: View {
    
    let prompts: [Prompts]
    
    let service: QuizService
    
    @State var index = 0
    
    @State var isSelected = false
    
    @State var isDisabledTrue = true
    
    @State var isChoicesDisabled = false
    
    @State var showMessage = false
    
    @Binding var stage: QuizStages
    
    var body: some View {
        
        VStack {
            Text(prompts[index].prompt)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
            
            Divider()
                .padding(.horizontal)
            
            if showMessage {
                Text(prompts[index].message)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .lineSpacing(10)
                    .padding()
            }
            
            Spacer()
            
            ForEach(prompts[index].options, id: \.self) { answer in
                Button {
                    // Send user's answer down the pipeline and disable buttons
                    service.answers.send(answer)
                    isSelected = true
                    showMessage = true
                    isDisabledTrue = false
                    isChoicesDisabled = true
                    
                    play(sound: "mechKey.mp3")
                    
                } label: {
                    if isSelected {
                        if answer.isCorrect {
                            Text(answer.answer)
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(25)
                                .shadow(radius: 0.5, x: 3, y: 3)
                                .padding([.horizontal, .top])
                        } else {
                            Text(answer.answer)
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(25)
                                .shadow(radius: 0.5, x: 3, y: 3)
                                .padding([.horizontal, .top])
                        }
                    } else {
                        Text(answer.answer)
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pistachio)
                            .cornerRadius(25)
                            .shadow(radius: 0.5, x: 3, y: 3)
                            .padding([.horizontal, .top])
                    }
                }
                .buttonStyle(.plain)
                .disabled(isChoicesDisabled)
            }
            
            Button {
                // If the last prompt is reached, show the end view
                if prompts.count == index + 1  {
                    stage = .end
                    
                    // Send completion
                    service.saver.send(completion: .finished)
                    service.answers.send(completion: .finished)
                    
                } else {
                    // Otherwise, increment the index and reset
                    index += 1
                    isSelected = false
                    showMessage = false
                    isDisabledTrue = true
                    isChoicesDisabled = false
                    
                    play(sound: "mechKey.mp3")
                }
                
            } label: {
                Text("Next")
                    .font(.headline)
                    .fontWeight(.bold)
                    .myButtonStyle()
            }
            .buttonStyle(.plain)
            .disabled(isDisabledTrue)
            .padding()
        }
        .animation(.default, value: index)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct EndCard: View {
    
    let service: QuizService
    
    var body: some View {
        VStack {
            VStack {
                Text("\(service.endMessage)")
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(.darkGray)
                    .fontWeight(.heavy)
                    .italic()
                    .multilineTextAlignment(.center)
                    .shadow(radius: 1)
                    .padding()
                
                Text("You earned \(service.totalPoints)/7 points")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .padding()
            }
            .background(Circle().foregroundColor(.lightGreen).shadow(radius: 1, x: 3, y: 3).frame(width: 300, height: 300))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
