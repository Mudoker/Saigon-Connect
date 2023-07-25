

//
//  Slide_Menu.swift
//  Saigon Connect
//
//  Created by quoc on 21/07/2023.
//

import SwiftUI

struct Slide_Menu: View {
    @Binding var isOpenSlideMenu: Bool
    @Binding var isDarkMode: Bool
    var background_light = LinearGradient(
        gradient: Gradient(colors: [Color(red: 1, green: 0.90, blue: 0.95), Color(red: 0.43, green: 0.84, blue: 0.98)]),
                startPoint: .top,
                endPoint: .bottom
            )
    var background_dark = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.06, green: 0.13, blue: 0.15), Color(red: 0.13, green: 0.23, blue: 0.26), Color(red: 0.17, green: 0.33, blue: 0.39)]),
                startPoint: .top,
                endPoint: .bottom
            )
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            isOpenSlideMenu.toggle()
                        }
                    }, label: {
                        Image (systemName: "arrow.right.to.line")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.horizontal)
                            .foregroundColor(isDarkMode ? .white : .black)
                    })
                }
                .padding(.top, 50)
                Spacer()
            }
            VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        VStack (alignment: .center) {
                            Image("author")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                            .clipShape(Circle())

                            Text("Huu Quoc Doan").font(.title2.bold())
                                .foregroundColor(isDarkMode ? .white : .black)

                            Text("@Mudoker").font(.callout)
                                .foregroundColor(isDarkMode ? .white : .black)

                        }
                        .padding(.top, 50)
                        Spacer()
                    }

                    Divider()

                    ScrollView (.vertical,showsIndicators: false) {
                        HStack {
                            Image(systemName: "moon.circle")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(isDarkMode ? .white : .black)

                            Text("DarkMode")
                                .foregroundColor(isDarkMode ? .white : .black)

                            Button {
                                isDarkMode.toggle()
                            } label: {
                                ZStack {
                                    Capsule()
                                        .frame(width: 90,height: 40)
                                    .foregroundColor(isDarkMode ? Color.green : Color.gray)
                                    Circle()
                                        .frame(width: 45, height: 45)
                                        .foregroundColor(.white)
                                        .offset(x: isDarkMode ?  25 : -25)
                                        .shadow(radius: 10)
                                }

                            }
                            .padding()  // Infor button
                        }
                    }
                    Divider()
                }
                .padding()
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
//        .background(isDarkMode ? background_dark : background_light)
        .background( isDarkMode ? Image("background_dark")  : Image("background_light"))
        .ignoresSafeArea(.container, edges: .vertical)
    }

    func creatButton (title: String, image: String) -> some View
    {
        //serch icon
        Button{
        }label :{
            HStack {
                Image(systemName: image)
                    .resizable()
                    .foregroundColor(isDarkMode ? .white : .black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                Text(title).font(.body).foregroundColor(isDarkMode ? .white : .black)

            }
            .padding(.top)
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct Slide_Menu_Previews: PreviewProvider {
    static var previews: some View {
        Slide_Menu(isOpenSlideMenu: .constant(true), isDarkMode: .constant(true))
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
