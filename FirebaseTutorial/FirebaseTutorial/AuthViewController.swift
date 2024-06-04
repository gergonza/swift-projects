//
//  AuthViewController.swift
//  FirebaseTutorial
//
//  Created by Germán González on 12/6/23.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import GoogleSignIn
import FacebookLogin
import AuthenticationServices
import CryptoKit
import FirebaseRemoteConfig

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var authStackView: UIStackView!
    
    private var currentNonce:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title
        title = "Autenticación"
        
        // Analytics Event
        Analytics.logEvent("InitScreen", parameters: ["message": "Integración de Firebase Completa"])
        
        // Comprobar si existe email y provider
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String, let provider = defaults.value(forKey: "provider") as? String {
            authStackView.isHidden = true
            
            self.navigationController?.pushViewController(HomeViewController(email: email, provider: ProviderType.init(rawValue: provider)!), animated: false)
        }
        
        // Remote Config
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 60
        
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(["show_error_button": NSNumber(true), "error_button_text": NSString("Forzar error")])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authStackView.isHidden = false
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                if let result = result, error == nil {
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            switchHome(credential: credential, provider: .basic)
        }
    }
    
    @IBAction func googleButtonAction(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) {
            (signInResult, error) in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: signInResult.user.idToken!.tokenString, accessToken: signInResult.user.accessToken.tokenString)
            self.switchHome(credential: credential, provider: .google)
          }
    }
    
    @IBAction func facebookButtonAction(_ sender: Any) {
        guard let configuration = LoginConfiguration(
            permissions:["email"]
        ) else {
            return
        }
                
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(configuration: configuration) {
            (result)  in
            switch result {
            case .success(granted: let granted, declined: let declined, token: let token):
                let credential = FacebookAuthProvider.credential(withAccessToken: token!.tokenString)
                self.switchHome(credential: credential, provider: .facebook)
            case .cancelled:
                break
            case .failed(_):
                break
            }
        }
    }
    
    // MARK: - Configurar Apple Developer Program y configurar Apple Single Sign-In (ver tutorial de Brais Moure en Curso de Desarrollo Swift y iOS en Udemy)
    @IBAction func appleButtonAction(_ sender: Any) {
        currentNonce = randomNonceString()
        
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.email]
        request.nonce = sha256(currentNonce!)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func switchHome(credential:AuthCredential, provider: ProviderType) {
        Auth.auth().signIn(with: credential) {
            (result, error) in
            if let result = result, error == nil {
                self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: provider), animated: true)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error en el inicio de sesión del usuario", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // It is necessary for Apple Auth
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
        
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    
    // It is necessary for Apple Auth
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
        
      let hashedData = SHA256.hash(data: inputData)
        
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}

// It is necessary for Apple Auth
extension AuthViewController:ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let nonce = currentNonce, let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
           let appleIdToken = appleIdCredential.identityToken,
           let appleIdTokenString = String(data: appleIdToken, encoding: .utf8) {
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: appleIdTokenString, rawNonce: nonce)
            self.switchHome(credential: credential, provider: .apple)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
