import SwiftUI
import Subsonic

/*
 
 Here are the sources I used
 
 https://climatekids.nasa.gov/kids-guide-to-climate-change/
 
 https://climate.nasa.gov/effects/
 
 https://www.un.org/en/climatechange/science/causes-effects-climate-change
 
 https://www.ifaw.org/journal/impact-climate-change-animals
 
 https://www.woodlandtrust.org.uk/blog/2021/10/climate-change-facts-actions-for-kids/
 
 https://climate.ec.europa.eu/climate-change/consequences-climate-change_en
 
 https://www.nps.gov/articles/000/wildlife-climateimpact.htm
 
 https://www.epa.gov/climateimpacts/climate-change-impacts-ecosystems
 
 https://www.un.org/en/actnow/ten-actions#electric-car
 
 */

// These are the views for each stage of the learning process
struct Intro: View {
    
    let VM: LearnViewModel
    
    @Binding var stage: LearnStages
    
    @State var count = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if count == 0 {
                    Newspaper1()
                        .transition(.slide)
                } else if count == 1 {
                    Newspaper2()
                        .transition(.slide)
                } else if count == 2 {
                    Videos()
                        .transition(.slide)
                }
            }
            .frame(height: 300)
            .shadow(radius: 0.5, x: 3, y: 3)
            .animation(.default, value: count)
            .onReceive(VM.timer) { _ in
                count = count == 2 ? 0 : count + 1
            }
            
            VStack {
                
                Text("Have you ever wondered about Climate Change?")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineSpacing(10)
                    .padding([.bottom, .horizontal])
                
                Rectangle()
                    .cornerRadius(20)
                    .foregroundColor(.gray)
                    .frame(width: 35, height: 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("You might've heard friends, teachers, or The News talking about it recently.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
            }
            
            Button {
                stage = .definition
                play(sound: "Button.mp3")
            } label: {
                Text("Next")
                    .fontWeight(.bold)
                    .myButtonStyle()
            }
            .buttonStyle(.plain)
            .padding(.vertical)
            
        }
    }
}

struct Definition: View {
    
    let VM: LearnViewModel
    
    @Binding var stage: LearnStages
    
    @State var opacity = 0.0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            Text("Are weather and climate the same?")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top)
            
            Text("The answer is NO.")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.darkGray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .horizontal])
            
            Text("Weather is temporary and explains the conditions outside wherever you may be right now.")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.medium)
                .foregroundColor(.darkGray)
                .lineSpacing(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Text("However, climate is the average weather patterns of a place for a long time.")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.medium)
                .foregroundColor(.darkGray)
                .lineSpacing(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack {
                Image("Weather")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(radius: 0.5, x: 3, y: 3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.horizontal)
            
                Text("Courtesy of NASA") // Images from Nasa
                    .font(.caption)
                    .padding()
            }
            
            Divider()
                .padding(.horizontal)
        
            VStack {
                Text("What is Climate Change?")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top)
                
                Text("Climate change is the change in the Earth's weather patterns and temperatures over a long period of time.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("In fact, Earth's climate has been warming up and cooling down even before we humans got here.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("But recently, the planet is warming up much faster than it ever has in history.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                // Quick images for showing differences in climate in Alaska
                VStack {
                    VStack {
                        ZStack {
                            Image("glaciarBefore")
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 0.5, x: 3, y: 3)
                                .padding()
                            
                            Image("glaciarAfter")
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 0.5, x: 3, y: 3)
                                .opacity(opacity)
                                .padding()
                        }
                        .onReceive(VM.glaciarSequence) { _ in
                            if opacity == 1 {
                                VM.glaciarSequence.upstream.connect().cancel() // When opacity is 1, cancel timer subscription
                            } else {
                                opacity += 0.01 // Increment the opacity
                            }
                        }
                        
                        Text("1941 - 2004")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    .frame(height: 250)
                    .padding(.bottom)
                    
                    Text("Alaska's Muir Glaciar has changed a lot over several decades!")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    
                    Text("Images Courtesy of U.S Geological Survey")
                        .font(.caption) // Image from the USGS
                        .padding()
                }
                .background(Color.tabBarBackground)
                .cornerRadius(10)
                .shadow(radius: 0.5, x: 3, y: 3)
                .shadow(radius: 1)
                .padding()
                
                Divider()
                    .padding(.horizontal)
                
                Button {
                    stage = .causes // Next stage
                    play(sound: "Button.mp3")
                } label: {
                    Text("Why does it happen?")
                        .fontWeight(.bold)
                        .myButtonStyle()
                }
                .buttonStyle(.plain)
                .padding()
                
            }
        }
    }
}

