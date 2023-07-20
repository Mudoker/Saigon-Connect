//
//  Tab_View.swift
//  Saigon Connect
//
//  Created by quoc on 20/07/2023.
//

import SwiftUI

struct Tab_View: View {
    var body: some View {
        TabView {
            Content_View()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
            }
            List_View()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Detail")
                    
                }
        }
    }
}

struct Tab_View_Previews: PreviewProvider {
    static var previews: some View {
        Tab_View()
    }
}
