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





class AddObjectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var numberOfItems: Int = 3
    
    @IBOutlet weak var addObjectCollectionView: UICollectionView!
    @IBOutlet weak var zoneIDLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObjectCollectionView.delegate = self
        self.addObjectCollectionView.dataSource = self
        
        self.addObjectCollectionView.register(AddObjectCollectionViewCell.nib(), forCellWithReuseIdentifier: "AddObjectCollectionViewCell")
        
        
        zoneIDLabel.text = GenerateRandom()
        
    }
    
    
    //MARK: - Func
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = addObjectCollectionView.dequeueReusableCell(withReuseIdentifier: "AddObjectCollectionViewCell", for: indexPath) as! AddObjectCollectionViewCell
        
        cell.frame.size = CGSize(width: 414, height: 172)
       
        cell.tag = indexPath.row
        
        //tap recog
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped(sender:)))
        tapRecognizer.numberOfTapsRequired = 1
        cell.addGestureRecognizer(tapRecognizer)
        
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //MARK: - Button
    
    
    
    @IBAction func moreCellTapped(_ sender: Any) {
        numberOfItems += 1
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
       
    }
    
    
    

    

}
