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
    Q.Doan, "app logo dark" unpublished, Jul. 2023.
    Q.Doan, "app logo light" unpublished, Jul. 2023.
    DesignCode. Building your first iOS app - SwiftUI Livestream (Apr. 24, 2021). Accessed Jul. 24, 2023. [Online Video]. Available: https://www.youtube.com/watch?v=1AXyC24NCkE&t=5s
    Kavsoft. Expandable Search Bar Using SwiftUI - Custom Search Bar Using SwiftUI - SwiftUI Tutorial (Mar. 10, 2020). Accessed Jul. 20, 2023. [Online Video]. Available: https://www.youtube.com/watch?v=4_uP61b0d1E
    DesignCode. Carousel with 3D Rotation and Parallax in SwiftUI (Dec. 2, 2021). Accessed Jul. 24, 2023. [Online Video]. Available: https://www.youtube.com/watch?v=Ms1Khcnms3g&t=925s
    L.Nguyen. "Nhà thờ Đức Bà" Pinterest. https://www.pinterest.com/pin/112660428155589052/ (accessed Jul. 19, 2023).
    Tràng An. "Khám phá chợ Bến Thành: Khu chợ cổ trở thành biểu tượng của Sài Gòn" Tràng An. https://disantrangan.vn/cho-ben-thanh (accessed Jul. 19, 2023).
    savills. "BITEXCO FINANCIAL TOWER" savills. https://vn.savills.com.vn/find-a-property/commercial-leasing/hcm-bitexco-financial-tower.aspx (accessed Jul. 19, 2023).
    i Tour Vietnam. "Saigon Opera House" i Tour Vietnam. https://www.itourvn.com/blog/saigon-opera-house (accessed Jul. 19, 2023).
    Duyen. "Saigon Central Post Office" Origin Vietnam. https://www.originvietnam.com/destinations/saigon-central-post-office/ (accessed Jul. 19, 2023).
    G. Rodgers. "War Remnants Museum: a Must-See Vietnam War Memorial in Saigon" tripsavvy. https://www.tripsavvy.com/war-remnants-museum-1629320 (accessed Jul. 19, 2023).
    SKYGEM HOTEL. "SAIGON SQUARE" Sky Gem Hotel. https://www.bluediamondhotel.com.vn/saigon-square (accessed Jul. 19, 2023).
    Phuong Vy. "Có gì vui ở phố đi bộ Nguyễn Huệ mỗi tối?" 1 phút Saigon. https://1phutsaigon.vn/co-gi-vui-o-pho-di-bo-nguyen-hue/ (accessed Jul. 19, 2023).
    Trung Son. "Phố đi bộ Bùi Viện đã gọn, đẹp hơn" Phu Nu Newspaper. https://www.phunuonline.com.vn/pho-di-bo-bui-vien-da-gon-dep-hon-a1461576.html (accessed Jul. 19, 2023).
    H.Nguyen. "Công viên Tao Đàn – Cảnh đẹp tựa vườn thượng uyển Sài Gòn xưa" DULICH3MIEN. https://dulich3mien.vn/ho-chi-minh/cong-vien-tao-dan/ (accessed Jul. 19, 2023).
    Vingroup. "Saigon Zoo and Botanical Gardens: ALL you need to know before visiting" VinWonders. https://vinwonders.com/en/news/saigon-zoo-and-botanical-gardens-all-you-need-to-know-before-visiting/ (accessed Jul. 19, 2023).
    Ho Chi Minh City Museum of Fine Arts. "" Ho Chi Minh City Museum of Fine Arts. http://baotangmythuattphcm.com.vn (accessed Jul. 19, 2023).
    Q.Tran. "Bảo tàng đầu tiên ở Sài Gòn" ivivu.com. https://www.ivivu.com/blog/2019/09/bao-tang-dau-tien-o-sai-gon/ (accessed Jul. 19, 2023).
    iVIVU.com. "Khám phá chùa Giác Lâm – ngôi cổ tự trăm năm giữa lòng Sài Gòn" iVIVU.com. https://www.ivivu.com/blog/2022/10/kham-pha-chua-giac-lam-ngoi-co-tu-tram-nam-giua-long-sai-gon/ (accessed Jul. 19, 2023).
    Wallpaper Flare. "HD wallpaper: vietnam, ho chi minh city, bitexco, saigon, spaceship, building exterior" Wallpaper Flare. https://www.wallpaperflare.com/vietnam-ho-chi-minh-city-bitexco-saigon-spaceship-building-exterior-wallpaper-erkbd (accessed Jul. 19, 2023).
    Viet Holiday Travel. "Dam Sen Water Park" Viet Holiday Travel. http://www.holidayinvietnam.com/vietnam/ho-chi-minh/dam-sen-water-park (accessed Jul. 19, 2023).
    VOV2. "Hai công trình kiến trúc tại TP.HCM được xếp hạng Di tích quốc gia đặc biệt" VOV2. https://vov2.vov.vn/van-hoa-giai-tri/hai-cong-trinh-kien-truc-tai-tphcm-duoc-xep-hang-di-tich-quoc-gia-dac-biet-38574 (accessed Jul. 19, 2023).
    Vingroup. "" Landmark 81 Sky View. https://www.landmark81skyview.com (accessed Jul. 19, 2023).
    Travel Saigon. "Ho Chi Minh City Book Street" Travel Saigon. https://travelsaigon.org/place/ho-chi-minh-city-book-street/ (accessed Jul. 19, 2023).
    Xây Dựng Số. "gradient wallpaper 5k đa dạng chất lượng hình ảnh" Travel Saigon. https://xaydungso.vn/bai-viet-khac/gradient-wallpaper-5k-da-dang-chat-luong-hinh-anh-vi-cb.html  Xây Dựng Số (accessed Jul. 19, 2023).
