//
//  ViewController.swift
//  MadColorSlider
//
//  Created by Aleksandr Mayyura on 25.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redColorNumber: UILabel!
    @IBOutlet var greenColorNumber: UILabel!
    @IBOutlet var blueColorNumber: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 12
        colorView.backgroundColor = .black
    }

    @IBAction func redSliderAction() {
        redColorNumber.text = "\(String(format: "%.2f", redSlider.value))  "
        changeColor()
    }
        
    @IBAction func greenSliderAction() {
        greenColorNumber.text = "\(String(format: "%.2f", greenSlider.value))  "
        changeColor()
    }
    
    @IBAction func blueSliderAction() {
        blueColorNumber.text = "\(String(format: "%.2f", blueSlider.value))  "
        changeColor()
    }
    
    private func changeColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
}

