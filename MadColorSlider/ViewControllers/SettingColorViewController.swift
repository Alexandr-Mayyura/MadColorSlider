//
//  SettingColorViewController.swift
//  MadColorSlider
//
//  Created by Aleksandr Mayyura on 25.09.2022.
//

import UIKit

class SettingColorViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var backgroundColor: UIColor!
    
    var delegate: SettingColorViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.backgroundColor = backgroundColor
        passedValueFromColor()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        addToolBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        getValueFromTextfield()
        updateUI()
        view.endEditing(true)
    }
    
    @IBAction func sliderAction() {
      
        backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        
        updateUI()
    }
    
    @IBAction func saveValueAndExit() {
        delegate.setNewColor(for: backgroundColor)
        dismiss(animated: true)
    }
    
    private func presentAlertVC(_ textField: UITextField? = nil) {
        let alertVC = UIAlertController(
            title: "Ошибка",
            message: "Введите число от 0 до 1",
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField?.text = ""
        }
        alertVC.addAction(alertAction)
        present(alertVC, animated: true)
    }
    
    private func addToolBar() {
        let toolBar = UIToolbar(frame: CGRect(
            x: 0,
            y: 0,
            width: view.frame.size.width,
            height: 80
        ))
        toolBar.barStyle = .black
        
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let toolBarAction = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: nil,
            action: #selector(doneButtonTapped)
        )
        
        let items = [flexSpace, toolBarAction]
        toolBar.items = items
        toolBar.sizeToFit()
        
        greenTextField.inputAccessoryView = toolBar
        redTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
        
        
    }
    
    @objc private func doneButtonTapped() {
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
        getValueFromTextfield()
        updateUI()
    }
}

// MARK: Private methods
extension SettingColorViewController {
    private func updateUI() {
        
        colorView.backgroundColor = backgroundColor
        
        redColorLabel.text = "\(String(format: "%.2f", redSlider.value))"
        greenColorLabel.text = "\(String(format: "%.2f", greenSlider.value))"
        blueColorLabel.text = "\(String(format: "%.2f", blueSlider.value))"
        
    }
    
    private func passedValueFromColor() {
        let  color = CIColor(color: backgroundColor)
        
        redSlider.value = Float(color.red)
        greenSlider.value = Float(color.green)
        blueSlider.value = Float(color.blue)
        
        redColorLabel.text = "\(String(format: "%.2f", color.red))"
        greenColorLabel.text = "\(String(format: "%.2f", color.green))"
        blueColorLabel.text = "\(String(format: "%.2f", color.blue))"
        
        redTextField.text = "\(String(format: "%.2f", color.red))"
        greenTextField.text = "\(String(format: "%.2f", color.green))"
        blueTextField.text = "\(String(format: "%.2f", color.blue))"
        
    }
    
    private func getValueFromTextfield() {
        
        guard let redText = redTextField.text else { return }
        if Float(redText) ?? 0.0 < 0 || Float(redText) ?? 0.0 > 1 {
            presentAlertVC(redTextField)
        } else {
            redSlider.value = Float(redText) ?? redSlider.value
        }
        
        guard let greenText = greenTextField.text else { return }
        if Float(greenText) ?? 0.0 < 0 || Float(greenText) ?? 0.0 > 1 {
            presentAlertVC(greenTextField)
        } else {
            greenSlider.value = Float(greenText) ?? greenSlider.value
        }
        
        guard let blueText = blueTextField.text else { return }
        if Float(blueText) ?? 0.0 < 0 || Float(blueText) ?? 0.0 > 1 {
            presentAlertVC(blueTextField)
        } else {
            blueSlider.value = Float(blueText) ?? blueSlider.value
        }
        
        redColorLabel.text = "\(String(format: "%.2f", redText))"
        greenColorLabel.text = "\(String(format: "%.2f", greenText))"
        blueColorLabel.text = "\(String(format: "%.2f", blueText))"
        
        backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

// MARK:  UITextFieldDelegate
extension SettingColorViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        getValueFromTextfield()
        updateUI()
    }
}

