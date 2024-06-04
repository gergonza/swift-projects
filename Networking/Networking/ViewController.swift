//
//  ViewController.swift
//  Networking
//
//  Created by Germán González on 11/6/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var downloadImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom of Name Label
        nameLabel.text = ""
        nameLabel.numberOfLines = 0
        
        // Custom of Email Label
        emailLabel.text = ""
        emailLabel.numberOfLines = 0
        
        // Custom of Id Label
        idLabel.text = ""
        
        // Custom of Activity Indicator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Buttons
    @IBAction func getUserAction(_ sender: Any) {
        activityIndicator.startAnimating()
        NetworkingProvider.shared.getUser(id: getId()) { (User) in
            self.setupUser(user: User)
        } failure: { error in
            self.setupError(error: error)
        }
    }
    
    @IBAction func addUserAction(_ sender: Any) {
        let newUser = NewUser(name: "MoureDev", email: "mouredev@test.com8", gender: "Male", status: "Active")
        activityIndicator.startAnimating()
        NetworkingProvider.shared.addUser(user: newUser) { (User) in
            self.setupUser(user: User)
        } failure: { error in
            self.setupError(error: error)
        }
    }
    
    @IBAction func updateUserAction(_ sender: Any) {
        let newUser = NewUser(name: "MoureDev 2", email: nil, gender: nil, status: nil)
        activityIndicator.startAnimating()
        NetworkingProvider.shared.updateUser(id: getId(), user: newUser) { (User) in
            self.setupUser(user: User)
        } failure: { error in
            self.setupError(error: error)
        }
    }
    
    @IBAction func deleteUserAction(_ sender: Any) {
        activityIndicator.startAnimating()
        let id = getId()
        NetworkingProvider.shared.deleteUser(id: id) {
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = "Se ha eliminado el usuario con ID: \(id)"
        } failure: { error in
            self.setupError(error: error)
        }
    }
    
    @IBAction func downloadImageButton(_ sender: Any) {
        downloadImageButton.isHidden = true
        logoImageView.kf.setImage(with: URL(string: "https://www.apple.com/v/swift/c/images/overview/icon_swift_hero_large.png"))
    }
    
    // MARK: - Custom Functions
    private func setupUser(user:User) {
        self.activityIndicator.stopAnimating()
        nameLabel.text = user.name
        emailLabel.text = user.email
        idLabel.text = user.id?.description
    }
    
    private func setupError(error:Error?) {
        activityIndicator.stopAnimating()
        nameLabel.text = error.debugDescription
        print(error.debugDescription)
    }
    
    private func getId() -> Int {
        var id = 0
        if let labelText = idLabel.text,
           let intValue = Int(labelText) {
            id = intValue
        } else {
            id = 2785811
        }
        return id
    }
}
