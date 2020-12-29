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



class AddObjectViewController: UIViewController {
    
    var numberOfItems: Int = 3
    
    @IBOutlet weak var addObjectCollectionView: UICollectionView!
    @IBOutlet weak var zoneIDLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObjectCollectionView.delegate = self
        self.addObjectCollectionView.dataSource = self
        
        self.addObjectCollectionView.register(AddObjectCollectionViewCell.nib(), forCellWithReuseIdentifier: "AddObjectCollectionViewCell")
     
      
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       //SEND ZONEID
        if segue.identifier == "rootToAddZone" {
            let vc = segue.destination as! AddNewZoneViewController
            
            vc.zoneID = zoneIDLabel.text
        }
    }
}
