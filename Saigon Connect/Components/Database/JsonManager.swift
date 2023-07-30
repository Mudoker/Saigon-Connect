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

// struct to store the place information
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
    
    // static variables to store the sample place, all places, all categories, and the number of places
    static let allPlace = decodePlaceJsonFromJsonFile(jsonFileName: "places.json")
    static let allCategories = getUniquePlaceCategories(from: allPlace)
    static let itemCount = allPlace.count

    // static variables to store the top 10 places
    static let topPlaces = allPlace.sorted(by: { $0.ratings > $1.ratings }).prefix(10)
}

// struct to store the review information
struct Reviews: Codable {
    let reviewer_name: String
    let given_stars: Int
    let content: String
    let timestamp: String
}

// struct to store the activity information
struct Activity: Codable {
    let event_name: String
    let image_url: String
    let ratings: Double
    let fee: String
}

// Struct to store the events
struct Event: Codable {
    let name: String
    let address: String
    let host: String
    let location: [Double]
    let date: String
    let entrance_fee: String
    let opening_hours: String
    let short_description: String
    let full_description: String
    let image_url: String
    let popular_activities: [String]
    let reason: String
    let category: String
    let link: String
    // static variables to store the sample place, all places, all categories, and the number of places
    static let allEvents = decodeEventJsonFromJsonFile(jsonFileName: "events.json")
    static let allEventCategories = getUniqueEventCategories(from: allEvents)
    static let itemCount = allEvents.count
}

// function to decode the JSON file (load file from the main bundle)
func decodePlaceJsonFromJsonFile(jsonFileName: String) -> [Place] {
    // check if the file exists
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil) {
        // check if the file can be loaded
        if let data = try? Data(contentsOf: file) {
            // decode the JSON file
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

// function to decode the JSON file (load file from the main bundle)
func decodeEventJsonFromJsonFile(jsonFileName: String) -> [Event] {
    // check if the file exists
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil) {
        // check if the file can be loaded
        if let data = try? Data(contentsOf: file) {
            // decode the JSON file
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Event].self, from: data)
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


// function to get the unique categories from the places
func getUniquePlaceCategories(from places: [Place]) -> [String] {
    // get the categories from the places
    let categories = places.map { $0.category }

    // use Set to get the unique categories
    var uniqueCategories = Array(Set(categories))

    // sort the categories and append "All" to the the array
    uniqueCategories.append("All")
    uniqueCategories.sort()

    return uniqueCategories
}

// function to get the unique categories from the events
func getUniqueEventCategories(from events: [Event]) -> [String] {
    // get the categories from the places
    let categories = events.map { $0.category }

    // use Set to get the unique categories
    var uniqueCategories = Array(Set(categories))

    // sort the categories and append "All" to the the array
    uniqueCategories.append("All")
    uniqueCategories.sort()

    return uniqueCategories
}
