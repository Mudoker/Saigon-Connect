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
    Credo Academy. How to improve the UX with SwiftUI - Beginner iOS App Development Tutorial - Part 9 (Mar. 8, 2021). Accessed Jul. 19, 2023. [Online Video]. Available: https://www.youtube.com/watch?v=zfPqWO_Syzs&t=365s
    Please refer to ContentView.swift file to see references for image used
*/

import SwiftUI
import CoreLocation
import MapKit

struct PlaceDetailView: View {
    // Shared variable to control the dark mode
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    // Shared variable to control the detail view
    @Binding var isDetailView: Bool

    // toggle the map view
    @State private var isMapView = false

    // Initialize the place variable
    @State var place: Place = Place.topPlaces[0]

    // Initialize the image opacity for animation
    @State private var imageOpacity: Float = 1

    // Variable for animation (the more you scroll, the more the image will be hidden)
    @State private var scrollOffset: CGFloat = 0
    
    // background color for light and dark mode (bottom part of the screen)
    @State var background_light = LinearGradient(
        gradient: 
                Gradient(colors: [Color(red: 1, green: 0.90, blue: 0.95), Color(red: 0.43, green: 0.84, blue: 0.98)]),
                startPoint: .top,
                endPoint: .bottom
            )
    @State var background_dark = LinearGradient(
        gradient: 
                Gradient(colors: [Color(red: 0.33, green: 0.15, blue: 0.53), Color(red: 0.42, green: 0.21, blue: 0.61), Color(red: 0.50, green: 0.31, blue: 0.70)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

    var body: some View {

        // Geometry reader to get the get the scroll offset
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                // Map view
                MapView(coordinate: CLLocationCoordinate2D(latitude: place.location[0], longitude: place.location[1]))
                    .frame(height: 400)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isMapView ? 1.0 : 0) // if isMapView is true, show the map view, otherwise, hide it
                
                // Detail view
                VStack(alignment: .leading) {
                    // show the name and category
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
                    }
                    .frame(height: 145)
                    .opacity(!isMapView ? 1.0 : 0) // if isMapView is false, show the name and category, otherwise, hide it

                    // only show the top view if isMapView is false
                    if !isMapView {
                        TopView(place: place, imageOpacity: $scrollOffset ,isMapView: isMapView)
                            .padding(.horizontal)
                            .zIndex(1) // put the top view on top of the map view
                            .foregroundColor(isDarkMode ? .white : .black)
                            .frame(height: 180)
                    } else {
                        VStack{

                        }
                        .frame(height: 180) // an empty view to keep the height of the top view
                    }

                    // main content
                    VStack(alignment: .center) {
                        // scroll view to show the main content
                        ScrollView(showsIndicators: false) {
                            VStack {
                                // Buttons to toggle between map view and detail view
                                HStack {
                                    Button {
                                        DispatchQueue.main.async {
                                            isMapView = false // turn off the map view
                                        }

                                    } label: {
                                        Image(systemName: "doc.circle").resizable()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                    }
                                    .padding(.trailing, 20)
                                    
                                    Button {
                                        DispatchQueue.main.async {
                                            isMapView = true // turn on the map view
                                        }
                                    } label: {
                                        Image(systemName: "map.circle.fill").resizable()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(isDarkMode ? .white : .black)

                                    }
                                    Spacer()
                                }
                                .padding(.top, 22)
                                .padding(.horizontal)
                                .frame(height: 100)

                                // show rating and opening hours
                                RatingOpenHour(place: place)
                                    .foregroundColor(isDarkMode ? .white : .black)

                                // show the description
                                Text (place.full_description)
                                    .font(.body)
                                    .opacity(0.9)
                                    .padding(.horizontal)
                                    .foregroundColor(isDarkMode ? .white : .black)

                                // show the popular activities
                                if place.popular_activities.count >= 1 {
                                    HStack {
                                        Text("Popular activities")
                                            .padding([.horizontal, .top])
                                            .font(.title.bold())
                                            .foregroundColor(isDarkMode ? .white : .black)

                                        Spacer()
                                    }
                                    .frame(height: 20)

                                    // call the popular activity view                        
                                    popularActivitiy(place: place)
                                        .padding(.leading)
                                        .padding(.top,10)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                
                                // show the nearby activities
                                if place.nearby_activities.count >= 1 {
                                    HStack {
                                        Text("Nearby")
                                            .padding(.horizontal)
                                            .font(.title.bold())
                                            .padding(.top, 45)
                                            .foregroundColor(isDarkMode ? .white : .black)

                                        Spacer()
                                    }
                                    .padding(.vertical)
                                    .frame(height: 20)
                                    
                                    // call the nearby activity view
                                    nearbyActivity(place: place)
                                        .padding(.leading)
                                        .padding(.top,35)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                
                                // show the reviews
                                if place.reviews.count >= 1 {
                                    HStack {
                                        Text("Top reviews")
                                            .padding(.horizontal)
                                            .padding(.top, 45)
                                            .font(.title.bold())
                                            .foregroundColor(isDarkMode ? .white : .black)

                                        Spacer()
                                    }
                                    .padding(.vertical)
                                    .frame(height: 20)
            
                                    // call the review view                
                                    reviewView(place: place)
                                        .padding(.leading)
                                        .padding(.top,35)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }                                                         
                                Spacer()
                            }
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewOffsetKey.self,
                                    value: -$0.frame(in: .named("scroll")).origin.y)
                                }
                            )
                            .onPreferenceChange(ViewOffsetKey.self) {   
                                scrollOffset = $0
                            }
                        }
                        .coordinateSpace(name: "scroll")
                        .padding(.top, (-90 - scrollOffset/2) >= -220 ? -90 - scrollOffset/2 : -220) // Adjust the padding based on scrollOffset
                        
                        Spacer()

                        // show the explore more view
                        expoloreMore( place: place, background: isDarkMode ? background_dark : background_light)
                            .foregroundColor(isDarkMode ? .white : .black)



                    }
                    .background(
                        isDarkMode ?
                        Color(red: 0.20, green: 0.20, blue: 0.20)
                            .clipShape(CustomTopBorder())
                            .edgesIgnoringSafeArea(.all)
                            .padding(.top, (-90 - scrollOffset/2) >= -220 ? -90 - scrollOffset/2 : -220) // Adjust the padding based on scrollOffset
                        :
                        Color.white
                            .clipShape(CustomTopBorder())
                            .edgesIgnoringSafeArea(.all)
                            .padding(.top, (-90 - scrollOffset/2) >= -220 ? -90 - scrollOffset/2 : -220) // Adjust the padding based on scrollOffset
                    )
                    .shadow(radius: 20)
                    
                }
                .frame(width: geometry.size.width, alignment: .leading)
                
            }
            .background( isDarkMode ? Image("background_dark") : Image("background_light"))
            .zIndex(0) // put the background on the bottom
        }
        .edgesIgnoringSafeArea(.bottom)
        .onDisappear {
            isDetailView = false // turn off the detail view when it is closed
        }
    }
}

