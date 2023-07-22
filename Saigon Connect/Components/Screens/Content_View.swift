//  Content_View.swift
//  Saigon Connect
//
//  Created by quoc on 20/07/2023.
//

import SwiftUI

struct Content_View: View {
    @State private var isDetailView = false
    @State private var detailViewIndex = false
    @State private var showingAlert = false
    @State private var currentTime = Date()
    @State var showSearch = false
    @State var searchInput = ""
    @State var selectedIndexCat = 0
    @State var filter = ""
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if isDetailView != true {
                    HStack(alignment: .center) {
                        // navbar button
                        Button {
                            showingAlert = true

                        } label: {
                            Image(systemName: "line.3.horizontal").resizable()
                                .frame(width: 40, height: 20).foregroundColor(.black)
                        }
                        .alert(isPresented: $showingAlert) {

                            return Alert(
                                title: Text("Saigon Connect"),
                                message: Text(
                                    "\nAuthor: Quoc Huu Doan \n" + "Sid: S3927776 \n"
                                        + "Version: 1.1.0 \n"))
                        }
                        .padding()  // Infor button
                        Spacer()

                        if !self.showSearch {
                            Image("app logo dark").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                            Spacer()
                        }

                        if self.showSearch {
                            Capsule()
                                .foregroundColor(.gray).opacity(0.2)
                                .frame(height: 40)
                                .overlay(
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.black)
                                            .padding(.leading, 12)
                                        
                                        TextField("Type something...", text: self.$searchInput)
                                            .foregroundColor(.black)
                                            .padding(.leading, 8)
                                    }
                                )
                                .padding(.horizontal)
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    self.searchInput = ""
                                    self.showSearch.toggle()
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill").resizable()
                                    .frame(width: 25, height: 25).foregroundColor(.black)
                            }
                            .padding().offset(x: -10)
                        } else {
                            Button(action: {

                                withAnimation(.easeInOut(duration: 0.1)) {
                                    self.showSearch.toggle()

                                }
                            }) {
                                Image(systemName: "magnifyingglass").resizable()
                                    .frame(width: 30, height: 30).foregroundColor(.black).padding()
                            }
                        }
                    }
                    .frame(height: 80)
                }
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text(getFormattedDate()).frame(height: 10).padding(.leading)
                        Text(greeting(for: currentTime)).font(.largeTitle).frame(height: 30).bold()
                            .padding(.bottom).padding(.leading)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(0..<Place.allCategories.count, id: \.self) { index in
                                    filterCategory(
                                        isActive: index == selectedIndexCat,
                                        text: Place.allCategories[index]
                                    )
                                    .onTapGesture {
                                        selectedIndexCat = index
                                        filter = Place.allCategories[index]
                                    }
                                }
                            }
                        }
                        .frame(height: 50).padding(.leading, 5)
                        Spacer()
                        if searchInput == "" {
                            Text("Top 10 destinations").font(.title).fontWeight(.bold).padding(.leading)
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(alignment: .top, spacing: 20) {
                                    if filter != "" && filter != "All" {
                                        
                                            ForEach(
                                                Place.topPlaces.indices
                                                    .filter { Place.topPlaces[$0].category == filter}
                                                    .prefix(10), id: \.self
                                            ) { index in
                                                NavigationLink(
                                                    destination: Detail_View(
                                                        isDetailView: $isDetailView,
                                                        place: Place.topPlaces[index])
                                                ) { Card_Views(place: Place.topPlaces[index]) }
                                                .simultaneousGesture(
                                                    TapGesture().onEnded { isDetailView = true })
                                            }
                                        
                                        
                                    } else {
                                       
                                            ForEach(Place.topPlaces.indices, id: \.self) { index in
                                                NavigationLink(
                                                    destination: Detail_View(
                                                        isDetailView: $isDetailView,
                                                        place: Place.topPlaces[index])
                                                ) { Card_Views(place: Place.topPlaces[index]) }
                                                .simultaneousGesture(
                                                    TapGesture().onEnded { isDetailView = true })
                                            }
                                        
                                        

                                    }
                                }
                            }
                            .padding(.leading, 5)
                        }
                        
                        
                        Text("All Places").font(.title).padding(.leading).bold()
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
                                    } else {
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
                                                }, id: \.self
                                        ) { index in
                                            NavigationLink(
                                                destination: Detail_View(
                                                    isDetailView: $isDetailView,
                                                    place: Place.allPlace[index])
                                            ) { small_Card_View(place: Place.allPlace[index]) }
                                            .simultaneousGesture(
                                                TapGesture()
                                                    .onEnded {
                                                        isDetailView = true  // Set isDetailView to true when the NavigationLink is activated
                                                    })
                                        }
                                    }
                                } else {
                                    ForEach(
                                        Place.allPlace.indices
                                            .filter { Place.allPlace[$0].category == filter }
                                            .sorted {
                                                Place.allPlace[$0].name < Place.allPlace[$1].name
                                            }, id: \.self
                                    ) { index in
                                        NavigationLink(
                                            destination: Detail_View(
                                                isDetailView: $isDetailView,
                                                place: Place.allPlace[index])
                                        ) { small_Card_View(place: Place.allPlace[index]) }
                                        .simultaneousGesture(
                                            TapGesture()
                                                .onEnded {
                                                    isDetailView = true  // Set isDetailView to true when the NavigationLink is activated
                                                })
                                    }
                                }
                            } else {
                                if searchInput != "" {
                                    if Place.allPlace.indices
                                        .filter({
                                            Place.allPlace[$0].name.lowercased()
                                                .contains(searchInput.lowercased())
                                        })
                                        .count == 0
                                    {
                                        Text("Result not found!").font(.title2).bold().opacity(0.5)
                                    } else {
                                        ForEach(
                                            Place.allPlace.indices
                                                .filter({
                                                    Place.allPlace[$0].name.lowercased()
                                                        .contains(searchInput.lowercased())
                                                })
                                                .sorted {
                                                    Place.allPlace[$0].name
                                                        < Place.allPlace[$1].name
                                                }, id: \.self
                                        ) { index in
                                            NavigationLink(
                                                destination: Detail_View(
                                                    isDetailView: $isDetailView,
                                                    place: Place.allPlace[index])
                                            ) { small_Card_View(place: Place.allPlace[index]) }
                                            .simultaneousGesture(
                                                TapGesture()
                                                    .onEnded {
                                                        isDetailView = true  // Set isDetailView to true when the NavigationLink is activated
                                                    })
                                        }
                                    }
                                } else {
                                    ForEach(
                                        Place.allPlace.indices.sorted {
                                            Place.allPlace[$0].name < Place.allPlace[$1].name
                                        }, id: \.self
                                    ) { index in
                                        NavigationLink(
                                            destination: Detail_View(
                                                isDetailView: $isDetailView,
                                                place: Place.allPlace[index])
                                        ) { small_Card_View(place: Place.allPlace[index]) }
                                        .simultaneousGesture(
                                            TapGesture()
                                                .onEnded {
                                                    isDetailView = true  // Set isDetailView to true when the NavigationLink is activated
                                                })
                                    }
                                }
                            }
                        }
                        .padding(.leading, 5)
                    }
                }
            }
            .background(
                Image("background_light").resizable().aspectRatio(contentMode: .fill)
                    .frame(minHeight: 1000))
        }
    }
    private func greeting(for date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if hour >= 0 && hour < 12 {
            return "Good morning!"
        } else if hour >= 12 && hour < 18 {
            return "Good afternoon!"
        } else {
            return "Good evening!"
        }
    }
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d yyyy"
        return dateFormatter.string(from: Date())
    }
}

struct Content_View_Previews: PreviewProvider { static var previews: some View { Content_View() } }

struct filterCategory: View {
    let isActive: Bool
    @State private var animateGradient = false

    let text: String
    var body: some View {
        ZStack {
            GlassMorphicCard()
            VStack(alignment: .leading, spacing: 0) {
                Text(text).font(.title3)
                    .foregroundColor(isActive ? .white : Color.black.opacity(0.7))

                if isActive { Color.white.frame(width: 30, height: 2).clipShape(Capsule()) }
            }
            .padding(10)
        }
    }
    @ViewBuilder func GlassMorphicCard() -> some View {
        ZStack {
            CustomBlurView(effect: .systemUltraThinMaterialDark) { view in }
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .opacity(isActive ? 1 : 0.5)
        }
        .frame(minWidth: 80).frame(height: 40)
    }
}
