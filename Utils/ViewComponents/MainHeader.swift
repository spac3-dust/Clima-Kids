/*
 
 - This is the Main Header, which is used in the main tabs
 
*/


import SwiftUI

struct MainHeader: View {
    
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(title)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
                .shadow(radius: 1)
            
            Text(description)
                .font(.system(.title3, design: .rounded))
                .fontWeight(.semibold)
                .shadow(radius: 1)
    
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color.pistachio)
    }
}
