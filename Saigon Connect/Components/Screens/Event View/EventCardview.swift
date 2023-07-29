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
    var place: Place = Place.topPlaces[0]

    var body: some View {
        ZStack(alignment: .top) {
            // Display a glass morphic card with the provided dark mode binding
            GlassMorphicCard(isDarkMode: $isDarkMode)
            VStack(alignment: .leading) {
                // Load image of item
                Image(place.image_url).resizable()
                    .opacity(0.9)
                    .frame(width:360,height:200)

                // Load name, description of item
                Text(place.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .foregroundColor(isDarkMode ? .white : .black)

                Text(place.short_description)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .font(.body)
                    .foregroundColor(isDarkMode ? .white : .black)

                // Spacing between description and rating
                Spacer()

                // Load rating, total rating, entrance fee of item
                HStack {
                    Text(String(place.ratings))
                        .font(.body)
                        .padding(.leading)
                        .foregroundColor(isDarkMode ? .white : .black)

                    // Custom struct that draws stars
                    StarsView(rating: place.ratings, maxRating: 5)

                    Text("(" + String(place.total_ratings.formatted()) + ")")
                        .font(.body)
                        .foregroundColor(isDarkMode ? .white : .black)
                    
                    Spacer()

                    Text(place.entrance_fee)
                        .padding(.trailing)
                        .opacity(0.9)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding(.bottom, 15)
            }
            .foregroundColor(.black)
            .cornerRadius(20)
            .frame(width: 360, height:360)

        }
    }
}

// preview for card view
struct Card_Views_Previews: PreviewProvider {
    static var previews: some View {
        EventCardView(isDarkMode: .constant(true))
    }

}