/*
 
 - This is the tab button, which is used in my custom implementation of the tab bar
 
*/

import SwiftUI

struct TabButton: View {
    
    @Binding var currentTab: tabs
    
    let image: String
    let color: Color
    let tab: tabs
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(self.currentTab == self.tab ? .darkPistachio : .clear)
                    .frame(width: proxy.size.width/2, height: 3)
                
                Image(systemName: image)
                    .font(.system(size: 30))
                    .foregroundColor(self.currentTab == self.tab ? color : .gray)
                    .animation(.easeOut(duration: 0.2), value: currentTab)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.currentTab = self.tab
        }
    }
}
