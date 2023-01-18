//
//  ActorViewController.swift
//  Clase13Ejercicio1
//
//  Created by Mac on 17/01/23.
//

import UIKit

protocol ActorViewControllerProtocol: AnyObject {
    func setActorDetailView(interpretedBy actor: Actor)
}

class ActorViewController: UIViewController {
    
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorDescriptionLabel: UILabel!
    @IBOutlet weak var actorSeriesLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    

    private let brain: ActorBrainProtocol = ActorBrain()
    var actorIndex: Int?
    
    override func viewDidLoad() {
        brain.setViewController(self)
        brain.setAmericanStorageInstance((UIApplication.shared.delegate as! AmericanStorageProvider).getAmericanStorageInstance())
        guard let index = actorIndex else {return}
        self.title = brain.getCharacterName(with: index)
        brain.getActorForDetail(with: index)
    }
}

extension ActorViewController: ActorViewControllerProtocol {
    func setActorDetailView(interpretedBy actor: Actor) {
        actorNameLabel.text = brain.setActorFormat(for: actor.name)
        actorDescriptionLabel.text = brain.setDescriptionFormat(for: actor.description)
        actorSeriesLabel.text = brain.setSerieFormat(for: actor.serie)
        actorImageView.image = UIImage(named: actor.actorImage)
    }
    
}
