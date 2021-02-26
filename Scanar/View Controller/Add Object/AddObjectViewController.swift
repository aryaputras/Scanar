//
//  AddObjectViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 27/12/20.
//

import UIKit

//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED
//MARK:- THIS VC IS FUCKED


///reload data dong pas abis save anchor, jd pas balik ke awal langsung muncul lg cell yg baru di collectionview



class AddObjectViewController: UIViewController, UITextFieldDelegate {
    
    var numberOfItems: Int = 3
    
    @IBOutlet weak var addObjectCollectionView: UICollectionView!
    @IBOutlet weak var zoneIDLabel: UILabel!
    
    @IBOutlet weak var textfield: UITextField!
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObjectCollectionView.delegate = self
        self.addObjectCollectionView.dataSource = self
        
        self.addObjectCollectionView.register(AddObjectCollectionViewCell.nib(), forCellWithReuseIdentifier: "AddObjectCollectionViewCell")
        initializeHideKeyboard()
        textfield.delegate = self
        textFieldShouldReturn(textfield)
        zoneIDLabel.text = GenerateRandom()
      
        DataManager.shared.firstVC = self
    }

    
    
    //MARK: - Func
    

    
    
    
    
    
    
    //MARK: - Button
    
    
    
    @IBAction func moreCellTapped(_ sender: Any) {
        objectsData.append(NewObjectModel(refImage: nil, assImage: nil))
        addObjectCollectionView.reloadData()
    }
    
    //MARK: - cell tapped
    
    
    
    @objc func cellTapped(sender: UITapGestureRecognizer?){
        if let tapLikes = sender {
         
            let cellOwner = tapLikes.view as! AddObjectCollectionViewCell
           
            
            
          //cellOwner represents cell that is being tapped.
            ///example: cellOwner.backView
            
          performSegue(withIdentifier: "rootToAddZone", sender: Any?.self)


        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       //SEND ZONEID
        if segue.identifier == "rootToAddZone" {
            let vc = segue.destination as! AddNewZoneViewController
            vc.zoneName = textfield.text
            vc.zoneID = zoneIDLabel.text
        }
    }
}
