//
//  AddObjectViewController+UICollectionView.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 28/12/20.
//

import Foundation
import UIKit

extension AddObjectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = addObjectCollectionView.dequeueReusableCell(withReuseIdentifier: "AddObjectCollectionViewCell", for: indexPath) as! AddObjectCollectionViewCell
        
        cell.frame.size = CGSize(width: 414, height: 172)
       
        cell.tag = indexPath.row
        
        //tap recog
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped(sender:)))
        tapRecognizer.numberOfTapsRequired = 1
        cell.addGestureRecognizer(tapRecognizer)
        
        cell.backView.image = objectsData[indexPath.item].refImage
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
