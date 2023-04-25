
import Foundation

struct Prompts: Hashable {
    
    let prompt: String
    
    let message: String
    
    let options: [Responses]
    
}

struct Responses: Hashable {
    
    let answer: String
    
    let isCorrect: Bool
    
}

extension Prompts {
    
    static let prompts: [Prompts] = [

        Prompts(prompt: "Which of the following is not related to greenhouse gases?", message: "Climate change has actually increased Earth's temperatures. In the last 100 years, temperatures have increased about 2 degrees Fahrenheit!", options: [Responses(answer: "Traps heat from the Sun", isCorrect: false), Responses(answer: "Makes Earth warm for us to live on", isCorrect: false), Responses(answer: "Lowers Earth's temperatures", isCorrect: true)]),
        
        Prompts(prompt: "Which of the following is not a Human Activity?", message: "Human Activity refers to our actions that create greenhouse gases. Eating your apple is an enjoyable activity", options: [Responses(answer: "Farming Livestock", isCorrect: false), Responses(answer: "Eating an apple", isCorrect: true), Responses(answer: "Burning Fossil Fuels for Energy", isCorrect: false)]),
        
        Prompts(prompt: "What will not help us fight climate change?", message: "Farming livestock creates a lot of greenhouse gases. So, we should try eating more vegetables every day!", options: [Responses(answer: "Biking or Carpooling With Your Friends", isCorrect: false), Responses(answer: "Turning lights and electronics off", isCorrect: false), Responses(answer: "Eating less vegetables and More Meat", isCorrect: true)]),
        
        Prompts(prompt: "What is not a cause of climate change?", message: "Climate change is caused by the Greenhouse Effect as well as human activities like using fossil fuels. Evil bananas are surely not a cause!", options: [Responses(answer: "The Greenhouse Effect", isCorrect: false), Responses(answer: "More Evil Bananas!", isCorrect: true), Responses(answer: "Using Fossil Fuels", isCorrect: false)]),
        
        Prompts(prompt: "What is not a result of climate change?", message: "Climate change is a serious problem for us today. We have to work together and act quickly to tackle it", options: [Responses(answer: "Rising Sea levels", isCorrect: false), Responses(answer: "Severe and Frequent Droughts", isCorrect: false), Responses(answer: "A better world for us and the future", isCorrect: true)]),
        
        Prompts(prompt: "What does thermal expansion mean for the ocean?", message: "Thermal Expansion causes the Earth's sea levels to rise because it takes up more space!", options: [Responses(answer: "The sea levels begin to fall", isCorrect: false), Responses(answer: "The sea levels begin to rise", isCorrect: true), Responses(answer: "The sea levels stay the same", isCorrect: false)]),
        
        Prompts(prompt: "Earth's climate only started changing because of us humans", message: "Earth's climate has been always naturally changing before we existed!", options: [Responses(answer: "True", isCorrect: false), Responses(answer: "False", isCorrect: true)])
        
        
    ]
}
