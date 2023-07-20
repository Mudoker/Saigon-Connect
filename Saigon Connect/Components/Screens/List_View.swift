//
//  List_View.swift
//  Saigon Connect
//
//  Created by quoc on 21/07/2023.
//

import SwiftUI

struct List_View: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<5) {
                    item in VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "lightbulb").opacity(0.5)
                            Text("Hello world").opacity(0.5)
                        }
                    }
                }
            }
            .navigationTitle("Nearby activities")
        }
    }
}

struct List_View_Previews: PreviewProvider {
    static var previews: some View {
        List_View()
    }
}
