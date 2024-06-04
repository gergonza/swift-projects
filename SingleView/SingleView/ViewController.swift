//
//  ViewController.swift
//  SingleView
//
//  Created by Germán González on 4/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    var opcion:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BotonNegro(_ sender: Any) {
        opcion = "Negro"
        performSegue(withIdentifier: "VCColor", sender: self)
    }
    
    @IBAction func BotonRosa(_ sender: Any) {
        opcion = "Rosa"
        performSegue(withIdentifier: "VCColor", sender: self)
    }

    @IBAction func BotonVerde(_ sender: Any) {
        opcion = "Verde"
        performSegue(withIdentifier: "VCColor", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VCColor" {
            if let destino = segue.destination as? ViewControllerColor {
                destino.titulo = opcion
            }
        }
    }
}

