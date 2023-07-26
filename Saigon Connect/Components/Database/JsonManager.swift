/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 1
  Author: Doan Huu Quoc
  ID: 3927776
  Created  date: 20/07/2023
  Last modified: 26/07/2023
  Acknowledgement:
    T.Huynh. "Lecture 5 - Codable Protocol & SwiftUI State.pdf" rmit.instructure.com.https://rmit.instructure.com/courses/121597/pages/w5-whats-happening-this-week?module_item_id=5219565
            (accessed Jul. 20, 2023).
*/

import Foundation

struct User: Codable {
    let account: String
    let password: String
    let username: String
    let pronouns: String
    let bio: String
    let skill: String
    let followers: Int
    let following: Int
    let likes: Int
    let avatar: String
    let type: String
    let connections: Connections
    let isRegistered: Bool
    let joinDate: String
    
    struct Connections: Codable {
        let facebook: String?
        let github: String?
        let spotify: String?
    }
    
    static let allUsers = decodeUserFromJsonFile(jsonFileName: "user.json")
}


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
    let reviews: [Reviews]
    
    static let allPlace = decodeJsonFromJsonFile(jsonFileName: "database.json")
    static let allCategories = getUniqueCategories(from: allPlace)
    static let samplePlace: Place = allPlace[0]
    static let itemCount = allPlace.count
    static let topPlaces = allPlace.sorted(by: { $0.ratings > $1.ratings }).prefix(10)
}

struct Reviews: Codable {
    let reviewer_name: String
    let given_stars: Int
    let content: String
    let timestamp: String
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

func decodeUserFromJsonFile(jsonFileName: String) -> [User] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil) {
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([User].self, from: data)
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
