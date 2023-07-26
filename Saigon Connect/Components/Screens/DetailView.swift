//
//  Detail_View.swift
//  Saigon Connect
//
//  Created by quoc on 20/07/2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct DetailView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @State private var animateGradient = false
    @Binding var isDetailView: Bool
    @State private var isMapView = false
    @State var place: Place = Place.topPlaces[0]
    @State private var imageOpacity: Float = 1
    @State private var scrollOffset: CGFloat = 0
    
    @State var background_light = LinearGradient(
        gradient: Gradient(colors: [Color(red: 1, green: 0.90, blue: 0.95), Color(red: 0.43, green: 0.84, blue: 0.98)]),
                startPoint: .top,
                endPoint: .bottom
            )
    @State var background_dark = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.33, green: 0.15, blue: 0.53), Color(red: 0.42, green: 0.21, blue: 0.61), Color(red: 0.50, green: 0.31, blue: 0.70)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                if !isMapView {
                    
                } else {
                    MapView()
                        .frame(height: 400)
                        .edgesIgnoringSafeArea(.all)
                }
                
                VStack(alignment: .leading) {
                    if !isMapView {
                        VStack(alignment: .leading) {
                            Text(place.category)
                                .padding(.horizontal)
                                .foregroundColor(isDarkMode ? .white : .black)

                                .padding(.top)
                            Text(place.name)
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .padding(.horizontal)
                                .foregroundColor(isDarkMode ? .white : .black)

                        }.frame(height: 125)

                    } else {
                        VStack{}.frame(height: 125)
                        
                    }
                    if !isMapView {
                        TopView(place: place, imageOpacity: $scrollOffset ,isMapView: isMapView)
                            .padding(.horizontal)
                            .zIndex(1)
                            .foregroundColor(isDarkMode ? .white : .black)
                            .frame(height: 180)
                    } else {
                        VStack{}.frame(height: 180)
                    }
                    

                    VStack(alignment: .center) {
                        ScrollView(showsIndicators: false) {
                            VStack {
                                HStack {
                                    Button {
                                        isMapView = false

                                    } label: {
                                        Image(systemName: "doc.circle").resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(isDarkMode ? .white : .black)

                                    }
                                    .padding(.trailing)
                                    Button {
                                        isMapView = true

                                    } label: {
                                        Image(systemName: "map.circle.fill").resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(isDarkMode ? .white : .black)

                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .frame(height: 100)
                                RatingOpenHour()
                                    .foregroundColor(isDarkMode ? .white : .black)

                                Text (place.full_description)
                                    .font(.body)
                                    .opacity(0.9)
                                    .padding(.horizontal)
                                    .foregroundColor(isDarkMode ? .white : .black)

                                
                                if place.popular_activities.count >= 1 {
                                    HStack {
                                        Text("Popular activiites")
                                            .padding([.horizontal, .top])
                                            .font(.title.bold())
                                            .foregroundColor(isDarkMode ? .white : .black)

                                        Spacer()
                                    }.frame(height: 20)
                                                                
                                    popularActivitiy(place: place).padding(.leading)
                                        .padding(.top,10)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                }
                                
                                if place.nearby_activities.count >= 1 {
                                    HStack {
                                        Text("Nearby")
                                            .padding([.horizontal, .top])
                                            .font(.title.bold())
                                            .foregroundColor(isDarkMode ? .white : .black)

                                        Spacer()
                                    }.frame(height: 20)
                                    
                                    nearbyActivity(place: place).padding(.leading)
                                        .padding(.top,10)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                }
                                
                                if place.reviews.count >= 1 {
                                    HStack {
                                        Text("Top reviews")
                                            .padding([.horizontal, .top])
                                            .font(.title.bold())
                                            .foregroundColor(isDarkMode ? .white : .black)

                                        Spacer()
                                    }.frame(height: 20)
                                                                
                                    reviewView(place: place).padding(.leading)
                                        .padding(.top,20)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                }
                                                                
                                    Spacer()
                                
     
                            }
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewOffsetKey.self,
                                    value: -$0.frame(in: .named("scroll")).origin.y)
                            })
                            .onPreferenceChange(ViewOffsetKey.self) {   scrollOffset = $0
                            }
                        }.coordinateSpace(name: "scroll")
                        
                        .padding(.top, -70)
                        Spacer()
                        expoloreMore(background: isDarkMode ? background_dark : background_light)
                            .foregroundColor(isDarkMode ? .white : .black)



                    }
                    .background(isDarkMode ? Color(red: 0.20, green: 0.20, blue: 0.20).clipShape(CustomTopBorder())
                        .edgesIgnoringSafeArea(.all).padding(.top, -70) :Color.white.clipShape(CustomTopBorder())
                        .edgesIgnoringSafeArea(.all).padding(.top, -70))
                    .shadow(radius: 20)
                    
                }
                .frame(width: geometry.size.width, alignment: .leading)
                
            }
            .background( isDarkMode ? Image("background_dark") : Image("background_light"))
            .zIndex(0)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onDisappear {
            isDetailView = false
        }
    }
}


