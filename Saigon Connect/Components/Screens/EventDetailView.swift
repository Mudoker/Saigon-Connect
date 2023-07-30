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
    Please refer to EventView.swift file to see references for images used
    Refer to PlaceDetailView for references on codes used
*/

import SwiftUI
import CoreLocation
import MapKit

struct EventDetailView: View {
    // Shared variable to control the dark mode
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    // Shared variable to control the detail view
    @Binding var isEventDetailView: Bool

    // toggle the map view
    @State private var isMapView = false

    // Initialize the place variable
    @State var event: Event = Event.allEvents[5]

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

    @State var titleOpacity: CGFloat = 1
    
    var body: some View {

        // Geometry reader to get the get the scroll offset
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                // Map view
                MapView(coordinate: CLLocationCoordinate2D(latitude: event.location[0], longitude: event.location[1]))
                    .frame(height: 400)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isMapView ? 1.0 : 0) // if isMapView is true, show the map view, otherwise, hide it
                
                // Detail view
                VStack(alignment: .leading) {
                    // show the name and category
                    VStack(alignment: .leading) {
                        Text(event.category)
                            .padding(.horizontal)
                            .foregroundColor(isDarkMode ? .white : .black)
                            .padding(.top)
                        Text(event.name)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .padding(.horizontal)
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                    .frame(height: 145)
                    .opacity(!isMapView ? 1.0 : 0) // if isMapView is false, show the name and category, otherwise, hide it

                    // only show the top view if isMapView is false
                    if !isMapView {
                        EventTopView(event: event, imageOpacity: $scrollOffset ,isMapView: isMapView)
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
                                .padding(.top)
                                .padding(.horizontal)
                                .frame(height: 100)

                                // show rating and opening hours
                                EventRatingOpenHour(event: event)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .padding(.bottom)
                                
                                // show the description
                                Text (event.full_description)
                                    .font(.body)
                                    .opacity(0.9)
                                    .padding(.horizontal)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                
                                if event.popular_activities.count >= 1 {
                                    HStack {
                                        Text("Popular activities")
                                            .padding([.horizontal, .top])
                                            .font(.title.bold())
                                            .foregroundColor(isDarkMode ? .white : .black)

                                        Spacer()
                                    }
                                    .frame(height: 20)

                                    // call the popular activity view
                                    // show the popular activities
                                    // use lazy grid to enhance the performance
                                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 20) {
                                        ForEach(event.popular_activities, id: \.self) { activity in
                                            Text(activity)
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width / 2 - 20)
                                                .background(isDarkMode ? Color.gray.opacity(0.7) : Color.white.opacity(0.7))
                                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                                                .cornerRadius(20)
                                        }
                                    }
                                    .padding(.leading)
                                    .padding(.top,20)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                }
                                
                                HStack {
                                    Text("Why join us?")
                                        .padding(.horizontal)
                                        .font(.title.bold())
                                        .foregroundColor(isDarkMode ? .white : .black)
                                        .padding(.top, 55)
                                    Spacer()
                                }
                                .frame(height: 20)
                                
                                Text(event.reason)
                                    .font(.body)
                                    .opacity(0.9)
                                    .padding(.horizontal)
                                    .padding(.top, 35)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                
                                HStack {
                                    Text("Organiser")
                                        .padding(.horizontal)
                                        .padding(.top, 55)
                                        .font(.title.bold())
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                }
                                .frame(height: 20)
                                
                                HStack {
                                    Text(event.host)
                                        .font(.body)
                                        .opacity(0.9)
                                        .padding(.top, 35)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
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
                        EventExpoloreMore( event: event, background: isDarkMode ? background_dark : background_light)
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
            isEventDetailView = false // turn off the detail view when it is closed
        }
    }
}

// Top view
struct EventTopView: View {
    // toggle animation
    @State var isAnimation = false
    
    // Initialize the place variable
    @State var event: Event = Event.allEvents[0]

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

                if (event.entrance_fee == "Free") {
                    Text(event.entrance_fee)
                        .opacity(imageOpacity == 0 ? 1 : calculateOpacity())
                        .font(.system(size: 30, weight: .bold))
                        .frame(height: 30)
                } else {
                    Text(event.entrance_fee)
                        .opacity(imageOpacity == 0 ? 1 : calculateOpacity())
                        .font(.system(size: 23, weight: .bold))
                        .frame(height: 30)
                }
                
                Link(destination: URL(string: event.link)!) {
                    Text("Read more")
                        .underline()
                        .foregroundColor(.blue)
                }
                .opacity(imageOpacity == 0 ? 1 : calculateOpacity())
            }
            .offset(y: isAnimation ? -50 : -75) // move the text down when the animation is on
            
            Spacer()
            
            Image(event.image_url)
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
// Rating and opening hours view
struct EventRatingOpenHour: View {
    // Initialize the place variable
    @State var event: Event = Event.allEvents[0]

    var body: some View {
        VStack(alignment: .trailing) {

            HStack (alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Date")
                        .bold()
                        .opacity(0.7)
                        
                    Text(event.date)
                        .font(.system(size: 16, weight: .bold))
                }
                Spacer()

                // show the opening hours
                VStack(alignment: .trailing) {
                    Text("Opening hours")
                        .bold()
                        .opacity(0.7)
                        
                    Text(event.opening_hours)
                        .font(.system(size: 16, weight: .bold))
                }
            }
            .padding(.horizontal)
        }
    }
}

// explore more view
struct EventExpoloreMore: View {
    // Initialize the place variable
    @State var event: Event = Event.allEvents[1]

    // background color
    var background: LinearGradient

    var body: some View {
        // show address
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .font(.title2.bold())
                .padding(.leading)

            Text(event.address)
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

// preview
struct Event_View_Previews: PreviewProvider {
    @State static var isEventDetailView = false

    static var previews: some View {
        EventDetailView(isEventDetailView: $isEventDetailView)
    }
}
