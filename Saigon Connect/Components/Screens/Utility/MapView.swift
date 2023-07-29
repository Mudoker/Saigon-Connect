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
    T.Huynh. "Lecture 4 - Shapes, Navigation List & Map" rmit.instructure.com.https://rmit.instructure.com/courses/121597/pages/w4-whats-happening-this-week?module_item_id=5219564 (accessed Jul. 24, 2023).
*/

import SwiftUI
import MapKit

struct MapView: View {
    // variables to store the coordinate and region of the map
    @State private var coordinate: CLLocationCoordinate2D
    @State private var region: MKCoordinateRegion

    // check if the app is in dark mode
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    // initializer
    init(coordinate: CLLocationCoordinate2D) {
        _coordinate = State(initialValue: coordinate)
        _region = State(initialValue: MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)))
    }

    // show the annotation on the map
    struct CustomAnnotation: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }

    var body: some View {
        ZStack {
            // Map view
            Map(coordinateRegion: $region, annotationItems: [CustomAnnotation(coordinate: coordinate)]) { annotation in
                MapMarker(coordinate: annotation.coordinate, tint: .red)
            }
            
            // Button to go back to the current location
            VStack {
                // Spacer to push the button to the right of the screen
                HStack {
                    Spacer()

                    VStack {
                        // Button to reset the coordinate and region of the map
                        Button(action: {
                            region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
                        }) {
                            Image(systemName: "location.circle.fill")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .foregroundColor(.blue)
                                .padding(.top,40)
                        }
                        .padding(.horizontal)
                        .padding(.top, 40)
                    }
                }
                Spacer()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .accentColor(isDarkMode ? .white : .black)
    }
}

// preview
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0307))
    }
}
