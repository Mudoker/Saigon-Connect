/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 1
  Author: Doan Huu Quoc
  ID: 3927776
  Created  date: 18/07/2023
  Last modified: 26/07/2023
  Acknowledgement:
    Kavsoft. Glass Morphism SwiftUI - Glass Card Effect - Xcode 14 - SwiftUI Tutorials (Mar. 10, 2020). Accessed Jul. 20, 2023. [Online Video]. Available: https://www.youtube.com/watch?v=5jPmILEQygY&t=627s
    Ramis. "How to present accurate star rating using SwiftUI?" Stackoverflow.https://stackoverflow.com/questions/64379079/how-to-present-accurate-star-rating-using-swiftui (accessed Jul. 19, 2023).
*/

import SwiftUI
struct EventCardView: View {
    // Binding for checking dark mode
    @Binding var isDarkMode: Bool

    // Temporarily initialise a place
    var event: Event = Event.allEvents[1]

    var body: some View {
        ZStack(alignment: .top) {
            // Display a glass morphic card with the provided dark mode binding
            GlassMorphicCard(isDarkMode: $isDarkMode, width: 360, height: 400, opacity: 0.8)
            VStack(alignment: .leading) {
                // Load image of item
                Image(event.image_url).resizable()
                    .opacity(0.9)
                    .frame(width:360,height:200)

                // Load name, description of item
                Text(event.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .foregroundColor(isDarkMode ? .white : .black)

                Text(event.short_description)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .font(.body)
                    .foregroundColor(isDarkMode ? .white : .black)

                Spacer()
                
                // Load rating, total rating, entrance fee of item
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Date: ")
                                .padding(.leading)
                                .foregroundColor(isDarkMode ? .white : .black)
                            
                            Text(event.date)
                                .foregroundColor(isDarkMode ? .white : .black)
                        }
                        
                        HStack {
                            Text("Open:")
                                .padding(.leading)
                                .foregroundColor(isDarkMode ? .white : .black)

                            Text(event.opening_hours)
                                .font(.callout)
                                .foregroundColor(isDarkMode ? .white : .black)
                        }

                    }
                    
                    Spacer()

                    Text(event.entrance_fee)
                        .padding(.trailing)
                        .opacity(0.9)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding(.bottom, 15)
            }
            .foregroundColor(.black)
            .cornerRadius(20)
            .frame(width: 360, height:400)

        }
    }
}

// preview for card view
struct Event_Card_Views_Previews: PreviewProvider {
    static var previews: some View {
        EventCardView(isDarkMode: .constant(true))
    }

}