struct Detail_View_Previews: PreviewProvider {
    @State static var isDetailView = false

    static var previews: some View {
        DetailView(isDetailView: $isDetailView)
    }
}

struct TopView: View {
    @State var isAnimation = false
    @State var place: Place = Place.allPlace[0]
    @Binding var imageOpacity: CGFloat
     var isMapView: Bool

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                if !isMapView {
                    Text("Entrence fee")
                        .fontWeight(.bold)
                        .frame(height: 5)
                    if (place.entrance_fee == "Free") {
                        Text(place.entrance_fee)
                            .font(.system(size: 30, weight: .bold))
                            .frame(height: 30)
                    }else {
                        Text(place.entrance_fee)
                            .font(.system(size: 25, weight: .bold))
                            .frame(height: 30)
                    }
                    
                } else {
                    VStack{}.frame(height: 35)
                }
                
            }
            .offset(y: isAnimation ? -50 : -75)
            
            Spacer()
            
            Image(place.image_url)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(imageOpacity == 0 ? 1 : calculateOpacity())
                .frame(width: 200, height: 200)
                .mask(Circle().scaleEffect(isAnimation ? 1 : 0.7))
                .shadow(radius: 40)
                .offset(y: isAnimation ? 0 : -35)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                isAnimation = true
            }
        }
    }
    func calculateOpacity()-> CGFloat{
        if (imageOpacity >= 0) {
            let opacity = 0.6 - imageOpacity/100
            return opacity
        }
        return 1
    }
}

struct CustomTopBorder: Shape {
    var radius = 35
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CustomTopLeftBorder: Shape {
    var radius = 35
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .topLeft, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CustomBottomBorder: Shape {
    var radius = 35
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct RatingOpenHour: View {
    @State var place: Place = Place.allPlace[0]
    var body: some View {
        HStack (alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("Ratings (" + String(place.total_ratings.formatted()) + ")")
                    .frame(height: 0 )
                    .bold()
                    .opacity(0.7)
                HStack() {
                    Text(String(place.ratings)).font(.body)
                    StarsView(rating: place.ratings, maxRating: 5, size: 16)
                    .font(.body)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Opening hours")
                    .bold()
                    .opacity(0.7)
                Text(place.opening_hours)
                    .font(.system(size: 16, weight: .bold))
            }
        }
        .padding(.horizontal)
    }
}

struct expoloreMore: View {
    @State var place: Place = Place.allPlace[0]
    var background: LinearGradient
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .font(.title2.bold())
            Text(place.address)
                .italic().font(.callout)
        }
        .padding(.leading)
        .edgesIgnoringSafeArea(.all)
        .frame(height: 100)
        .background(background)
        .clipShape(CustomTopLeftBorder(radius: 180))
    }
}


struct popularActivitiy: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @State var place: Place = Place.allPlace[0]
    @State var selectedIndexCat = 0
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 20) {
            ForEach(place.popular_activities, id: \.self) { activity in
                Text(activity)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 2 - 20)
                    .background(isDarkMode ? Color.gray.opacity(0.7) : Color.white.opacity(0.7))
                    .foregroundColor(isDarkMode ? Color.white : Color.black)
                    .cornerRadius(20)
            }
        }
    }
}


struct nearbyActivity: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @State var place: Place = Place.allPlace[0]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 20)], spacing: 20) {
                ForEach(place.nearby_activities.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: place.nearby_activities[index].image_url)
                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                            .padding(.leading)
                        Text(place.nearby_activities[index].event_name)
                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                        Spacer()
                        VStack {
                            StarsView(rating: place.nearby_activities[index].ratings, maxRating: 5)
                                .padding(.trailing)
                            Text( place.nearby_activities[index].fee)
                                .foregroundColor(isDarkMode ? Color.white : Color.black)

                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isDarkMode ? Color.gray.opacity(0.7) : Color.white.opacity(0.7))
                    .cornerRadius(20)
                }
            }
        }
    }
}

struct reviewView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @State var place: Place = Place.allPlace[0]
    var body: some View {
        ForEach(place.reviews.indices, id: \.self) { index in
            VStack {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(isDarkMode ? Color.white : Color.black)

                    VStack {
                        Text(place.reviews[index].reviewer_name)
                            .font(.title3)
                            .bold()
                            .foregroundColor(isDarkMode ? Color.white : Color.black)

                        Text(place.reviews[index].timestamp)
                            .opacity(0.6)
                            .foregroundColor(isDarkMode ? Color.white : Color.black)

                    }
                    Spacer()
                    HStack {
                        Text(String(place.reviews[index].given_stars))
                            .opacity(0.6)
                            .foregroundColor(isDarkMode ? Color.white : Color.black)

                        StarsView(rating: CGFloat(place.reviews[index].given_stars), maxRating: 5)
                    }
                    .padding(.horizontal)
                }
                Text(place.reviews[index].content)
                    .opacity(0.6)
                    .foregroundColor(isDarkMode ? Color.white : Color.black)
                Divider()
                    .foregroundColor(isDarkMode ? Color.white : Color.black)
            }
        }
    }
}
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
