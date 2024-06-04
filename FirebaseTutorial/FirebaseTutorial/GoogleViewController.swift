//
//  GoogleViewController.swift
//  FirebaseTutorial
//
//  Created by Germán González on 12/6/23.
//

import UIKit
import FirebaseCore
import GoogleSignIn

class GoogleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    guard let clientID = FirebaseApp.app()?.options.clientID else { return }

    // Create Google Sign In configuration object.
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config

    // Start the sign in flow!
    GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
      guard error == nil else {
        // ...
      }

      guard let user = result?.user,
        let idToken = user.idToken?.tokenString
      else {
        // ...
      }

      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: user.accessToken.tokenString)

      // ...
    }

}
