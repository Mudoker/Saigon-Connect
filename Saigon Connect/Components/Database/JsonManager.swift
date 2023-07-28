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

// Consider remove this struct
struct User: Codable {
    let account: String
    let password: String
    var username: String
    var pronouns: String
    var bio: String
    var skill: String
    var followers: Int
    var following: Int
    var likes: Int
    let avatar: String
    let type: String
    var connections: Connections
    var isRegistered: Bool
    let joinDate: String
    
    struct Connections: Codable {
        var facebook: String?
        var github: String?
        var spotify: String?
    }
    
    static var allUsers = decodeUserFromJsonFile(jsonFileName: "user.json")
}

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
    static let allPlace = decodeJsonFromJsonFile(jsonFileName: "database.json")
    static let allCategories = getUniqueCategories(from: allPlace)
    static let samplePlace: Place = allPlace[0]
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

// function to decode the JSON file (load file from the main bundle)
func decodeJsonFromJsonFile(jsonFileName: String) -> [Place] {
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

// consider remove this function
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

// function to get the unique categories from the places
func getUniqueCategories(from places: [Place]) -> [String] {
    // get the categories from the places
    let categories = places.map { $0.category }

    // use Set to get the unique categories
    var uniqueCategories = Array(Set(categories))

    // sort the categories and append "All" to the the array
    uniqueCategories.append("All")
    uniqueCategories.sort()

    return uniqueCategories
}

// consider remove this function
func saveUserCredsToFile(userCreds: [User]) {
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(userCreds)
        
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Couldn't access documents directory.")
        }
        
        let fileURL = documentsDirectoryURL.appendingPathComponent("user.json")
        try data.write(to: fileURL)
        print("Updated user data successfully saved to file.")
    } catch {
        print("Error saving userCreds to file: \(error)")
    }
}


//func updateUserToFile(updatedUsers: [User]) {
//    do {
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        let data = try encoder.encode(updatedUsers)
//
//        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            fatalError("Couldn't access documents directory.")
//        }
//
//        let fileURL = documentsDirectoryURL.appendingPathComponent("user.json")
//        try data.write(to: fileURL)
//        print("Updated user data successfully saved to file.")
//    } catch {
//        print("Error saving updated user data to file: \(error)")
//    }
//}


