//
//  Detail_View.swift
//  Saigon Connect
//
//  Created by quoc on 20/07/2023.
//

import SwiftUI


struct Detail_View: View {
    @State private var animateGradient = false
    @Binding var isDetailView: Bool
    @State private var isMapView = false
    @State var place: Place = Place.allPlace[0]

    @State private var background = LinearGradient(
        gradient: Gradient(colors: [Color(red: 1, green: 0.90, blue: 0.95), Color(red: 0.43, green: 0.84, blue: 0.98)]),
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                background.edgesIgnoringSafeArea(.all) // Apply the background gradient to the ZStack
                
                VStack(alignment: .leading) {
                    if !isMapView {
                        Text(place.category)
                            .padding(.horizontal)
                            .frame(height: 5)
                        Text(place.name)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .padding(.horizontal)
                            .frame(height: 100)

                    } else {
                        VStack{}.frame(height: 5)
                        VStack{}.frame(height: 100)
                        
                    }
                    
                    Top_View(place: place, isMapView: isMapView)
                        .padding(.horizontal)
                        .zIndex(1)
                    VStack(alignment: .center) {
                        ScrollView(showsIndicators: false) {
//                            VStack{}.frame(height: 100)
                            HStack {
                                Button {
                                    isMapView = false

                                } label: {
                                    Image(systemName: "doc.circle").resizable()
                                        .frame(width: 50, height: 50).foregroundColor(.black)
                                }
                                .padding(.trailing)
                                Button {
                                    isMapView = true

                                } label: {
                                    Image(systemName: "map.circle.fill").resizable()
                                        .frame(width: 50, height: 50).foregroundColor(.black)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            .frame(height: 100)
                        
                            
                            ratings_open_hour()
                            Text (place.full_description)
                                .font(.body)
                                .opacity(0.7)
                                .padding(.horizontal)
                            
                            HStack {
                                Text("Popular activiites")
                                    .padding([.horizontal, .top])
                                    .font(.title.bold())
                                Spacer()
                            }.frame(height: 20)
                                                        
                            popular_activities(place: place).padding(.leading)
                                .padding(.top,10)
                            
                            HStack {
                                Text("Nearby")
                                    .padding([.horizontal, .top])
                                    .font(.title.bold())
                                Spacer()
                            }.frame(height: 20)
                            
                            nearby_activities(place: place).padding(.leading)
                                .padding(.top,10)
 
                        }
                        .padding(.top, -100)
                        Spacer()
                        expolore_more(background: background)

                    }
                    .background(Color.white.clipShape(Custom_Top_Border()).edgesIgnoringSafeArea(.all).padding(.top, -100))
                    .shadow(radius: 20)
                    
                }
                .frame(width: geometry.size.width, alignment: .leading)
                
            }.zIndex(0)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onDisappear {
            isDetailView = false
        }
    }
}


struct Detail_View_Previews: PreviewProvider {
    @State static var isDetailView = true // Provide a binding here

    static var previews: some View {
        Detail_View(isDetailView: $isDetailView)
    }
}

struct Top_View: View {
    @State var isAnimation = false
    @State var place: Place = Place.allPlace[0]
     var isMapView: Bool

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                if !isMapView {
                    Text("Price")
                        .fontWeight(.bold)
                        .frame(height: 5)
                    Text(place.entrance_fee)
                        .font(.system(size: 30, weight: .bold))
                        .frame(height: 30)
                } else {
                    VStack{}.frame(height: 35)
                }
                
            }
            .offset(y: isAnimation ? -50 : -75)
            
            Spacer()
            
            Image(place.image_url)
                .resizable()
                .aspectRatio(contentMode: .fill)
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
}

struct Custom_Top_Border: Shape {
    var radius = 35
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Custom_TopLeft_Border: Shape {
    var radius = 35
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .topLeft, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ratings_open_hour: View {
    @State var place: Place = Place.allPlace[0]
    var body: some View {
        HStack (alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("Ratings (" + String(place.total_ratings.formatted()) + ")")
                    .frame(height: 0 )
                    .bold()
                    .opacity(0.5)
                HStack() {
                    Text(String(place.ratings)).font(.body)
                    StarsView(rating: place.ratings, maxRating: 5,size: 16)
                    .font(.body)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Opening hours")
                    .bold()
                    .opacity(0.5)
                Text(place.opening_hours)
                    .font(.system(size: 16, weight: .bold))
            }
        }
        .padding(.horizontal)
    }
}

struct expolore_more: View {
    @State var place: Place = Place.allPlace[0]
    var background: LinearGradient
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .font(.title2.bold())
            Text(place.address)
                .italic().font(.callout)
            Spacer()
            
        }
        .padding(.horizontal)
        .edgesIgnoringSafeArea(.all)
        .frame(height: 100)
//        .frame(maxHeight: .infinity)
        .background(background)
        .clipShape(Custom_TopLeft_Border(radius: 180))
    }
}


struct popular_activities: View {
    @State var place: Place = Place.allPlace[0]
    @State var selectedIndexCat = 0
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 20) {
            ForEach(place.popular_activities, id: \.self) { activity in
                Text(activity)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 2 - 20)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                     // Adjust the width based on the screen size and spacing
            }
        }
    }
}


struct nearby_activities: View {
    @State var place: Place = Place.allPlace[0]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 20)], spacing: 20) {
                ForEach(place.nearby_activities.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: place.nearby_activities[index].image_url)
                            .foregroundColor(.black)
                            .padding(.leading)
//                        Spacer()
                        Text(place.nearby_activities[index].event_name)
                            .foregroundColor(.black)
                        Spacer()
                        VStack {
                            StarsView(rating: place.nearby_activities[index].ratings, maxRating: 5)
                                .padding(.trailing)
                            Text( place.nearby_activities[index].fee).foregroundColor(.black)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            }
        }
    }
}
