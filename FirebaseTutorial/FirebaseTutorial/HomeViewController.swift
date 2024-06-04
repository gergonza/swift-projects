//
//  HomeViewController.swift
//  FirebaseTutorial
//
//  Created by Germán González on 12/6/23.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FacebookLogin
import FirebaseCrashlytics
import FirebaseRemoteConfig
import FirebaseFirestore

enum ProviderType:String {
    case basic
    case google
    case facebook
    case apple
}

class HomeViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var closeSessionButton: UIButton!
    @IBOutlet weak var errorButton: UIButton!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    private let email:String
    private let provider:ProviderType
    
    private let db = Firestore.firestore()
    
    init(email: String, provider: ProviderType){
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Inicio"
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        self.emailLabel.text = email
        self.providerLabel.text = provider.rawValue
        
        // Guardamos los datos del usuario
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
        
        // Remote Config
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate {
            (status, error) in
            if status != .error {
                let showErrorButton = remoteConfig.configValue(forKey: "show_error_button").boolValue
                
                let errorButtonText = remoteConfig.configValue(forKey: "error_button_text").stringValue
                
                DispatchQueue.main.async {
                    self.errorButton.isHidden = !showErrorButton
                    
                    self.errorButton.setTitle(errorButtonText, for: .normal)
                }
            }
        }
    }
    
    @IBAction func closeSessionButtonAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        switch provider {
        case .basic:
            firebaseLogOut()
        case .google:
            GIDSignIn.sharedInstance.signOut()
            firebaseLogOut()
        case .facebook:
            LoginManager().logOut()
            firebaseLogOut()
        case .apple:
            firebaseLogOut()
        }
    }
    
    // MARK: - Se pueden generar archivos dSYM localmente, pero es necesario tener una cuenta de Apple Developer
    @IBAction func errorButtonAction(_ sender: Any) {
        // Enviar el Id del Usuario
        Crashlytics.crashlytics().setUserID(email)
        
        // Envío de claves personalizadas
        Crashlytics.crashlytics().setCustomValue(provider, forKey: "PROVIDER")
        
        // Envío de Log de Errores
        Crashlytics.crashlytics().log("Hemos pulsado el botón Forzar Error")
        
        fatalError()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        view.endEditing(true)
        
        db.collection("users").document(email).setData(["provider": provider.rawValue, "address": addressTextField.text ?? "", "phone": phoneTextField.text ?? ""])
    }
    
    @IBAction func getButtonAction(_ sender: Any) {
        view.endEditing(true)
        
        db.collection("users").document(email).getDocument {
            (documentSnapshot, error) in
            if let document = documentSnapshot, error == nil {
                if let address = document.get("address") as? String {
                    self.addressTextField.text = address
                } else {
                    self.addressTextField.text = ""
                }
                
                if let phone = document.get("phone") as? String {
                    self.phoneTextField.text = phone
                } else {
                    self.phoneTextField.text = ""
                }
            } else {
                self.addressTextField.text = ""
                self.phoneTextField.text = ""
            }
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        view.endEditing(true)
        
        db.collection("users").document(email).delete()
    }
    
    private func firebaseLogOut() {
        do {
            GIDSignIn.sharedInstance.signOut()
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch {
            // Se ha producido un error
        }
    }
}
