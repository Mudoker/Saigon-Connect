import SwiftUI
import MapKit

struct MapView: View {
    var place: Place = Place.allPlace[0]
    
    @State private var region: MKCoordinateRegion
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    init() {
        let coordinate = CLLocationCoordinate2D(latitude: place.location[0], longitude: place.location[1])
        _region = State(initialValue: MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)))
    }

    // CustomAnnotation to represent the location on the map
    struct CustomAnnotation: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: [CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.location[0], longitude: place.location[1]))]) { annotation in
                MapMarker(coordinate: annotation.coordinate, tint: .red)
            }
            
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            let coordinate = CLLocationCoordinate2D(latitude: place.location[0], longitude: place.location[1])
                            region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
                        }) {
                            Image(systemName: "location.circle.fill").resizable()
                                .frame(width: 40, height: 40).foregroundColor(.blue)
                                .padding(.top,20)
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


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