struct Causes: View {
    
    @Binding var stage: LearnStages
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("What are the causes of Climate Change?")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .lineSpacing(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.vertical)
            
            VStack{
                Text("1. The Greenhouse Effect")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Image("greenhouseEffect")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(radius: 0.5, x: 3, y: 3)
                    .padding()
                
                Text("Courtesy of NASA/JPL-Caltech") // Images from Nasa
                    .font(.caption)
                
                Text("The greenhouse effect is a process that occurs when gases in the atmosphere trap heat from the Sun.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("These gases, such as Carbon Dioxide, are also called greenhouse gases and they cover the Earth like a blanket.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("The greenhouse effect itself is natural and makes Earth warm enough for us to live on.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            Divider()
                .padding(.horizontal)
            
            VStack {
                Text("2. Human Activities")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Image("humanActivities")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 0.5, x: 3, y: 3)
                    .padding()
                
                Text("Courtesy of NASA") // Images from Nasa
                    .font(.caption)
                
                Text("Human activities (such as burning fossil fuels to make electricity and heat, chopping down forests for land, using transportation, and farming livestock) releases a lot of greenhouse gases into the atmosphere. ")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("As more and more greenhouse gases are released, a lot of heat from the sun stays trapped in the atmosphere, causing the Earth to warm up.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            Button {
                stage = .effects
                play(sound: "Button.mp3")
            } label: {
                Text("What happens now?")
                    .fontWeight(.bold)
                    .myButtonStyle()
            }
            .buttonStyle(.plain)
            .padding()
            
        }
    }
}

struct Effects: View {
    
    @Binding var stage: LearnStages
    
    @State var currentPage = 0
    
