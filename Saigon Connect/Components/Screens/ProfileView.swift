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
    P.Hudson. "How to open web links in Safari" HACKING WITH SWIFT. https://www.hackingwithswift.com/quick-start/swiftui/how-to-open-web-links-in-safari (accessed Jul. 25, 2023).
*/

import SwiftUI

struct ProfileView: View {
    @Binding var isDarkMode: Bool
    @State var userCreds: [User] = User.allUsers
    @AppStorage("userIndex") var userIndex = 0
    var body: some View {
        ZStack {
            GlassMorphicCard(isDarkMode: $isDarkMode, height: 550)
            VStack (spacing: 5) {
                Image(systemName: userCreds[userIndex].avatar).resizable().frame(width: 120, height: 120)
                    .foregroundColor(isDarkMode ? .white : .black)
                    .padding(.top)

                HStack {
                    Text(userCreds[userIndex].username).bold().font(.title)
                        .foregroundColor(isDarkMode ? .white : .black)
                    if userCreds[userIndex].pronouns != "" {
                        Text("( " + userCreds[userIndex].pronouns + " )")
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                }

                Text("@" + userCreds[userIndex].type).bold().font(.caption)
                    .foregroundColor(isDarkMode ? .white : .black)
                
                Text(userCreds[userIndex].bio).italic()
                    .font(.title2)
                    .foregroundColor(isDarkMode ? .white : .black)

                Text(userCreds[userIndex].skill)
                    .font(.title3)
                    .foregroundColor(isDarkMode ? .white : .black)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Connections")
                            .font(.title)
                            .bold()
                            .foregroundColor(isDarkMode ? .white : .black)
                            .padding(.bottom, 10)
                            .padding(.horizontal)

                        if userCreds[userIndex].connections.facebook == "" && userCreds[userIndex].connections.github == "" &&
                            userCreds[userIndex].connections.spotify == ""
                        {
                            HStack {
                                Spacer()
                                Text("Nothing to show")
                                    .opacity(0.5)
                                    .bold()
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.title)
                                .padding(.horizontal)
                                Spacer()
                            }
                                
                        } else {
                            HStack {
                                
                                if let facebook = userCreds[userIndex].connections.facebook, let _ = URL(string: facebook) {
                                    Link(destination: URL(string: facebook)!) {
                                        HStack {
                                            Image(systemName: "f.cursive.circle.fill")
                                                .foregroundColor(isDarkMode ? .white : .black)
                                                .font(.title)
                                            
                                            Text("Facebook")
                                                .font(.title)
                                                .foregroundColor(isDarkMode ? .white : .black)

                                            Spacer()

                                            Image(systemName: "arrow.up.forward")
                                                .foregroundColor(isDarkMode ? .white : .black)
                                                .font(.title)
                                        }
                                    }

                                }

                            }
                            .padding(.bottom, 10)
                            .padding(.horizontal)

                            Divider()
                                .background(isDarkMode ? .white : .black)
                            HStack {
                                if let github = userCreds[userIndex].connections.github, let _ = URL(string: github) {
                                    Link(destination: URL(string: github)!) {
                                        HStack {
                                            Image(systemName: "poweroutlet.type.f.fill")
                                                .foregroundColor(isDarkMode ? .white : .black)
                                                .font(.title)
                                            
                                            Text("Github")
                                                .font(.title)
                                                .foregroundColor(isDarkMode ? .white : .black)

                                            Spacer()

                                            Image(systemName: "arrow.up.forward")
                                                .foregroundColor(isDarkMode ? .white : .black)
                                                .font(.title)
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 10)
                            .padding(.horizontal)

                            Divider()
                                .background(isDarkMode ? .white : .black)

                            
                            HStack {
                                if let spotify = userCreds[userIndex].connections.spotify, let _ = URL(string: spotify) {
                                    Link(destination: URL(string: spotify)!) {
                                        HStack {
                                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                                .foregroundColor(isDarkMode ? .white : .black)
                                                .font(.title)
                                            
                                            Text("Spotify")
                                                .font(.title)
                                                .foregroundColor(isDarkMode ? .white : .black)

                                            Spacer()

                                            Image(systemName: "arrow.up.forward")
                                                .foregroundColor(isDarkMode ? .white : .black)
                                                .font(.title)
                                        }
                                    }
                                    
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
                
            }
            .padding(.top, 100)
        }.background( isDarkMode ? Image("background_dark") : Image("background_light"))
    }
}

struct Profile_View_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isDarkMode: .constant(true))
    }
}
