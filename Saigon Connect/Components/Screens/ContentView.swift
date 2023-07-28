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
    @State var isProfileView = false

    var body: some View {
        NavigationStack {
            ZStack {
                if isOpenSlideMenu {
                    SlideMenuView(isOpenSlideMenu: $isOpenSlideMenu, isDarkMode: $isDarkMode, isProfileView: $isProfileView)
                }
                VStack(alignment: .leading) {
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
                            Text("All Places").font(.title).padding(.horizontal).bold().frame(height: 20).padding(.top, 10)
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
                                                        isDetailView = true
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
                        VStack {
                            
                        }.frame(height: 100)
                    }
                }
                .blur(radius: isOpenSlideMenu ? 50 : 0)
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
