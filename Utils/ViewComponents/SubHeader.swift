/*
 
 - This is the Sub Header, which is used in the sub views
 
*/

import SwiftUI

struct SubHeader: View {
    
    var dismiss: DismissAction
    let title: String
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
               Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.headline)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(180))
                    .padding()
                    .background(Color.pistachio)
                    .cornerRadius(20)
                    .shadow(radius: 0.5, x: 3, y: 3)
                    .padding()
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            Text(title)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .shadow(radius: 1)
                .padding()
        }
        .background(Color.darkPistachio)
    }
}
