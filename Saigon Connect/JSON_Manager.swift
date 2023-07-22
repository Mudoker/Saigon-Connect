import Foundation

struct Place: Codable {
    let name: String
    let address: String
    let location: [Double]
    let ratings: Double
    let total_ratings: Double
    let entrance_fee: String
    let opening_hours: String
    let short_description: String
    let full_description: String
    let image_url: String
    let popular_activities: [String]
    let nearby_activities: [Activity]
    let category: String
    
    static let allPlace = decodeJsonFromJsonFile(jsonFileName: "Places.json")
    static let allCategories = getUniqueCategories(from: allPlace)
    static let samplePlace: Place = allPlace[0]
    static let itemCount = allPlace.count
    static let topPlaces = allPlace.sorted(by: { $0.ratings > $1.ratings })
}

struct Activity: Codable {
    let event_name: String
    let image_url: String
    let ratings: Double
    let fee: String
}

func decodeJsonFromJsonFile(jsonFileName: String) -> [Place] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil) {
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Place].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return []
}

func getUniqueCategories(from places: [Place]) -> [String] {
    let categories = places.map { $0.category }
    var uniqueCategories = Array(Set(categories))
    uniqueCategories.append("All")
    uniqueCategories.sort()
    return uniqueCategories
}