// Top view
struct TopView: View {
    // toggle animation
    @State var isAnimation = false

    // Initialize the place variable
    @State var place: Place = Place.allPlace[0]

    // Initialize the image opacity for animation
    @Binding var imageOpacity: CGFloat

    // check if the map view is on or off
    var isMapView: Bool

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                
                Text("Entrence fee")
                    .fontWeight(.bold)
                    .opacity(imageOpacity == 0 ? 1 : calculateOpacity())
                
                if (place.entrance_fee == "Free") {
                    Text(place.entrance_fee)
                        .font(.system(size: 30, weight: .bold))
                        .frame(height: 30)
                        .opacity(imageOpacity == 0 ? 1 : calculateOpacity())
                }else {
                    Text(place.entrance_fee)
                        .font(.system(size: 23, weight: .bold))
                        .frame(height: 30)
                        .opacity(imageOpacity == 0 ? 1 : calculateOpacity())
                }
            }
            .offset(y: isAnimation ? -50 : -75) // move the text down when the animation is on
            
            Spacer()
            
            Image(place.image_url)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(imageOpacity == 0 ? 1 : calculateOpacity())
                .frame(width: 200, height: 200)
                .mask(Circle().scaleEffect(isAnimation ? 1 : 0.7)) // mask the image with a circle with scale effect
                .shadow(radius: 40)
                .offset(y: isAnimation ? 0 : -35) // move the image down when the animation is on
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                isAnimation = true // turn on the animation
            }
        }
    }

    // calculate the opacity of the image
    func calculateOpacity()-> CGFloat{
        // if the imageOpacity is greater than 0, calculate the opacity
        // To avoid the error when the imageOpacity is less than 0
        if (imageOpacity >= 0) {
            let opacity = 0.6 - imageOpacity/100
            return opacity
        }
        return 1
    }
}

