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
struct PlaceCardView: View {
    // Binding for checking dark mode
    @Binding var isDarkMode: Bool
    var size: CGSize = CGSize(width: 360, height: 200)
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
                    .frame(width: size.width,height: size.height)

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
            .frame(width: size.width, height: size.width)

        }
    }
}

// creat a glass morphic card view
struct GlassMorphicCard: View {
    // Checking for darkmode
    @Binding var isDarkMode: Bool

    // default dimension for card
    @State var width: CGFloat = 360
    @State var height: CGFloat = 360
    @State var minWidth: CGFloat = 0
    @State var opacity: CGFloat = 0.65
    // default option for card
    @State var useMinWidth = false
    var body: some View {
        // custom dimension for card
        if useMinWidth {
            ZStack {
                // Apply glass morphic effect with the provided dark mode binding
                GlassMorphicCardView(isDarkMode: $isDarkMode)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .opacity(opacity)
            }
            .frame(minWidth: minWidth)
            .frame(height: height)
        } else {
            ZStack {
                // Apply glass morphic effect with the provided dark mode binding
                GlassMorphicCardView(isDarkMode: $isDarkMode)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .opacity(opacity)
            }
            .frame(width: width)
            .frame(height: height)
        }
    }
}

// creat a glass morphic card view
struct GlassMorphicCardView: UIViewRepresentable {
    // Checking for darkmode
    @Binding var isDarkMode: Bool

    // creates the UIView representation of the card
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: nil)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }

    // updates the UIView when the isDarkMode state changes
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        let effectStyle: UIBlurEffect.Style = isDarkMode ? .systemMaterialDark : .regular
        let newEffect = UIBlurEffect(style: effectStyle)
        uiView.effect = newEffect
    }
}

// Custom struct that draws stars
struct StarsView: View {
    // current rating
    let rating: CGFloat

    // max rating
    let maxRating: CGFloat

    // size of stars
    var size: CGFloat = 12

    var body: some View {
        // draw stars based on max rating
        let stars = HStack(spacing: 0) {
            ForEach(0..<Int(maxRating), id: \.self) { index in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: size, height: size)
                    }
                }

            // Fill stars based on current rating
            GeometryReader { geometry in
                    // calculate width of filled stars
                    let filledWidth = self.widthForValue(geometry.size.width, value: rating)

                    // calculate width of the rest of stars
                    let emptyWidth = self.widthForValue(geometry.size.width, value: (maxRating - rating))

                    // draw stars
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

    // calculate width of stars proportionally
    func widthForValue(_ totalWidth: CGFloat, value: CGFloat) -> CGFloat {
        return value * totalWidth / maxRating
    }
}

// preview for card view
struct Card_Views_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCardView(isDarkMode: .constant(true))
    }
}
