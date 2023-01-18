//
//  TheAmericansBrain.swift
//  Clase13Ejercicio1
//
//  Created by Mac on 17/01/23.
//

import UIKit

protocol TheAmericansBrainProtocol {
    func setViewController(_ viewController: TheAmericansViewControllerProtocol)
    func setAmericanStorageInstance(_ americanStorageInstance: TheAmericansStorageProtocol)
    func getNumberOfCharacters() -> Int
    func getCharacter(with index: Int) -> Character
    func updateNumberOfCharactersReviewed()
    func navigateToDetail()
    func validateCharactersReviewed() -> Bool
    func resetCharactersReviewed()
    func presentAlert(_ message: String)
    func canDeleteCharacter(for index: Int) -> Bool
    func deleteCharacter(at index: Int)
    func rowDeleted()
    func resetRowDeleted()
    func updateResetTableButton()
    func resetListOfCharacters()
    func allCharactersDeleted() -> Bool
}

protocol TheAmericansBrainCellProtocol {
    func setCharacterFormat(_ character: String) -> String
    func setActorFormat(_ name: String) -> String
    func setSeasonsFormat(_ seasons: String) -> String
}

class TheAmericansBrain {
    private struct Constant {
        static let character = "Personaje:"
        static let actor = "Interpretado por:"
        static let seasons = "Temporadas:"
    }

    private weak var viewController: TheAmericansViewControllerProtocol?
    private var theAmericansStorage: TheAmericansStorageProtocol?
    
    private var charactersReviewed = 0
    private var isRowDeleted = false
}

extension TheAmericansBrain: TheAmericansBrainProtocol {
    
    func setViewController(_ viewController: TheAmericansViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func setAmericanStorageInstance(_ americanStorageInstance: TheAmericansStorageProtocol) {
        theAmericansStorage = americanStorageInstance
    }
    
    func getNumberOfCharacters() -> Int {
        guard let theAmericansStorage = theAmericansStorage else {return 0}
        return theAmericansStorage.getNumberOfCharacters()
    }
    
    func getCharacter(with index: Int) -> Character {
        return (theAmericansStorage?.getCharacter(with: index))!
    }
    
    func updateNumberOfCharactersReviewed() {
        charactersReviewed += 1
    }
    
    func navigateToDetail() {
        guard let viewController = viewController else {return}
        viewController.navigateTowardsDetailView()
    }
    
    func validateCharactersReviewed() -> Bool {
        guard let theAmericansStorage = theAmericansStorage else {return false}
        return charactersReviewed == theAmericansStorage.getNumberOfCharacters()
    }
    
    func resetCharactersReviewed() {
        charactersReviewed = 0
    }
    
    func presentAlert(_ message: String) {
        guard let viewController = viewController else {return}
        viewController.presentAlert(message)
    }
    
    func canDeleteCharacter(for index: Int) -> Bool {
        true
    }
    
    func deleteCharacter(at index: Int) {
        guard let viewController = viewController else {return}
        guard let theAmericansStorage = theAmericansStorage else {return}
        theAmericansStorage.deleteCharacter(at: index)
        viewController.deleteRow(at: index)
    }
    
    func rowDeleted() {
        isRowDeleted = true
    }
    
    func resetRowDeleted() {
        isRowDeleted = false
    }
    
    func updateResetTableButton() {
        guard let viewController = viewController else {return}
        viewController.updateResetTableButton(isRowDeleted)
    }
    
    func resetListOfCharacters() {
        guard let theAmericansStorage = theAmericansStorage else {return}
        theAmericansStorage.resetListOfCharacters()
    }
    
    func allCharactersDeleted() -> Bool {
        guard let theAmericansStorage = theAmericansStorage else {return false}
        return theAmericansStorage.getNumberOfCharacters() == 0
    }
}

extension TheAmericansBrain: TheAmericansBrainCellProtocol {
    func setCharacterFormat(_ character: String) -> String {
        "\(Constant.character)\n\(character)"
    }
    
    func setActorFormat(_ name: String) -> String {
        "\(Constant.actor)\n\(name)"
    }
    
    func setSeasonsFormat(_ seasons: String) -> String {
        "\(Constant.seasons) \(seasons)"
    }
}