*/

import SwiftUI
struct ContentView: View {
    // Shared state variables for dark mode
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    // check if detail view is active
    @State private var isDetailView = false

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

    var body: some View {
        // Navigation stack to navigate between views
        NavigationStack {
            ZStack {
                // Slide menu view (if open)
                if isOpenSlideMenu {
                    SlideMenuView(isOpenSlideMenu: $isOpenSlideMenu, isDarkMode: $isDarkMode, isProfileView: $isProfileView)
                }

                // Consider to delete this
                if isProfileView {
                    ProfileView(isDarkMode: $isDarkMode)
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
                                            .frame(width: 30, height: 30)                                    .foregroundColor(isDarkMode ? .white : .black)
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
                                    Text(greeting(for: currentTime))
                                        .font(.largeTitle)
                                        .frame(height: 30).bold()
                                        .padding(.bottom,10).padding(.leading)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                    Spacer()

                                    // Show top 10 places in Ho Chi Minh City
                                    TabView {
                                        // Use geometry reader to animate the transition between cards
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
                                                        .shadow(color: Color.gray.opacity(0.3), radius: 10,x: 0, y: 10)
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

                                // Show all places
                                Text("All Places")
                                    .font(.title)
                                    .padding(.horizontal)
                                    .bold()
                                    .frame(height: 20)
                                    .padding(.top, 10)
                                    .foregroundColor(isDarkMode ? .white : .black)

                                // Show all available categories for filtering
                                ScrollView(.horizontal, showsIndicators: false) {
                                    // Use lazy hstack to enhance performance as it only loads the view when it is needed
                                    LazyHStack {
                                        // Use ForEach to loop through all categories
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

                                // Show all places
                                // Use lazy vgrid to enhance performance as it only loads the view when it is needed
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 0)]) {
                                    // if filter is not empty, show places that match the filter
                                    if filter != "" && filter != "All" {
                                        // if search input is not empty, show places that match the filter and search input
                                        if searchInput != "" {

                                            // if no result is found, show a message
                                            if Place.allPlace.indices.filter({
                                                Place.allPlace[$0].category == filter
                                                &&
                                                Place.allPlace[$0].name.lowercased()
                                                .contains(searchInput.lowercased())
                                                }).count == 0
                                            {
                                                Text("Result not found!").font(.title2).bold().opacity(0.5)
                                            } else {  
                                                // else, show the places that match the filter and search input
                                                // The places are sorted alphabetically
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
                                        } else {
                                            // else, show the places that match the filter
                                            // The places are sorted alphabetically
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
                                    } else {
                                        // else, show all places
                                        // if search input is not empty, show places that match the search input
                                        if searchInput != "" {
                                            // if no result is found, show a message
                                            if Place.allPlace.indices.filter({
                                                Place.allPlace[$0].name.lowercased()
                                                .contains(searchInput.lowercased())
                                            }).count == 0
                                            {
                                                Text("Result not found!").font(.title2).bold().opacity(0.5)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            } else {
                                                // else, show the places that match the search input
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
                                                            isDetailView = true
                                                        })
                                                }
                                            }
                                        } else {
                                            // else, show all places
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
                                                    }
                                                )
                                            }
                                        }
                                    }
                                }
                                .padding(.leading, 5)
                            }

                            // Footer (for spacing)
                            VStack {
                                
                            }.frame(height: 100)
                        }
                    }
                    .blur(radius: isOpenSlideMenu ? 50 : 0) // blur the view when slide menu is open
                    .offset(x: isOpenSlideMenu ? 300 : 0) // move the view to the right when slide menu is open
                    .scaleEffect(isOpenSlideMenu ? 0.8 : 1) // scale down the view when slide menu is open
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

// filter category view
struct filterCategory: View {

    // Shared state variables for dark mode
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    // check if the category is active
    let isActive: Bool

    // category name
    let text: String

    var body: some View {
        // Apply glass morphism effect to the category
        ZStack {
            // glass morphism effect with custom dimensions
            GlassMorphicCard(isDarkMode: $isDarkMode, height: 40, minWidth: 80, useMinWidth: true)

            // category item
            VStack(alignment: .leading, spacing: 0) {

                // adjust the category name based on dark mode
                if isDarkMode {
                    Text(text).font(.title3)
                    .foregroundColor(isActive ? .white : Color.white.opacity(0.7))
                } else {
                    Text(text).font(.title3)
                    .foregroundColor(isActive ? .white : Color.black.opacity(0.7))
                }

                // if the category is active, show a white line below the category name
                if isActive {
                    Color.white.frame(width: 30, height: 2).clipShape(Capsule())
                }
            }
            .padding(10)
        }
    }

}

struct Content_View_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}