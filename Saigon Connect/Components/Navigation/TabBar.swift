//    import SwiftUI
//
//    class TabBarViewModel: ObservableObject {
//        @Published var isDarkMode: Bool = true
//        @Published var selectedTab: String = ""
//    }
//
//    struct TabBar: View {
//        @State var isDarkMode: Bool = true
//        @State var selectedTab: String = ""
//
//        var body: some View {
//            NavigationStack {
//                HStack {
//                    Spacer()
//
//                    NavigationLink(
//                        destination: ContentView(),
//                        label: {
//                            Image(systemName: "house")
//                                .resizable()
//                                .frame(width: 35, height: 35)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(selectedTab == "home" ? Color.blue : Color.gray.opacity(0.8))
//                                .clipShape(Circle())
//                        })
//                        .simultaneousGesture(
//                            TapGesture()
//                                .onEnded {
//                                    withAnimation {
//                                        selectedTab = "home"
//                                    }
//                                }
//                        )
//
//                    Spacer()
//
//                    NavigationLink(
//                        destination: ProfileView(isDarkMode: $isDarkMode),
//                        label: {
//                            Image(systemName: "person")
//                                .resizable()
//                                .frame(width: 35, height: 35)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(selectedTab == "profile" ? Color.green : Color.gray.opacity(0.8))
//                                .clipShape(Circle())
//                        })
//                        .simultaneousGesture(
//                            TapGesture()
//                                .onEnded {
//                                    withAnimation {
//                                        selectedTab = "profile"
//                                    }
//                                }
//                        )
//
//                    Spacer()
//                }
//                .padding()
//                .background(Color.gray.opacity(0.3))
//                .clipShape(Capsule())
//            }
//        }
//    }
//
//    struct TabBar_Previews: PreviewProvider {
//        static var previews: some View {
//            TabBar()
//        }
//    }
