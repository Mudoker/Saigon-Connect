////
////  CustomTabBar.swift
////  Saigon Connect
////
////  Created by Quoc Doan Huu on 28/07/2023.
////
//
//import SwiftUI
//
//struct CustomTabBar: View {
//    @AppStorage("isDarkMode") var isDarkMode: Bool = true
//    @State var selectedPage: String = "home"
//    var body: some View {
//        ZStack {
//            if (selectedPage == "home") {
//                ContentView()
//            } else if selectedPage == "profile" {
//                ProfileView(isDarkMode: $isDarkMode)
//            }
//            else {
//            }
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        selectedPage = "home"
//                    })
//                    {
//                        Image(systemName: "house")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(isDarkMode ? .white : . black)
//                    }
//                    
//                    Spacer()
//                    Button(action: {
//                        selectedPage = "profile"
//                    })
//                    {
//                        Image(systemName: "person")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(isDarkMode ? .white : . black)
//                    }
//                    
//                    Spacer()
//                }
//                .frame(width: UIScreen.main.bounds.width,height: 80)
//                .background(isDarkMode ? .purple.opacity(0.3) : .blue.opacity(0.3))
//            }
//            .edgesIgnoringSafeArea(.all)
//        }.background(Image("background_dark"))
//    }
//}
//
//struct CustomTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTabBar()
//    }
//}
//
////class TabNavigation: ObservedObject {
////    @Published var selectedPage: String = "home"
////}
