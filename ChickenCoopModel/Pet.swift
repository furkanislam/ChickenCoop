//
//  Pet.swift
//  ChickenCoopModel
//
//  Created by Furkan İSLAM on 24.06.2025.
//

import Foundation
import SwiftData

@Model
final class Pet {
    var name: String
    var person: String
    var egg: String
    var petNumber: String
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, person: String, egg: String, petNumber: String, photo: Data? = nil) {
        self.name = name
        self.person = person
        self.egg = egg
        self.petNumber = petNumber
        self.photo = photo
    }
}

extension Pet {
    @MainActor
    static var preview: ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: configuration)
        
        container.mainContext.insert(Pet(name: "A Blok", person: "Gamze", egg: "12503", petNumber: "533"))
        container.mainContext.insert(Pet(name: "B Blok", person: "Zehra", egg: "50145", petNumber: "982"))
        container.mainContext.insert(Pet(name: "C Blok", person: "Furkan", egg: "756", petNumber: "300"))
        container.mainContext.insert(Pet(name: "D Blok", person: "Miraç", egg: "27793", petNumber: "540"))
        container.mainContext.insert(Pet(name: "E Blok", person: "Alparslan", egg: "21387", petNumber: "708"))
        
        return container
    }
}
