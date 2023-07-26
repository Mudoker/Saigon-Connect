//
//  Card_Views.swift
//  Saigon Connect
//
//  Created by quoc on 21/07/2023.
//

import SwiftUI

struct SmallCardView: View {
    //Make the gradient moving
    @State private var animateGradient = false
    @Binding var isDarkMode: Bool

    var place: Place = Place.topPlaces[6]
    var body: some View {
        
        ZStack(alignment: .top) {
            GlassMorphicCard(isDarkMode: $isDarkMode, width: 180, height: 270)
            
            VStack(alignment: .leading) {
                Image(place.image_url).resizable()
                    .frame(width:180,height:110)
                    .foregroundColor(isDarkMode ? .white : .black)

                Text(place.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading,5)
                    .foregroundColor(isDarkMode ? .white : .black)

                Text(place.short_description)
                    .multilineTextAlignment(.leading)
                    .padding(.leading,5)
                    .font(.body)
                    .foregroundColor(isDarkMode ? .white : .black)

                Spacer()
                HStack {
                    StarsView(rating: place.ratings, maxRating: 5)
                        .padding(.leading,5)
                        .font(.caption2)
                    Spacer()
                    Text(place.entrance_fee)
                        .font(.caption2)
                        .padding(.trailing,5)
                        .foregroundColor(isDarkMode ? .white : .black)

                    
                }.padding(.bottom)
                    .padding(.horizontal)
            }
            .cornerRadius(20)
            .frame(width: 180, height: 270)
        }
    }
}

struct small_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardView(isDarkMode: .constant(true))
    }
}
