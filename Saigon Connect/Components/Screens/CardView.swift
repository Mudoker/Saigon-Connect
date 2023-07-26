//
//  Card_Views.swift
//  Saigon Connect
//
//  Created by quoc on 21/07/2023.
//
import SwiftUI
struct CardView: View {
    @State private var animateGradient = false
    @Binding var isDarkMode: Bool
    var place: Place = Place.topPlaces[0]
    var body: some View {
        ZStack(alignment: .top) {
            GlassMorphicCard(isDarkMode: $isDarkMode)
            VStack(alignment: .leading) {
                Image(place.image_url).resizable()
                .opacity(0.9)
                .frame(width:360,height:200)
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
                Spacer()
                HStack {
                    Text(String(place.ratings)).font(.body).padding(.leading)
                    .foregroundColor(isDarkMode ? .white : .black)
                    StarsView(rating: place.ratings, maxRating: 5)
                    Text("(" + String(place.total_ratings.formatted()) + ")").font(.body)
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
            .frame(width: 360, height:340)

        }
    }

}
struct GlassMorphicCard: View {
    @Binding var isDarkMode: Bool
    @State var width: CGFloat = 360
    @State var height: CGFloat = 340
    @State var minWidth: CGFloat = 0
    @State var useMinWidth = false
    var body: some View {
        if useMinWidth {
            ZStack {
                GlassMorphicCardView(isDarkMode: $isDarkMode)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .opacity(0.65)
            }
            .frame(minWidth: minWidth)
            .frame(height: height)
        } else {
            ZStack {
                GlassMorphicCardView(isDarkMode: $isDarkMode)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .opacity(0.65)
            }
            .frame(width: width)
            .frame(height: height)
            
        }
        
        
    }
}

struct GlassMorphicCardView: UIViewRepresentable {
    @Binding var isDarkMode: Bool

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: nil)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        let effectStyle: UIBlurEffect.Style = isDarkMode ? .systemMaterialDark : .regular
        let newEffect = UIBlurEffect(style: effectStyle)
        uiView.effect = newEffect
    }
}

struct Card_Views_Previews: PreviewProvider {
    static var previews: some View {
        CardView(isDarkMode: .constant(true))
    }

}

struct StarsView: View {
    let rating: CGFloat
    let maxRating: CGFloat
    var size: CGFloat = 12

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<Int(maxRating), id: \.self) { index in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: size, height: size)
                    }
                }

            GeometryReader { geometry in
                    let filledWidth = self.widthForValue(geometry.size.width, value: rating)
                    let emptyWidth = self.widthForValue(geometry.size.width, value: (maxRating - rating))
                    HStack(spacing: 0) {
                        Rectangle()
                            .frame(width: filledWidth, height: geometry.size.height)
                            .foregroundColor(.yellow)

                        Rectangle()
                            .frame(width: emptyWidth, height: geometry.size.height)
                            .foregroundColor(.gray)
                    }
                }
                .frame(width: size * maxRating, height: size)
                .mask(stars)
    }

    func widthForValue(_ totalWidth: CGFloat, value: CGFloat) -> CGFloat {
        return value * totalWidth / maxRating
    }
}
