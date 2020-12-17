//
//  JoinViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 17/12/20.
//

import UIKit





class JoinViewController: UIViewController, UITextFieldDelegate {
   
    
    var zoneIDPassed: String?
 
    @IBOutlet weak var zoneIDLabel: UILabel!
    
    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        textfield.delegate = self
        textFieldShouldReturn(textfield)
        
        
        
        
        /// Do any additional setup after loading the view.
    }
    


    @IBAction func joinClicked(_ sender: Any) {
        //ifzoneavailable == true = zone not exist
        joinZone(zoneID: zoneIDPassed ?? "")
        print(zoneIDPassed)
    }
    
    
    
 
    
   
//MARK: - Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zoneIDPassed = textField.text
        self.view.endEditing(true)
        return false
    }
    func initializeHideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
     
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
   
        view.endEditing(true)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? ScannerViewController,
                segue.identifier == "homeToContainer" {
                vc.delegate = self
            }
    }
}
extension JoinViewController:ChildToParentProtocol {
    func needToPassInfoToParent(with value: String) {
        zoneIDPassed = value
    }
    
   }
