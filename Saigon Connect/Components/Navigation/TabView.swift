///*
//  RMIT University Vietnam
//  Course: COSC2659 iOS Development
//  Semester: 2023B
//  Assessment: Assignment 1
//  Author: Doan Huu Quoc
//  ID: 3927776
//  Created  date: 20/07/2023
//  Last modified: 26/07/2023
//  Acknowledgement: None
//*/
//
//import SwiftUI
//
//struct Tab_View: View {
//    @AppStorage("isDarkMode") var isDarkMode: Bool = true
//
//    init() {
//        UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
//        UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.7)
//        UITabBar.appearance().backgroundImage = UIImage()
//           UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().itemWidth = UIScreen.main.bounds.width / 2
//        UITabBar.appearance().itemSpacing = 0
//    }
//    var body: some View {
//        ZStack {
//            TabView {
//                ContentView(isDarkMode: isDarkMode)
//                    .tabItem {
//                        
//                        Image(systemName: "house")
//                        Text("Home").font(.largeTitle)
//                    }
//                
//                ProfileView(isDarkMode: $isDarkMode)
//                    .tabItem {
//                        Image(systemName: "person.circle").font(.system(size: 26))
//                        Text("About")
//                    }
//            }.accentColor(.blue)
//        }
//    }
//}
//
//struct Tab_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Tab_View()
//    }
//}
