//
//  TheAmericansStorage.swift
//  Clase13Ejercicio1
//
//  Created by Mac on 13/01/23.
//

import UIKit

protocol TheAmericansStorageProtocol {
    func getNumberOfCharacters() -> Int
    func getCharacter(with index: Int) -> Character
    func getActorForDetail(with index: Int) -> Actor
    func deleteCharacter(at index: Int)
    func resetListOfCharacters()
}

class TheAmericansStorage {
    private struct TheAmericans {
        static let characters = [
            Character(name: "Elizabeth Jennings", seasons: "6", actorName: "Keri Russell", actorImage: "1"),
            Character(name: "Philip Jennings", seasons: "6", actorName: "Matthew Rhys", actorImage: "2"),
            Character(name: "Chris Amador", seasons: "1", actorName: "Maximiliano Hernández", actorImage: "3"),
            Character(name: "Paige Jennings", seasons: "6", actorName: "Holly Taylor", actorImage: "4"),
            Character(name: "Henry Jennings", seasons: "6", actorName: "Keidrich Sellati", actorImage: "5"),
            Character(name: "Stan Beeman", seasons: "6", actorName: "Noah Emmerich", actorImage: "6"),
            Character(name: "Nina Sergeevna Krilova", seasons: "4", actorName: "Annet Mahendru", actorImage: "7"),
            Character(name: "Sandra Beeman", seasons: "4", actorName: "Susan Misner", actorImage: "8"),
            Character(name: "Martha Hanson", seasons: "5", actorName: "Alison Wright", actorImage: "9"),
            Character(name: "Arkady Ivanovich Zotov", seasons: "5", actorName: "Lev Gorn", actorImage: "10"),
            Character(name: "Oleg Igorevich Burov", seasons: "5", actorName: "Costa Ronin", actorImage: "11"),
            Character(name: "Frank Gaad", seasons: "4", actorName: "Richard Thomas", actorImage: "12"),
            Character(name: "William Crandall", seasons: "1", actorName: "Dylan Baker", actorImage: "13"),
            Character(name: "Dennis Aderholt", seasons: "4", actorName: "Brandon J. Dirden", actorImage: "14"),
            Character(name: "Claudia", seasons: "6", actorName: "Margo Martindale", actorImage: "15")
        ]
        
        static let actors = [
            Actor(name: "Keri Russell", actorImage: "1", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Matthew Rhys", actorImage: "2", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Maximiliano Hernández", actorImage: "3", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Holly Taylor", actorImage: "4", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Keidrich Sellati", actorImage: "5", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Noah Emmerich", actorImage: "6", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Annet Mahendru", actorImage: "7", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Susan Misner", actorImage: "8", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Alison Wright", actorImage: "9", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Lev Gorn", actorImage: "10", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Costa Ronin", actorImage: "11", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Richard Thomas", actorImage: "12", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Dylan Baker", actorImage: "13", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Brandon J. Dirden", actorImage: "14", description: "Una pequeña biografia", serie: "Esta Serie"),
            Actor(name: "Margo Martindale", actorImage: "15", description: "Una pequeña biografia", serie: "Esta Serie")
        ]
        
        static let defaultActor = Actor(name: "", actorImage: "", description: "", serie: "")
    }
    
    private static let instance = TheAmericansStorage()
    
    static func getInstance() -> TheAmericansStorageProtocol {
        instance
    }

    private var getCharacters = TheAmericans.characters
}

extension TheAmericansStorage: TheAmericansStorageProtocol {
    func getNumberOfCharacters() -> Int {
        getCharacters.count
    }
    
    func getCharacter(with index: Int) -> Character {
        getCharacters[index]
    }
    
    func getActorForDetail(with index: Int) -> Actor {
        return TheAmericans.actors.first { actor in
            actor.name == getCharacters[index].actorName
        } ?? TheAmericans.defaultActor
    }
    
    func deleteCharacter(at index: Int) {
        getCharacters.remove(at: index)
    }
    
    func resetListOfCharacters() {
        getCharacters = TheAmericans.characters
    }
}
