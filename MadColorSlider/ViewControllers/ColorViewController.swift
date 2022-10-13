//
//  ColorViewController.swift
//  MadColorSlider
//
//  Created by Aleksandr Mayyura on 11.10.2022.
//

import UIKit

protocol SettingColorViewControllerDelegate{
    func setNewColor(for color: UIColor)
}

class ColorViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingColorVC = segue.destination as? SettingColorViewController else { return }
        settingColorVC.changeableСolor = view.backgroundColor
        settingColorVC.delegate = self
    }
}

// MARK: SettingColorViewControllerDelegate
extension ColorViewController: SettingColorViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        view.backgroundColor = color
    }
}
