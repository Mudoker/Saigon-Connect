//
//  Card_Views.swift
//  Saigon Connect
//
//  Created by quoc on 21/07/2023.
//

import SwiftUI

struct small_Card_View: View {
    //Make the gradient moving
    @State private var animateGradient = false

    var place: Place = Place.topPlaces[6]
    var body: some View {
        
        ZStack(alignment: .top) {
            GlassMorphicCard()
            
            VStack(alignment: .leading) {
                Image(place.image_url).resizable()
                    .cornerRadius(30)
                    .opacity(0.9)
                    .frame(width:180,height:110)
                
                Text(place.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading,5)
                Text(place.short_description)
                    .multilineTextAlignment(.leading)
                    .padding(.leading,5)
                    .font(.caption)
                    .opacity(0.9)
                Spacer()
                HStack {
                    StarsView(rating: place.ratings, maxRating: 5)
                        .padding(.leading,5)
                        .font(.caption2)
                    Spacer()
                    Text(place.entrance_fee)
                        .font(.caption2)
                        .padding(.trailing,5)
                    .opacity(0.9)
                    
                }.padding(.bottom)
            }
            .foregroundColor(.white)
            .cornerRadius(30)
            .frame(width: 180, height: 270)
        }
    }
    @ViewBuilder
    func GlassMorphicCard() -> some View {
        ZStack {
            CustomBlurView(effect: .systemUltraThinMaterialDark) { view in
            }
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .opacity(0.65)
        }.frame(width: 180, height: 270)
    }
}

struct small_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        small_Card_View()
    }
}
