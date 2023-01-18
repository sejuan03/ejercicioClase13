//
//  TheAmericansViewController.swift
//  Clase13Ejercicio1
//
//  Created by Mac on 13/01/23.
//

import UIKit

protocol TheAmericansViewControllerProtocol : AnyObject {
    func navigateTowardsDetailView()
    func presentAlert(_ message: String)
    func deleteRow(at index: Int)
    func updateResetTableButton(_ enable: Bool)
}

class TheAmericansViewController: UIViewController {
    private struct Constant {
        static let cellId = "CharacterCell"
        static let goToDetailView = "goToDetail"
        static let title = "Hola!"
        static let okAction = "OK"
        static let messageAllReviewed = "Todos los personajes revisados"
        static let messageAllDeleted = "Todos los personajes eliminados"
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resetTableButton: UIBarButtonItem!
    
    private let brain: TheAmericansBrainProtocol = TheAmericansBrain()
    private var indexActorDetail = 0
    private var alertCharactersReviewed: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        brain.setViewController(self)
        brain.setAmericanStorageInstance((UIApplication.shared.delegate as! AmericanStorageProvider).getAmericanStorageInstance())
        createAlert()
    }
    
    private func createAlert() {
        alertCharactersReviewed = UIAlertController(title: Constant.title, message: Constant.messageAllReviewed, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default) { action in
            self.tableView.reloadData()
        }
        alertCharactersReviewed.addAction(okAction)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let actorViewController = segue.destination as? ActorViewController else {return}
        actorViewController.actorIndex = indexActorDetail
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if brain.validateCharactersReviewed() {
            brain.resetCharactersReviewed()
            brain.presentAlert(Constant.messageAllReviewed)
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        brain.resetRowDeleted()
        brain.updateResetTableButton()
        brain.resetCharactersReviewed()
        brain.resetListOfCharacters()
        tableView.reloadData()
    }
    
}

extension TheAmericansViewController: TheAmericansViewControllerProtocol {

    func navigateTowardsDetailView() {
        performSegue(withIdentifier: Constant.goToDetailView, sender: self)
    }
    
    func presentAlert(_ message: String) {
        alertCharactersReviewed.message = message
        present(alertCharactersReviewed, animated: true)
    }
    
    func deleteRow(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        tableView.performBatchUpdates {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        if brain.validateCharactersReviewed() && !brain.allCharactersDeleted() {
            brain.resetCharactersReviewed()
            brain.presentAlert(Constant.messageAllReviewed)
        } else if brain.allCharactersDeleted() {
            brain.presentAlert(Constant.messageAllDeleted)
        }
    }
    
    func updateResetTableButton(_ enable: Bool) {
        resetTableButton.isEnabled = enable
    }
}

extension TheAmericansViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        brain.getNumberOfCharacters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellId, for: indexPath) as! CharacterCell
        let character = brain.getCharacter(with: indexPath.row)
        cell.setCharacterName(character.name)
        cell.setActorName(character.actorName)
        cell.setSeasons(character.seasons)
        let actorImage = UIImage(named: character.actorImage)
        cell.setActorImage(actorImage)
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        
        if cell.accessoryType != .checkmark {
            cell.accessoryType = .checkmark
            indexActorDetail = indexPath.row
            brain.updateNumberOfCharactersReviewed()
            brain.navigateToDetail()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let cell = tableView.cellForRow(at: indexPath) else {return false}
        if cell.accessoryType != .checkmark {
            return brain.canDeleteCharacter(for: indexPath.row)
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            brain.rowDeleted()
            brain.updateResetTableButton()
            brain.deleteCharacter(at: indexPath.row)
        }
    }
}
