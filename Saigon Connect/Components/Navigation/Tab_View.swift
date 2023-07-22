//
//  Tab_View.swift
//  Saigon Connect
//
//  Created by quoc on 20/07/2023.
//

import SwiftUI

struct Tab_View: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        UITabBar.appearance().backgroundImage = UIImage() // Set the background image to a transparent image
           UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().itemWidth = UIScreen.main.bounds.width / 2
        UITabBar.appearance().itemSpacing = 0
    }
    
    var body: some View {
        ZStack {
            TabView {
                Content_View()
                    .tabItem {
                        
                        Image(systemName: "house")
                        Text("Home").font(.largeTitle)
                    }
                
                Author_View()
                    .tabItem {
                        Image(systemName: "info.circle").font(.system(size: 26))
                        Text("About me")
                    }
            }.accentColor(.blue)
        }
    }
}

struct Tab_View_Previews: PreviewProvider {
    static var previews: some View {
        Tab_View()
    }
}

