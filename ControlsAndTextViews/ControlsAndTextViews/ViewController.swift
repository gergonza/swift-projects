//
//  ViewController.swift
//  ControlsAndTextViews
//
//  Created by Brais Moure on 22/11/2019.
//  Copyright © 2019 MoureDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myProgressView: UIProgressView!
    @IBOutlet weak var myActivityIndicatior: UIActivityIndicatorView!
    @IBOutlet weak var myStepperLabel: UILabel!
    @IBOutlet weak var mySwitchLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    // Variables
    
    private let myPickerViewValues = ["Uno", "Dos" , "Tres", "Cuatro", "Cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Buttons
        
        myButton.setTitle("Mi Botón", for: .normal)
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.white, for: .normal)
        
        // Pickers
        
        myPickerView.backgroundColor = .lightGray
        myPickerView.dataSource = self
        myPickerView.delegate = self
        myPickerView.isHidden = true
        
        // PageControls
        
        myPageControl.numberOfPages = myPickerViewValues.count
        myPageControl.currentPageIndicatorTintColor = .blue
        myPageControl.pageIndicatorTintColor = .lightGray
        
        // SegmentedControls
        
        mySegmentedControl.removeAllSegments()
        for (index, value) in myPickerViewValues.enumerated() {
            mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        // Sliders
        
        mySlider.minimumTrackTintColor = .red
        mySlider.minimumValue = 1
        mySlider.maximumValue = Float(myPickerViewValues.count)
        mySlider.value = 1
        
        // Steppers
        
        myStepper.minimumValue = 1
        myStepper.maximumValue = Double(myPickerViewValues.count)
        
        // Switch
        
        mySwitch.onTintColor = .purple
        mySwitch.isOn = false
        
        // Progress Indicators
        
        myProgressView.progress = 0
        
        myActivityIndicatior.color = .orange
        myActivityIndicatior.startAnimating()
        myActivityIndicatior.hidesWhenStopped = true
        
        // Labels
        
        myStepperLabel.textColor = .darkGray
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 36)
        myStepperLabel.text = "1"
        
        mySwitchLabel.text = "Está apagado"
        
        // TextFields
        
        myTextField.textColor = .brown
        myTextField.placeholder = "Escribe algo"
        myTextField.delegate = self
        
        // TextViews
        
        myTextView.textColor = .brown
        myTextView.delegate = self
    }
    
    // Actions
    
    @IBAction func myButtonAction(_ sender: Any) {
        
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .green
        } else {
            myButton.backgroundColor = .blue
        }
        
        myTextView.resignFirstResponder()
    }
    
    @IBAction func myPageControlAction(_ sender: Any) {
        myPickerView.selectRow(myPageControl.currentPage, inComponent: 0, animated: true)
        
        let myString = myPickerViewValues[myPageControl.currentPage]
        myButton.setTitle(myString, for: .normal)
        
        mySegmentedControl.selectedSegmentIndex = myPageControl.currentPage
        
        let indexSliderStepper = myPageControl.currentPage + 1
        
        mySlider.value = Float(indexSliderStepper)
        
        myStepper.value = Double(indexSliderStepper)
        
        myStepperLabel.text = "\(indexSliderStepper)"
        
        let indexProgress = Float(indexSliderStepper * 100 / 5)
        
        myProgressView.progress = indexProgress / 100.0
    }
    
    @IBAction func mySegmentControlAction(_ sender: Any) {
        myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        
        let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
        
        let indexSliderStepper = mySegmentedControl.selectedSegmentIndex + 1
        
        mySlider.value = Float(indexSliderStepper)
        
        myStepper.value = Double(indexSliderStepper)
        
        myStepperLabel.text = "\(indexSliderStepper)"
        
        let indexProgress = Float(indexSliderStepper * 100 / 5)
        
        myProgressView.progress = indexProgress / 100.0
    }
    
    @IBAction func mySliderAction(_ sender: Any) {
        
        var progress: Float = 0
        
        switch mySlider.value {
        case 1..<2:
            mySegmentedControl.selectedSegmentIndex = 0
            progress = 0.2
        case 2..<3:
            mySegmentedControl.selectedSegmentIndex = 1
            progress = 0.4
        case 3..<4:
            mySegmentedControl.selectedSegmentIndex = 2
            progress = 0.6
        case 4..<5:
            mySegmentedControl.selectedSegmentIndex = 3
            progress = 0.8
        default:
            mySegmentedControl.selectedSegmentIndex = 4
            progress = 1
        }
        
        let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        myButton.setTitle(myString, for: .normal)
        
        myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        
        myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
        
        let indexStepper = mySegmentedControl.selectedSegmentIndex + 1
        
        myStepper.value = Double(indexStepper)
        
        myStepperLabel.text = "\(indexStepper)"
        
        myProgressView.progress = progress
    }
    
    @IBAction func myStepperAction(_ sender: Any) {
        
        let value = myStepper.value
        mySlider.value = Float(value)
        
        myStepperLabel.text = "\(value)"
        
        let indexPickerView = Int(value) - 1
        
        let myString = myPickerViewValues[indexPickerView]
        myButton.setTitle(myString, for: .normal)
        
        myPickerView.selectRow(indexPickerView, inComponent: 0, animated: true)
        
        myPageControl.currentPage = indexPickerView
        
        mySegmentedControl.selectedSegmentIndex = indexPickerView
        
        let indexProgress = Float(value * 100 / 5)
        
        myProgressView.progress = indexProgress / 100.0
    }
    
    @IBAction func mySwitchAction(_ sender: Any) {
        
        if mySwitch.isOn {
            myPickerView.isHidden = false
            myActivityIndicatior.stopAnimating()
            
            mySwitchLabel.text = "Está encendido"
        } else {
            myPickerView.isHidden = true
            myActivityIndicatior.startAnimating()
            
            mySwitchLabel.text = "Está apagado"
        }
    }
    
}

// UIPickerViewDataSource, UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerViewValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myString = myPickerViewValues[row]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage = row
        
        mySegmentedControl.selectedSegmentIndex = row
        
        let indexSlider = row + 1
        
        mySlider.value = Float(indexSlider)
        
        myStepper.value = Double(indexSlider)
        
        myStepperLabel.text = "\(indexSlider)"
        
        let indexProgress = Float(indexSlider * 100 / 5)
        
        myProgressView.progress = indexProgress / 100.0
    }
    
}

// UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        myButton.setTitle(myTextField.text, for: .normal)
    }
    
}

// UITextViewDelegate
extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextField.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        myTextField.isHidden = false
    }
    
}