// Custom shape for the top border
struct CustomTopBorder: Shape {
    // radius of the corner
    var radius = 35

    // draw the shape
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Custom shape for the top left border
struct CustomTopLeftBorder: Shape {
    // radius of the corner
    var radius = 35

    // draw the shape
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .topLeft, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Custom shape for the bottom border
struct CustomBottomBorder: Shape {
    // radius of the corner
    var radius = 35

    // draw the shape
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Rating and opening hours view
struct RatingOpenHour: View {
    // Initialize the place variable
    @State var place: Place = Place.allPlace[0]

    var body: some View {
        HStack (alignment: .bottom) {
            VStack(alignment: .leading) {
                // show the total ratings
                Text("Ratings (" + String(place.total_ratings.formatted()) + ")")
                    .frame(height: 0 )
                    .bold()
                    .opacity(0.7)

                // show the stars
                HStack() {
                    Text(String(place.ratings))
                        .font(.body)

                    // call the stars view
                    StarsView(rating: place.ratings, maxRating: 5, size: 16)
                        .font(.body)
                }
            }
            Spacer()

            // show the opening hours
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

// explore more view
struct expoloreMore: View {
    // Initialize the place variable
    @State var place: Place = Place.allPlace[1]

    // background color
    var background: LinearGradient

    var body: some View {
        // show address
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .font(.title2.bold())
                .padding(.leading)

            Text(place.address)
                .italic()
                .font(.callout)

            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .frame(height: 100)
        .background(background)
        .clipShape(CustomTopLeftBorder(radius: 180))
    }
}

// popular activity view
struct popularActivitiy: View {
    // check if the dark mode is on or off
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    // Initialize the place variable
    @State var place: Place = Place.allPlace[0]

    var body: some View {
        // show the popular activities
        // use lazy grid to enhance the performance
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

// nearby activity view
struct nearbyActivity: View {
    // check if the dark mode is on or off
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    // Initialize the place variable
    @State var place: Place = Place.allPlace[0]
    
    var body: some View {
        // show the nearby activities
        ScrollView {
            // use lazy grid to enhance the performance
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 20)], spacing: 20) {
                ForEach(place.nearby_activities.indices, id: \.self) { index in
                    HStack {
                        // show the image and name of the activity
                        Image(systemName: place.nearby_activities[index].image_url)
                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                            .padding(.leading)

                        Text(place.nearby_activities[index].event_name)
                            .foregroundColor(isDarkMode ? Color.white : Color.black)

                        Spacer()

                        // show the rating and fee
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

// review view
struct reviewView: View {
    // check if the dark mode is on or off
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    // Initialize the place variable
    @State var place: Place = Place.allPlace[0]

    var body: some View {
        // show the reviews
        ForEach(place.reviews.indices, id: \.self) { index in
            VStack (alignment: .leading) {
                // show the reviewer name, timestamp and stars
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(isDarkMode ? Color.white : Color.black)

                    VStack (alignment: .leading) {
                        Text(place.reviews[index].reviewer_name)
                            .font(.title3)
                            .bold()
                            .foregroundColor(isDarkMode ? Color.white : Color.black)

                        Text(place.reviews[index].timestamp)
                            .opacity(0.6)
                            .foregroundColor(isDarkMode ? Color.white : Color.black)

                    }
                    Spacer()

                    // call the stars view
                    HStack {
                        Spacer()

                        StarsView(rating: CGFloat(place.reviews[index].given_stars), maxRating: 5)
                    }
                    .padding(.horizontal)
                }

                // show the review content
                Text(place.reviews[index].content)
                    .opacity(0.6)
                    .foregroundColor(isDarkMode ? Color.white : Color.black)

                Divider()
                    .foregroundColor(isDarkMode ? Color.white : Color.black)
            }
        }
    }
}

// struct to get the offset of the scroll view
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

// preview
struct Detail_View_Previews: PreviewProvider {
    @State static var isDetailView = false

    static var previews: some View {
        PlaceDetailView(isDetailView: $isDetailView)
    }
}
