/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 1
  Author: Doan Huu Quoc
  ID: 3927776
  Created  date: 18/07/2023
  Last modified: 26/07/2023
  Acknowledgement: Please refer to ContentView.swift file to see references for image used
*/

import SwiftUI

struct SmallPlaceCardView: View {
    // check if the app is in dark mode
    @Binding var isDarkMode: Bool

    // initializer
    var place: Place = Place.topPlaces[6]

    var body: some View {
        // apply the glass morphism effect to the card
        ZStack(alignment: .top) {
            // Glass morphism card with the size of 180x270
            GlassMorphicCard(isDarkMode: $isDarkMode, width: 180, height: 270)

            // VStack to store the image, name, description, rating, and entrance fee of the place
            VStack(alignment: .leading) {
                Image(place.image_url)
                    .resizable()
                    .frame(width: 180, height: 110)
                    .foregroundColor(isDarkMode ? .white : .black)

                Text(place.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 5)
                    .foregroundColor(isDarkMode ? .white : .black)

                Text(place.short_description)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 5)
                    .font(.body)
                    .foregroundColor(isDarkMode ? .white : .black)

                Spacer()

                // HStack to store the rating and entrance fee of the place
                HStack {
                    StarsView(rating: place.ratings, maxRating: 5)
                        .padding(.leading, 5)
                        .font(.caption2)

                    Spacer()

                    Text(place.entrance_fee)
                        .font(.caption2)
                        .padding(.trailing, 5)
                        .foregroundColor(isDarkMode ? .white : .black)

                }
                .padding(.bottom)
                .padding(.horizontal)
            }
            .cornerRadius(20)
            .frame(width: 180, height: 270)
        }
    }
}

// preview for the small card view
struct small_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        SmallPlaceCardView(isDarkMode: .constant(true))
    }
}
