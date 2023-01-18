//
//  CharacterCell.swift
//  Clase13Ejercicio1
//
//  Created by Mac on 16/01/23.
//

import UIKit

protocol CharacterCellProtocol where Self: UITableViewCell {
    func setCharacterName(_ character: String)
    func setActorName(_ name: String)
    func setSeasons(_ seasons: String)
    func setActorImage(_ actorImage: UIImage?)
}

class CharacterCell: UITableViewCell {
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var actorNameLable: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    
    private let brain: TheAmericansBrainCellProtocol = TheAmericansBrain()
}

extension CharacterCell: CharacterCellProtocol {
    func setCharacterName(_ character: String) {
        characterNameLabel.text = brain.setCharacterFormat(character)
    }
    
    func setActorName(_ name: String) {
        actorNameLable.text = brain.setActorFormat(name)
    }
    
    func setSeasons(_ seasons: String) {
        seasonsLabel.text = brain.setSeasonsFormat(seasons)
    }
    
    func setActorImage(_ actorImage: UIImage?) {
        actorImageView.image = actorImage
    }
}
