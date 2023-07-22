//
//  expandable_search.swift
//  Saigon Connect
//
//  Created by quoc on 22/07/2023.
//

import SwiftUI

struct expandable_search: View {
    var body: some View {
        Home()
    }
}

struct expandable_search_Previews: PreviewProvider {
    static var previews: some View {
        expandable_search()
    }
}

struct Home: View {
    @State var showSearch = false
    @State var searchInput = ""
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if (!self.showSearch) {
                    Text("Food").fontWeight(.bold).font(.title).foregroundColor(.white)
                    Spacer()
                }
                
                
                
                HStack{
                    if self.showSearch {
                        Image(systemName: "magnifyingglass").foregroundColor(.black)
                        TextField("Search", text: self.$searchInput)
                        Button(action: {
                            withAnimation{
                                self.showSearch.toggle()

                            }
                        }) {
                            Image(systemName: "xmark").foregroundColor(.black)
                        }
                    } else {
                        Button(action: {
                            
                            withAnimation{
                                self.showSearch.toggle()

                            }                        }){
                            Image(systemName: "magnifyingglass").padding()
                        }.background(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(self.showSearch ? 10 : 0)
                .background(.white)
                    .cornerRadius(20)

            }
            .padding(.horizontal)
            .background(.orange)
            
        }
    }
}
