//
//  Slide_Menu.swift
//  Saigon Connect
//
//  Created by quoc on 21/07/2023.
//

import SwiftUI

struct Slide_Menu: View {
//    @Binding var showMenu: Bool
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            VStack {
                Image("user")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                .clipShape(Circle())
                Text("Huu Quoc Doan").font(.title2.bold())
                Text("@Mudoker").font(.callout)
            }
            
            Divider()
            
            ScrollView (.vertical,showsIndicators: false) {
                creatButton(title: "Personal Info", image: "person")
                
                creatButton(title: "Darkmode", image: "moon.circle")
            }
            Divider()
        }
        .padding()
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .background(Color.primary.opacity(0.1).ignoresSafeArea(.container, edges: .vertical))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func creatButton (title: String, image: String) -> some View
    {
        //serch icon
        Button{
        }label :{
            HStack {
                Image(systemName: image)
                    .resizable()
                    .foregroundColor(.black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                Text(title).font(.body).foregroundColor(.black)
            }
            .padding(.top)
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct Slide_Menu_Previews: PreviewProvider {
    static var previews: some View {
        Slide_Menu()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
