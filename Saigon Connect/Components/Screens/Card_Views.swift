//
//  Card_Views.swift
//  Saigon Connect
//
//  Created by quoc on 21/07/2023.
//

import SwiftUI

struct Card_Views: View {
    //Make the gradient moving
    @State private var animateGradient = false

    var place: Place = Place.topPlaces[0]
    var body: some View {
        
        ZStack(alignment: .top) {
            GlassMorphicCard()
            
            VStack(alignment: .leading) {
                Image(place.image_url).resizable()
                    .opacity(0.9)
                    .frame(width:360,height:200)
                
                Text(place.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                Text(place.short_description)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .font(.body)
                Spacer()
                HStack {
                    Text(String(place.ratings)).font(.body).padding(.leading)
                    StarsView(rating: place.ratings, maxRating: 5)
                    Text("(" + String(place.total_ratings.formatted()) + ")").font(.body)
                    Spacer()
                    Text(place.entrance_fee)
                        .padding(.trailing)
                    .opacity(0.9)
                }.padding(.bottom, 15)
            }
            .foregroundColor(.black)
            .cornerRadius(20)
            .frame(width: 360, height:340)
            
        }
    }
    @ViewBuilder
    func GlassMorphicCard() -> some View {
        ZStack {
            CustomBlurView(effect: .systemUltraThinMaterialDark) { view in
            }
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .opacity(0.65)
        }.frame(width: 360, height: 340)
    }
}

struct CustomBlurView: UIViewRepresentable{
    var effect: UIBlurEffect.Style
    var onChange: (UIVisualEffectView) -> ()
    
    func makeUIView(context: Context) ->  UIVisualEffectView{
        return  UIVisualEffectView(effect: UIBlurEffect (style: effect))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            onChange(uiView)
        }
    }
}


struct Card_Views_Previews: PreviewProvider {
    static var previews: some View {
        Card_Views()
    }
}

struct StarsView: View {
    let rating: CGFloat
    let maxRating: CGFloat
    var size: CGFloat = 12
    var body: some View {
        let text = HStack(spacing: 0) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
        }

        ZStack {
            text
            HStack(content: {
                GeometryReader(content: { geometry in
                    HStack(spacing: 0, content: {
                        let width1 = self.valueForWidth(geometry.size.width, value: rating)
                        let width2 = self.valueForWidth(geometry.size.width, value: (maxRating - rating))
                        Rectangle()
                            .frame(width: width1, height: geometry.size.height, alignment: .center)
                            .foregroundColor(.yellow)
                        
                        Rectangle()
                            .frame(width: width2, height: geometry.size.height, alignment: .center)
                            .foregroundColor(.gray)
                    })
                })
                .frame(width: size * maxRating, height: size, alignment: .trailing)
            })
            .mask(
                text
            )
        }
        .frame(width: size * maxRating, height: size, alignment: .leading)
    }
    
    func valueForWidth(_ width: CGFloat, value: CGFloat) -> CGFloat {
        value * width / maxRating
    }
}
