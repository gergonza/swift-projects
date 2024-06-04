//
//  ViewControllerColor.swift
//  SingleView
//
//  Created by Germán González on 4/6/23.
//

import UIKit

class ViewControllerColor: UIViewController {
    
    var titulo:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let tituloFinal = titulo {
            self.title = tituloFinal
            
            if tituloFinal == "Negro" {
                self.view.backgroundColor = UIColor.black
            }
            
            if tituloFinal == "Rosa" {
                self.view.backgroundColor = UIColor.systemPink
            }
            
            if tituloFinal == "Verde" {
                self.view.backgroundColor = UIColor.green
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
