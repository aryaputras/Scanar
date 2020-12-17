//
//  SuccesViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import UIKit

class SuccesViewController: UIViewController {
    @IBOutlet weak var QRImageView: UIImageView!
    @IBOutlet weak var zoneIDLabel: UILabel!
    var zoneID: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        QRImageView.image = generateQRCode(from: zoneID!)
        zoneIDLabel.text = zoneID
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
