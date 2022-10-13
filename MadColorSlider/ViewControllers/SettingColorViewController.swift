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
    
    var changeableСolor: UIColor!
    
    var delegate: SettingColorViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.backgroundColor = changeableСolor
        passedValueFromColor(redSlider, greenSlider, blueSlider)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        addToolBar(redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        getValueFromSlider(sender)
        setColor()
    }
    
    @IBAction func saveValueAndExit() {
        delegate.setNewColor(for: changeableСolor)
        dismiss(animated: true)
    }
}

// MARK: Private methods
extension SettingColorViewController {
    private func getValueFromSlider(_ slider: UISlider) {
        switch slider {
        case redSlider:
            redColorLabel.text = string(from: slider)
            redTextField.text = string(from: slider)
        case greenSlider:
            greenColorLabel.text = string(from: slider)
            greenTextField.text = string(from: slider)
        default:
            blueColorLabel.text = string(from: slider)
            blueTextField.text = string(from: slider)
        }
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
    
    private func addToolBar(_ textField: UITextField...) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
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

        toolBar.items = [flexSpace, toolBarAction]

        textField.forEach { textField in
            textField.inputAccessoryView = toolBar
        }
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func stringFrom(_ value: CGFloat) -> String {
        String(format: "%.2f", value)
    }
    
    private func setColor() {
        changeableСolor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        colorView.backgroundColor = changeableСolor
    }
    
    private func passedValueFromColor(_ slider: UISlider...) {
        let  color = CIColor(color: changeableСolor)
        
        redSlider.value = Float(color.red)
        greenSlider.value = Float(color.green)
        blueSlider.value = Float(color.blue)
        
        slider.forEach { slider in
            getValueFromSlider(slider)
        }
    }
}

// MARK:  UITextFieldDelegate
extension SettingColorViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if Float(text) ?? 0 < 0 || Float(text) ?? 0 > 1 {
            presentAlertVC(textField)
        } else {
            switch textField {
            case redTextField:
                redSlider.setValue(Float(text) ?? redSlider.value, animated: true)
                getValueFromSlider(redSlider)
            case greenTextField:
                greenSlider.setValue(Float(text) ?? greenSlider.value, animated: true)
                getValueFromSlider(greenSlider)
            default:
                blueSlider.setValue(Float(text) ?? blueSlider.value, animated: true)
                getValueFromSlider(blueSlider)
            }
            setColor()
        }
    }
}

