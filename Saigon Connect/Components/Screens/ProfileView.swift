//
//  Author_View.swift
//  Saigon Connect
//
//  Created by quoc on 22/07/2023.
//

import SwiftUI

struct ProfileView: View {
    @Binding var isDarkMode: Bool
    @State var userCreds: [User] = User.allUsers
    @AppStorage("userIndex") var userIndex = 0
    var body: some View {
        ZStack {
            GlassMorphicCard(isDarkMode: $isDarkMode, height: 510)
            VStack (spacing: 5) {
                Image(systemName: userCreds[userIndex].avatar).resizable().frame(width: 120, height: 120)
                    .foregroundColor(isDarkMode ? .white : .black)
                    .padding(.leading, 20)

                Text(userCreds[userIndex].username).bold().font(.title)
                    .foregroundColor(isDarkMode ? .white : .black)

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



                        HStack {
                            
                            if let facebook = userCreds[userIndex].connections.facebook, let url = URL(string: facebook) {
                                Image (systemName: "f.cursive.circle.fill")
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.title)
                                Link("Facebook", destination: url)
                                    .font(.title)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                Spacer()
                                Image (systemName: "arrow.up.forward")
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.title)
                            }

                        }
                        .padding(.bottom, 10)
                        .padding(.horizontal)

                        Divider()
                            .background(isDarkMode ? .white : .black)
                        HStack {
                            if let github = userCreds[userIndex].connections.github, let url = URL(string: github) {
                                Image (systemName: "poweroutlet.type.f.fill")
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.title)
                                Link("Github", destination: url)
                                    .font(.title)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                Spacer()
                                Image (systemName: "arrow.up.forward")
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.title)
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.horizontal)

                        Divider()
                            .background(isDarkMode ? .white : .black)

                        
                        HStack {
                            if let spotify = userCreds[userIndex].connections.spotify, let url = URL(string: spotify) {
                                Image (systemName: "line.3.horizontal.decrease.circle.fill")
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.title)
                                Link("Spotify", destination: url)
                                    .font(.title)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                Spacer()
                                Image (systemName: "arrow.up.forward")
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .font(.title)
                                
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)


                    }
                    .padding(.top)
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
                
            }
            .padding(.top, 140)
        }.background( isDarkMode ? Image("background_dark") : Image("background_light"))
    }
}

struct Profile_View_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isDarkMode: .constant(true))
    }
}
