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

    @IBAction func sliderAction() {
        
        redColorNumber.text = "\(String(format: "%.2f", redSlider.value))"
        greenColorNumber.text = "\(String(format: "%.2f", greenSlider.value))"
        blueColorNumber.text = "\(String(format: "%.2f", blueSlider.value))"

        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

