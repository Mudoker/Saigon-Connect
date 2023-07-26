//  Content_View.swift
//  Saigon Connect
//
//  Created by quoc on 20/07/2023.
//
import SwiftUI
struct ContentView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @State private var isDetailView = false
    @State private var detailViewIndex = false
    @State private var showingAlert = false
    @State private var currentTime = Date()
    @State var showSearch = false
    @State var searchInput = ""
    @State var selectedIndexCat = 0
    @State var filter = ""
    @State var isOpenSlideMenu = false
    var body: some View {
        NavigationStack {
            ZStack {
                if isOpenSlideMenu {
                    SlideMenuView(isOpenSlideMenu: $isOpenSlideMenu, isDarkMode: $isDarkMode)
                }
                VStack(alignment: .leading) {
                    if isDetailView != true {
                        HStack(alignment: .center) {
                            // navbar button
                            Button {
                                withAnimation(.spring()) {
                                    isOpenSlideMenu.toggle()
                                }
                            }
                            label: {
                                Image(systemName: "line.3.horizontal").resizable()
                                .frame(width: 40, height: 20)
                                .foregroundColor(isDarkMode ? .white : .black)
                            }
                            .padding()  // Infor button
                            Spacer()
                            if !self.showSearch {
                                if isDarkMode {
                                    Image("app logo light").resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                }
                                else {
                                    Image("app logo dark").resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                }
                                Spacer()
                            }
                            if self.showSearch {
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
                                        TextField("Type something...", text: self.$searchInput)
                                        .padding(.leading, 8)
                                    })
                                .padding(.horizontal)
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.1)) {
                                        self.searchInput = ""
                                        self.showSearch.toggle()
                                    }
                                })
                                {
                                    Image(systemName: "xmark.circle.fill").resizable()
                                    .frame(width: 25, height: 25)                                    .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .padding().offset(x: -10)
                            }
                            else {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.1)) {
                                        self.showSearch.toggle()
                                    }
                                })
                                {
                                    Image(systemName: "magnifyingglass").resizable()
                                    .frame(width: 30, height: 30)                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .padding()
                                }
                                .foregroundColor(isDarkMode ? .white : .black)
                            }
                        }
                        .frame(height: 80)
                    }
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            if searchInput == "" {
                                Text(getFormattedDate()).frame(height: 15).padding(.leading)
                                .foregroundColor(isDarkMode ? .white : .black)
                                Text(greeting(for: currentTime)).font(.largeTitle).frame(height: 30).bold()
                                .padding(.bottom,10).padding(.leading)
                                .foregroundColor(isDarkMode ? .white : .black)
                                Spacer()
                                TabView {
                                    ForEach(Place.topPlaces.indices, id: \.self) {
                                        index in
                                        GeometryReader {
                                            proxy in
                                            NavigationLink(
                                                destination: DetailView(
                                                    isDetailView: $isDetailView,
                                                    place: Place.topPlaces[index]))
                                            {
                                                CardView(isDarkMode: $isDarkMode, place: Place.topPlaces[index])
                                                .padding(.horizontal)
                                                .rotation3DEffect(.degrees(proxy.frame(in: .global).minX / -10), axis: (x: 0, y: 1, z: 0))
                                                .shadow(color: Color.gray.opacity(0.3),
                                                        radius: 10,
                                                        x: 0,
                                                        y: 10)
                                            }
                                            .simultaneousGesture(
                                                TapGesture().onEnded {
                                                    isDetailView = true
                                                })
                                        }
                                    }
                                }
                                .tabViewStyle(.page(indexDisplayMode: .never))
                                .frame(height: 370)
                            }
                            Text("All Places").font(.title).padding(.leading).bold().frame(height: 20).padding(.top, 10)
                            .foregroundColor(isDarkMode ? .white : .black)
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(0..<Place.allCategories.count, id: \.self) {
                                        index in
                                        filterCategory(
                                            isActive: index == selectedIndexCat,
                                            text: Place.allCategories[index])
                                        .onTapGesture {
                                            selectedIndexCat = index
                                            filter = Place.allCategories[index]
                                        }
                                    }
                                }
                                .padding(.leading)
                            }
                            .frame(height: 50)
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 0)]) {
                                if filter != "" && filter != "All" {
                                    if searchInput != "" {
                                        if Place.allPlace.indices
                                        .filter({
                                            Place.allPlace[$0].category == filter
                                            &&
                                            Place.allPlace[$0].name.lowercased()
                                            .contains(searchInput.lowercased())
                                        })
                                        .count == 0
                                        {
                                            Text("Result not found!").font(.title2).bold().opacity(0.5)
                                        }
                                        else {
                                            ForEach(
                                                Place.allPlace.indices
                                                .filter {
                                                    Place.allPlace[$0].category == filter
                                                    && Place.allPlace[$0].name.lowercased()
                                                    .contains(searchInput.lowercased())
                                                }
                                                .sorted {
                                                    Place.allPlace[$0].name
                                                    < Place.allPlace[$1].name
                                                }
                                                , id: \.self)
                                            {
                                                index in
                                                NavigationLink(
                                                    destination: DetailView(
                                                        isDetailView: $isDetailView,
                                                        place: Place.allPlace[index]))
                                                {
                                                    SmallCardView(isDarkMode: $isDarkMode, place: Place.allPlace[index])
                                                }
                                                .simultaneousGesture(
                                                    TapGesture()
                                                    .onEnded {
                                                        isDetailView = true  
                                                    })
                                            }
                                        }
                                    }
                                    else {
                                        ForEach(
                                            Place.allPlace.indices
                                            .filter {
                                                Place.allPlace[$0].category == filter
                                            }
                                            .sorted {
                                                Place.allPlace[$0].name < Place.allPlace[$1].name
                                            }
                                            , id: \.self)
                                        {
                                            index in
                                            NavigationLink(
                                                destination: DetailView(
                                                    isDetailView: $isDetailView,
                                                    place: Place.allPlace[index]))
                                            {
                                                SmallCardView(isDarkMode: $isDarkMode ,place: Place.allPlace[index])
                                            }
                                            .simultaneousGesture(
                                                TapGesture()
                                                .onEnded {
                                                    isDetailView = true
                                                })
                                        }
                                    }
                                }
                                else {
                                    if searchInput != "" {
                                        if Place.allPlace.indices
                                        .filter({
                                            Place.allPlace[$0].name.lowercased()
                                            .contains(searchInput.lowercased())
                                        })
                                        .count == 0
                                        {
                                            Text("Result not found!").font(.title2).bold().opacity(0.5)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        }
                                        else {
                                            ForEach(
                                                Place.allPlace.indices
                                                .filter({
                                                    Place.allPlace[$0].name.lowercased()
                                                    .contains(searchInput.lowercased())
                                                })
                                                .sorted {
                                                    Place.allPlace[$0].name
                                                    < Place.allPlace[$1].name
                                                }
                                                , id: \.self)
                                            {
                                                index in
                                                NavigationLink(
                                                    destination: DetailView(
                                                        isDetailView: $isDetailView,
                                                        place: Place.allPlace[index]))
                                                {
                                                    SmallCardView(isDarkMode: $isDarkMode,place: Place.allPlace[index])
                                                }
                                                .simultaneousGesture(
                                                    TapGesture()
                                                    .onEnded {
                                                        isDetailView = true  // Set isDetailView to true when the NavigationLink is activated
                                                    })
                                            }
                                        }
                                    }
                                    else {
                                        ForEach(
                                            Place.allPlace.indices.sorted {
                                                Place.allPlace[$0].name < Place.allPlace[$1].name
                                            }
                                            , id: \.self)
                                        {
                                            index in
                                            NavigationLink(
                                                destination: DetailView(
                                                    isDetailView: $isDetailView,
                                                    place: Place.allPlace[index]))
                                            {
                                                SmallCardView(isDarkMode: $isDarkMode,place: Place.allPlace[index])
                                            }
                                            .simultaneousGesture(
                                                TapGesture()
                                                .onEnded {
                                                    isDetailView = true
                                                })
                                        }
                                    }
                                }
                            }
                            .padding(.leading, 5)
                        }
                    }
                }
                .blur(radius: isOpenSlideMenu ? 50 : 0)
                .edgesIgnoringSafeArea(.bottom)
                .offset(x: isOpenSlideMenu ? 300 : 0)
                .scaleEffect(isOpenSlideMenu ? 0.8 : 1)
            }
            .background( isDarkMode ? Image("background_dark")  : Image("background_light"))
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    private func greeting(for date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if hour >= 0 && hour < 12 {
            return "Good morning!"
        }
        else if hour >= 12 && hour < 18 {
            return "Good afternoon!"
        }
        else {
            return "Good evening!"
        }
    }

    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d yyyy"
        return dateFormatter.string(from: Date())
    }

}
struct Content_View_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}
struct filterCategory: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    let isActive: Bool
    @State private var animateGradient = false
    let text: String
    var body: some View {
        ZStack {
            GlassMorphicCard(isDarkMode: $isDarkMode, height: 40, minWidth: 80, useMinWidth: true)
            VStack(alignment: .leading, spacing: 0) {
                if isDarkMode {
                    Text(text).font(.title3)
                    .foregroundColor(isActive ? .white : Color.white.opacity(0.7))
                }
                else {
                    Text(text).font(.title3)
                    .foregroundColor(isActive ? .white : Color.black.opacity(0.7))
                }
                if isActive {
                    Color.white.frame(width: 30, height: 2).clipShape(Capsule())
                }
            }
            .padding(10)
        }
    }

}
class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = true
}
