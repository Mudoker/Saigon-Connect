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
    Refer to PlaceView for references
*/

import SwiftUI
struct EventView: View {
    // Shared state variables for dark mode
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    // check if detail view is active
    @State private var isEventDetailView = false

    // get the current date and time
    @State private var currentTime = Date()

    // toggle search bar
    @State var showSearch = false

    // search input
    @State var searchInput = ""

    // category index to determine which category is selected
    @State var selectedIndexCat = 0

    // filter category
    @State var filter = ""

    // toggle slide menu
    @State var isOpenSlideMenu = false

    // toggle profile view
    @State var isProfileView = false

    // toggle place view
    @State var isPlaceView = false

    // toggle event view
    @State var isEventView = true

    var body: some View {
        // Navigation stack to navigate between views
        NavigationStack {
            ZStack {
                // Slide menu view (if open)
                if isOpenSlideMenu {
                    SlideMenuView(isOpenSlideMenu: $isOpenSlideMenu, isDarkMode: $isDarkMode, isPlaceView: $isPlaceView, isEventView: $isEventView)
                }

                // Consider to delete this
                if isPlaceView{
                    PlaceView(isDarkMode: isDarkMode)
                } else {
                    // Main view
                    VStack(alignment: .leading) {
                            // Navbar
                            HStack(alignment: .center) {
                                // toggle slide menu
                                Button {
                                    // use withAnimation to smoothly animate the view
                                    withAnimation(.spring()) {
                                        isOpenSlideMenu.toggle()
                                    }
                                } label: {
                                    Image(systemName: "line.3.horizontal")
                                        .resizable()
                                        .frame(width: 40, height: 20)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .padding()

                                Spacer()

                                // Logo display (hide when search bar is active)
                                if !self.showSearch {
                                    if isDarkMode {
                                        Image("app logo light")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 200, height: 200)
                                    } else {
                                        Image("app logo dark")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 200, height: 200)
                                    }
                                    Spacer()
                                }

                                // Search bar and toggle button
                                if self.showSearch {
                                    // search bar UI
                                    Capsule()
                                        .foregroundColor(isDarkMode ? .white : .gray)
                                        .opacity(0.2)
                                        .frame(height: 40)
                                        .overlay(
                                            HStack {
                                                Image(systemName: "magnifyingglass")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                                    .padding(.leading, 12)

                                                TextField("", text: $searchInput, prompt: Text("Type something...")
                                                    .foregroundColor( isDarkMode ? .white : .black))
                                                    .padding(.leading, 8)
                                            })
                                        .padding(.horizontal)

                                    // button to close search bar
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            self.searchInput = ""
                                            self.showSearch.toggle()
                                        }
                                    })
                                    {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                    }
                                    .padding()
                                    .offset(x: -10)
                                } else {
                                    // button to open search bar
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            self.showSearch.toggle()
                                        }
                                    })
                                    {
                                        Image(systemName: "magnifyingglass")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                            .padding()
                                    }
                                    .foregroundColor(isDarkMode ? .white : .black)
                                }
                            }
                            .frame(height: 80)
                        
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading) {
                                // Today's date and greeting (only show if search bar is not active)
                                if searchInput == "" {
                                    // get the current date and time
                                    Text(getFormattedDate())
                                        .frame(height: 15)
                                        .padding(.leading)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                    // greeting based on time
                                    Text("What's next?")
                                        .font(.largeTitle)
                                        .frame(height: 30).bold()
                                        .padding(.bottom,10).padding(.leading)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                    Spacer()
                                }

                                // Show all available categories for filtering
                                ScrollView(.horizontal, showsIndicators: false) {
                                    // Use lazy hstack to enhance performance as it only loads the view when it is needed
                                    LazyHStack {
                                        // Use ForEach to loop through all categories
                                        ForEach(0..<Event.allEventCategories.count, id: \.self) {
                                            index in
                                            filterCategory(
                                                isActive: index == selectedIndexCat,
                                                text: Event.allEventCategories[index])
                                            .onTapGesture {
                                                selectedIndexCat = index
                                                filter = Event.allEventCategories[index]
                                            }
                                        }
                                    }
                                    .padding(.leading)
                                }
                                .frame(height: 50)

                                // Show all places
                                // Use lazy vgrid to enhance performance as it only loads the view when it is needed
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 250), spacing: 0)]) {
                                    // if filter is not empty, show events that match the filter
                                    if filter != "" && filter != "All" {
                                        // if search input is not empty, show events that match the filter and search input
                                        if searchInput != "" {

                                            // if no result is found, show a message
                                            if Event.allEvents.indices.filter({
                                                Event.allEvents[$0].category == filter
                                                &&
                                                Event.allEvents[$0].name.lowercased()
                                                .contains(searchInput.lowercased())
                                                }).count == 0
                                            {
                                                Text("Result not found!").font(.title2).bold().opacity(0.5)
                                            } else {
                                                // else, show the events that match the filter and search input
                                                // The events are sorted alphabetically
                                                ForEach(
                                                    Event.allEvents.indices
                                                    .filter {
                                                        Event.allEvents[$0].category == filter
                                                        && Event.allEvents[$0].name.lowercased()
                                                        .contains(searchInput.lowercased())
                                                    }
                                                    .sorted {
                                                        Event.allEvents[$0].name
                                                        < Event.allEvents[$1].name
                                                    }
                                                    , id: \.self)
                                                {
                                                    index in
                                                    NavigationLink(
                                                        destination: EventDetailView(
                                                            isEventDetailView: $isEventDetailView,
                                                            event: Event.allEvents[index]))
                                                    {
                                                        EventCardView(isDarkMode: $isDarkMode, event: Event.allEvents[index])
                                                            .padding(.bottom)
                                                    }
                                                    .simultaneousGesture(
                                                        TapGesture()
                                                        .onEnded {
                                                            isEventDetailView = true
                                                        })
                                                }
                                            }
                                        } else {
                                            // else, show the events that match the filter
                                            // The events are sorted alphabetically
                                            ForEach(
                                                Event.allEvents.indices
                                                .filter {
                                                    Event.allEvents[$0].category == filter
                                                }
                                                .sorted {
                                                    Event.allEvents[$0].name < Event.allEvents[$1].name
                                                }
                                                , id: \.self)
                                            {
                                                index in
                                                NavigationLink(
                                                    destination: EventDetailView(
                                                        isEventDetailView: $isEventDetailView,
                                                        event: Event.allEvents[index]))
                                                {
                                                    EventCardView(isDarkMode: $isDarkMode ,event: Event.allEvents[index])
                                                        .padding(.bottom)
                                                }
                                                .simultaneousGesture(
                                                    TapGesture()
                                                    .onEnded {
                                                        isEventDetailView = true
                                                    })
                                            }
                                        }
                                    } else {
                                        // else, show all events
                                        // if search input is not empty, show events that match the search input
                                        if searchInput != "" {
                                            // if no result is found, show a message
                                            if Event.allEvents.indices.filter({
                                                Event.allEvents[$0].name.lowercased()
                                                .contains(searchInput.lowercased())
                                            }).count == 0
                                            {
                                                Text("Result not found!").font(.title2).bold().opacity(0.5)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            } else {
                                                // else, show the events that match the search input
                                                ForEach(
                                                    Event.allEvents.indices
                                                    .filter({
                                                        Event.allEvents[$0].name.lowercased()
                                                        .contains(searchInput.lowercased())
                                                    })
                                                    .sorted {
                                                        Event.allEvents[$0].name
                                                        < Event.allEvents[$1].name
                                                    }
                                                    , id: \.self)
                                                {
                                                    index in
                                                    NavigationLink(
                                                        destination: EventDetailView(
                                                            isEventDetailView: $isEventDetailView,
                                                            event: Event.allEvents[index]))
                                                    {
                                                        EventCardView(isDarkMode: $isDarkMode,event: Event.allEvents[index])
                                                            .padding(.bottom)
                                                    }
                                                    .simultaneousGesture(
                                                        TapGesture()
                                                        .onEnded {
                                                            isEventDetailView = true
                                                        })
                                                }
                                            }
                                        } else {
                                            // else, show all events and sort alphabetically
                                            ForEach(
                                                Event.allEvents.indices.sorted {
                                                    Event.allEvents[$0].name < Event.allEvents[$1].name
                                                }
                                                , id: \.self)
                                            {
                                                index in
                                                NavigationLink(
                                                    destination: EventDetailView(
                                                        isEventDetailView: $isEventDetailView,
                                                        event: Event.allEvents[index]))
                                                {
                                                    EventCardView(isDarkMode: $isDarkMode,event: Event.allEvents[index])
                                                        .padding(.bottom)
                                                }
                                                .simultaneousGesture(
                                                    TapGesture()
                                                    .onEnded {
                                                        isEventDetailView = true
                                                    }
                                                )
                                            }
                                        }
                                    }
                                }
                                .padding(.top)
                            }

                            // Footer (for spacing)
                            VStack {
                                
                            }.frame(height: 20)
                        }
                    }
                    .blur(radius: isOpenSlideMenu ? 50 : 0) // blur the view when slide menu is open
                    .offset(x: isOpenSlideMenu ? 350 : 0, y: isOpenSlideMenu ? 500 : 0) // move the view to the right when slide menu is open
                    .scaleEffect(isOpenSlideMenu ? 0.6 : 1) // scale down the view when slide menu is open
                }
                
            }
            .background( isDarkMode ? Image("background_dark")  : Image("background_light")) // background image based on dark mode
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    // greeting based on time
    private func greeting(for date: Date) -> String {
        // get the current date and time
        let calendar = Calendar.current

        // get the current hour
        let hour = calendar.component(.hour, from: date)

        // return greeting based on the current hour
        if hour >= 0 && hour < 12 {
            return "Good morning!"
        } else if hour >= 12 && hour < 18 {
            return "Good afternoon!"
        } else {
            return "Good evening!"
        }
    }

    // get the current date and format it
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d yyyy" // format the date: day of the week, month, day, year
        return dateFormatter.string(from: Date())
    }

}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
