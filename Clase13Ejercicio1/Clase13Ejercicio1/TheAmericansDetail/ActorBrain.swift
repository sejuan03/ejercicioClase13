//
//  ActorBrain.swift
//  Clase13Ejercicio1
//
//  Created by Mac on 17/01/23.
//

import UIKit

protocol ActorBrainProtocol {
    func setViewController(_ viewController: ActorViewControllerProtocol)
    func setAmericanStorageInstance(_ americanStorageInstance: TheAmericansStorageProtocol)
    func getCharacterName(with index: Int) -> String
    func getActorForDetail(with index: Int)
    func setActorFormat(for actor: String) -> String
    func setDescriptionFormat(for description: String) -> String
    func setSerieFormat(for serie: String) -> String
}

class ActorBrain {
    private struct Constant {
        static let actor = "Interpretado por:"
        static let description = "Biografia:"
        static let serie = "A participado en:"
        static let error = "Error"
    }
    
    private weak var viewController: ActorViewControllerProtocol?
    private var theAmericansStorage: TheAmericansStorageProtocol?
}

extension ActorBrain: ActorBrainProtocol {
    func setViewController(_ viewController: ActorViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func setAmericanStorageInstance(_ americanStorageInstance: TheAmericansStorageProtocol) {
        theAmericansStorage = americanStorageInstance
    }
    
    func getCharacterName(with index: Int) -> String {
        guard let theAmericansStorage = theAmericansStorage else {return Constant.error}
        return theAmericansStorage.getCharacter(with: index).name
    }
    
    func getActorForDetail(with index: Int) {
        guard let viewController = viewController else {return}
        guard let theAmericansStorage = theAmericansStorage else {return}
        let actor = theAmericansStorage.getActorForDetail(with: index)
        viewController.setActorDetailView(interpretedBy: actor)
    }
    
    func setActorFormat(for actor: String) -> String {
        "\(Constant.actor)\n\(actor)"
    }
    
    func setDescriptionFormat(for description: String) -> String {
        "\(Constant.description)\n\(description)"
    }
    
    func setSerieFormat(for serie: String) -> String {
        "\(Constant.serie) \(serie)"
    }
}
