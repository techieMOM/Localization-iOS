//
//  ViewController.swift
//  Localisation Demo
//
//  Created by SOWJI on 05/09/20.
//  Copyright © 2020 Techie MOM by SOWJI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var languageField: UITextField!
    var localisationString = "Here we are doing localisation from controller"
    var picker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPicker()
        let lstring = LocalisationManager.localisedString(self.localisationString)
        print(localisationString + "-----" + lstring )
        self.aboutLabel.text = lstring
        // Do any additional setup after loading the view.
    }

    @IBAction func switchLanguage(_ sender: UIButton) {
       
    }
    
    func setupPicker() {
        self.picker.backgroundColor = .gray
        self.picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: self.view.frame.width, height: 150))
        self.picker.delegate = self
        self.picker.dataSource = self
        self.setPicerData()
        self.languageField.inputView = self.picker
    }
    func setPicerData() {
        let languageCode = LocalData.getLanguage(LocalData.language)
        if let lang = languages.filter({$0.1 == languageCode}).first {
            self.languageField.text = lang.0
            self.picker.selectRow(lang.1 == "en" ? 0 : 1, inComponent: 0, animated: false)
        }
    }
    
}
extension ViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.languageField.resignFirstResponder()
        let language = languages[row]
        self.languageField.text = language.0
        self.setLanguage(language.1)
    }
    
    func setLanguage(_ code : String) {
        let selectedLangCode = LocalData.getLanguage(LocalData.language)
        print(selectedLangCode)
        if selectedLangCode != code {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            Bundle.setLanguage(code)
            if #available(iOS 13.0, *) {
                if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
                }
            }else {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                           delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
                }}
        
        }
    }
}