    var body: some View {
        VStack {
            if currentPage == 0 {
                // Rising Temperatures
                VStack {
                    ScrollView(showsIndicators: false) {
                        Text("What are the effects of Climate Change?")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .padding(.vertical)
                        
                        Text("1. Rising Temperatures")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        Text("Due to more greenhouse gases, much more heat is trapped in the Earth's atmosphere. As a result, the Earth is getting hotter.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("Over the last 100 years, global air temperatures have increased about 2 degrees Fahrenheit and will continue to rise even more.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Image("warmEarth")
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 0.5, x: 3, y: 3)
                            .padding()
                        
                        Text("Courtesy of NASA")
                            .font(.caption)
                        
                        Button {
                            currentPage = 1
                            play(sound: "Button.mp3")
                        } label: {
                            Text("Next")
                                .fontWeight(.bold)
                                .myButtonStyle()
                        }
                        .buttonStyle(.plain)
                        .padding()
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if currentPage == 1 {
                // Extreme Weather
                VStack {
                    ScrollView(showsIndicators: false) {
                        Text("2. Extreme Weather")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
       
                            // Climate News TV Illustration
                            Image("hurricane")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .shadow(radius: 0.5, x: 3, y: 3)
                                .overlay(
                                    Text("News Today: More Hurricanes Expected")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .padding(5)
                                        .background(.white)
                                        .cornerRadius(5)
                                        .padding(10)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                        
                                )
                                .padding()
                                .background(Color.darkGray)
                                .cornerRadius(10)
                                .padding()
                                .shadow(radius: 0.5, x: 3, y: 3)
                                .shadow(radius: 1)
                  
                            VStack {
                                Text("Rising temperatures increase rainfall and flooding, making intense storms. Tropical storms like hurricanes will become stronger and happen much more often, resulting in a lot of damage to property and communities.")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.medium)
                                    .foregroundColor(.darkGray)
                                    .lineSpacing(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
  
                            }
                            
                            VStack {
                                Text("Droughts become longer and more frequent, which affects the growth food and crops. More droughts also lead to worse water quality, making water scarce for many people.")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.medium)
                                    .foregroundColor(.darkGray)
                                    .lineSpacing(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
  
                            }
                            
                            VStack {
                                Text("Hotter temperatures spread wildfires easily and lead to longer and more severe wildfire seasons in addition to scorching Heatwaves.")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.medium)
                                    .foregroundColor(.darkGray)
                                    .lineSpacing(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
  
                            }
       
                        
                        Button {
                            currentPage = 2
                            play(sound: "Button.mp3")
                        } label: {
                            Text("Next")
                                .fontWeight(.bold)
                                .myButtonStyle()
                        }
                        .buttonStyle(.plain)
                        .padding()
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if currentPage == 2 {
                // Rising Seas
                VStack {
                    ScrollView(showsIndicators: false) {
                        Text("3. Rising Sea Levels")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("Thermal expansion is when water expands when it's heated.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("As the oceans warm, the sea levels rise because it takes up more space. Melting ice and glaciars also contribute to the sea levels rising.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("The rising sea levels increase flooding and damage to coastal areas, affecting the people, property, and nature there. Overtime, small island nations may be fully submerged and many people would lose their homes.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        VStack {
                            Text("Not-so-fun fact:")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(.darkGray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.top, .horizontal])
                            
                            Text("According to NASA, sea levels may rise up to 8 feet (2.4 meters) by 2100.")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundColor(.darkGray)
                                .lineSpacing(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                        .background(Color.lightGreen)
                        .cornerRadius(10)
                        .shadow(radius: 0.5, x: 3, y: 3)
                        .padding()
                        
                        Image("seaLevels")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(radius: 0.5, x: 3, y: 3)
                            .padding()
                        
                        Text("Courtesy of U.S. Geological Survey")
                            .font(.caption)
                        
                        Button {
                            currentPage = 3
                            play(sound: "Button.mp3")
                        } label: {
                            Text("Next")
                                .fontWeight(.bold)
                                .myButtonStyle()
                        }
                        .buttonStyle(.plain)
                        .padding()
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if currentPage == 3 {
                // Species Loss
                VStack {
                    ScrollView(showsIndicators: false) {
                        Text("4. Species Loss")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("Due to climate change, many species are at risk of going extinct.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("Changing climates affect ecosystems and can make habitats uninhabitable, which forces animals to move away from current habitats to new ones.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("Some species may be able to adapt and survive, but many species will not.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("Invasive species may spread in some regions, which threatens the animals and plants already there.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("Climate change also makes the oceans more acidic, threatening the marine animals and plants like coral reefs.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .lineSpacing(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                 
                        VStack {
                            Text("Not-so-fun fact:")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(.darkGray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.top, .horizontal])
                            
                            Text("According to the United Nations, a million species could become extinct in a few decades.")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundColor(.darkGray)
                                .lineSpacing(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                        .background(Color.lightGreen)
                        .cornerRadius(10)
                        .shadow(radius: 0.5, x: 3, y: 3)
                        .padding()
                        
                        Button {
                            stage = .conclusion
                            play(sound: "Button.mp3")
                        } label: {
                            Text("What can we do?")
                                .fontWeight(.bold)
                                .myButtonStyle()
                        }
                        .buttonStyle(.plain)
                        .padding()
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .animation(.default, value: currentPage)
    }
}

struct Conclusion: View {
    
    var dismiss: DismissAction
    
    @State var isLightOn: Bool = true
    
    @State var isCarpool: Bool = false
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            Text("Final Thoughts")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .lineSpacing(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top)
            
            VStack {
                Text("Climate change is a big problem facing society today. The planet is warming up with great consequences.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("From rising seas to more frequent extreme weather, climate change is negatively impacting our lives and will affect future generations.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("It is very important that we act now and make better choices in our daily lives.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            Divider()
                .padding(.horizontal)
            
            VStack {
                Text("What You Can Do")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top)
                
                
                Text("Men and women in power make the big decisions to stop climate change on a large scale, but individual action is needed from everyone to truly make a difference.")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.darkGray)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom)
            }
            
            VStack {
                Text("Here are some habits you can start doing today!")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                // Save Energy
                HStack {
                    VStack(spacing: 10) {
                        Text("Save Energy")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Most electricity is still powered by fossil fuels, so turn the lights and any electronics off when not in use.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("P.S. switch the light off.")
                            .font(.system(.caption, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    Spacer()
                    
                    VStack {
                        VStack{
                            if isLightOn {
                                Image(systemName: "lightbulb.led.fill")
                                    .font(.system(size: 65))
                                    .foregroundColor(.yellow)
                                    .padding()
                                    .shadow(color: .yellow, radius: 20)
                                    .shadow(color: .yellow, radius: 20)
                                    
                                
                            } else {
                                Image(systemName: "lightbulb.led")
                                    .font(.system(size: 65))
                                    .foregroundColor(.pistachio)
                                    .padding()
                            }
                        }
                        .animation(.default, value: isLightOn)
                        
                        if isLightOn {
                            Image(systemName: "lightswitch.on")
                                .font(.system(size: 40))
                                .foregroundColor(.darkPistachio)
                                .padding(.horizontal)
                                .shadow(radius: 0.5)
                                .onTapGesture {
                                    play(sound: "Button.mp3")
                                    isLightOn.toggle()
                                }
                        } else {
                            Image(systemName: "lightswitch.off")
                                .font(.system(size: 40))
                                .foregroundColor(.darkPistachio)
                                .padding(.horizontal)
                                .shadow(radius: 0.5)
                                .onTapGesture {
                                    play(sound: "Button.mp3")
                                    isLightOn.toggle()
                                }
                        }
                    }
                    .padding()
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Divider()
                    .padding(.horizontal)
                
                // Save Water
                HStack {
                    VStack {
                        Image(systemName: "shower")
                            .font(.system(size: 65))
                            .foregroundColor(.pistachio)
                    }
                    .padding()
                    
                    VStack(spacing: 10) {
                        Text("Save Water")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Text("Save water and energy by taking shorter showers and don't leave faucets running.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.darkGray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Divider()
                    .padding(.horizontal)
                
                // Eat Less Meat
                HStack {
                    VStack(spacing: 10) {
                        Text("Eat Less Meat")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Farming livestock releases greenhouse gases. Try to eat less meat and more vegetables every week.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.darkGray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    VStack {
                        Image(systemName: "leaf")
                            .font(.system(size: 65))
                            .foregroundColor(.pistachio)
                    }
                    .padding()
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Divider()
                    .padding(.horizontal)
                
                // Reduce Car Usage
                HStack {
                    VStack {
                        if isCarpool {
                            Image(systemName: "car")
                                .font(.system(size: 65))
                                .foregroundColor(.darkPistachio)
                        } else {
                            Image(systemName: "car.2")
                                .font(.system(size: 60))
                                .foregroundColor(.red)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            play(sound: "Button.mp3")
                            isCarpool.toggle()
                        }
                    }
                    
                    VStack(spacing: 10) {
                        Text("Reduce Car Usage")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Text("Cars release a lot of Carbon Dioxide. Stick to public transport, biking, or even carpooling with a friend!")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.darkGray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Text("P.S. tap to carpool.")
                            .font(.system(.caption, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.darkGray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Button {
                    dismiss()
                    play(sound: "Button.mp3")
                } label: {
                    Text("Thank you")
                        .fontWeight(.bold)
                        .myButtonStyle()
                }
                .buttonStyle(.plain)
                .padding()
                
                
            }
        }
    }
}


// Instead of using illustrations, I made these views with SwiftUI for the News Illustrations in 'Intro' View

struct Newspaper1: View {
    var body: some View {
        VStack(spacing: 10) {
            //Content
            Text("World News") // News Outlet
                .font(.system(.largeTitle, design: .serif))
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            
                .background(Color.darkGray)
                
            Rectangle()
                .frame(height: 5)
                .foregroundColor(Color.darkGray)
            
            Text("Climate Change!") // News Title
                .font(.system(.largeTitle, design: .serif))
                .fontWeight(.black)
                .foregroundColor(.darkGray)
                .frame(maxWidth: .infinity)
            
            HStack {
                
                Rectangle() // Image Block
                
                VStack {
                    ForEach (0..<8) { _ in
                        Rectangle() // Text Block
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.top)
        }
        .padding()
        .background(Color.lightGray)
        .shadow(radius: 0.5)
        .padding()
    }
}

struct Newspaper2 : View {
    
    var body: some View {
        VStack(spacing: 10) {
            //Content
            Text("News Daily") // News Outlet
                .font(.system(.largeTitle, design: .serif))
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                
            Rectangle()
                .frame(height: 5)
                .foregroundColor(Color.red)
            
            Text("A Climate Crisis?") // News Title
                .font(.system(.largeTitle, design: .serif))
                .fontWeight(.black)
                .foregroundColor(.darkGray)
                .frame(maxWidth: .infinity)
            
            HStack {
                VStack {
                    ForEach(0..<7) { _ in
                        Rectangle() // Text Block
                    }
                }
                
                VStack {
                    ForEach(0..<7) { _ in
                        Rectangle() // Text Block
                    }
                }
                Rectangle() // Image Block
            }
            .foregroundColor(.gray)
            .padding(.top)
        }
        .padding()
        .background(.white)
        .shadow(radius: 0.5)
        .padding()
    }
    
}

struct Videos: View {
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .foregroundColor(.gray)
                
                VStack {
                    Text("Climate Change")
                        .font(.system(.headline, design: .serif))
                        .fontWeight(.semibold)
                        .foregroundColor(.darkGray)
                    
                    ForEach (0..<6) { _ in
                        Rectangle()
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Divider()
            
            HStack {
                VStack {
                    ForEach (0..<8) { _ in
                        Rectangle()
                    }
                }
                VStack {
                    ForEach (0..<8) { _ in
                        Rectangle()
                    }
                }
                Rectangle()
            }
            .foregroundColor(.gray)
        }
        .padding()
        .background(.white)
        .padding()
        .shadow(radius: 0.5)
    }
}

