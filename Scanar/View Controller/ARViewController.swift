//
//  ViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 15/12/20.
//

import UIKit
import SceneKit
import ARKit
import CoreData


//Get code from Apple sample and medium "how to ARReferenceImage from network
class ARViewController: UIViewController, ARSCNViewDelegate {
    var newReferenceImages:Set<ARReferenceImage> = Set<ARReferenceImage>()
    
    var idOfZone: String?
    
    var popUpAction: SCNAction {
        return .group([
            .fadeIn(duration: 1),
            .scale(to: 1, duration: 1)
        ])
    }
    
    
    var imgRefURL: URL?
    var imgAssURL: URL?
    /// A serial queue for thread safety when modifying the SceneKit node graph.
    var downloaded: [Downloaded] = []
    var assetsToPopUp: [UIImage]?
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
                                        ".serialSceneKitQueue")
    @IBOutlet var sceneView: ARSCNView!
    
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        //2
        let fetchRequest =
            NSFetchRequest<Downloaded>(entityName: "Downloaded")
        fetchRequest.predicate = NSPredicate(format: "zoneID == %@", idOfZone!)
        //3
        do {
            downloaded = try managedContext.fetch(fetchRequest) as [Downloaded]
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        // Set the view's delegate
        sceneView.delegate = self
        
        
        // Show statistics such as fps and timing information
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        //        print(imgRefURL, imgAssURL)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Start the AR experience
        
        ///load ref image
        
        
        
        print("viewdidappear")
        
        
        resetTracking()
        
        print(downloaded)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    //MARK: - Buttons
    
    
    
    //MARK: - Image detection
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        updateQueue.async { [self] in
            
            
            let filteredDownload = downloaded.filter { (item) -> Bool in
                return item.objectIdentifier == referenceImage.name
            }
            
            
            loadImageFrom(url: filteredDownload[0].assets!) { (image) in
                
                
                
                
                // Create a plane to visualize the initial position of the detected image.
                let plane = SCNPlane(width: referenceImage.physicalSize.width,
                                     height: referenceImage.physicalSize.height)
                let planeNode = SCNNode(geometry: plane)
                // planeNode.opacity = 1
                
                
                let material = SCNMaterial()
                material.diffuse.contents = image
                material.isDoubleSided = true
                planeNode.geometry?.materials = [material]
                
                //
                //HOWWWWWWW THE FUUUUUUCCKKK WE ANCHOR THIS POSITION JUST LIKE THE USER WANTS/???????????
                planeNode.position = convertDoubleToV3(doubles: filteredDownload[0].position!)
                planeNode.scale = SCNVector3(0, 0, 0)
                planeNode.opacity = 0
                planeNode.rotation = convertDoubleToV4(doubles: filteredDownload[0].rotation!)
                
                planeNode.eulerAngles.x = -.pi / 2
                
                planeNode.runAction(popUpAction)
                
                //does not work
                node.addChildNode(planeNode)
            }
        }
        
        //Run when image detected
    }
    
    //MARK: - Tracking
    
    
    public func resetTracking() {
        
        
        print("reset tracking")
        //only load 1 image
        for download in downloaded {
            loadImageFrom(url: download.references!) { (image) in
                
                let arRefImage = ARReferenceImage(image.cgImage!, orientation: .up, physicalWidth: 0.5)
                arRefImage.name = download.objectIdentifier
                self.newReferenceImages.insert(arRefImage)
                
                
                print("fired")
                
                
                
                let configuration = ARWorldTrackingConfiguration()
                
                configuration.detectionImages = self.newReferenceImages
                configuration.automaticImageScaleEstimationEnabled = true
                configuration.maximumNumberOfTrackedImages = 3
                configuration.environmentTexturing = .automatic
                configuration.frameSemantics.insert(.personSegmentationWithDepth)
                
                self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            }
            
            
            
            //            loadImageFrom(url: download.assets!) { (image) in
            //                self.assetsToPopUp?.append(image)
            //            }
        }
    }
    
    
    // MARK: - Error handling
    
    
    
    
    
    
}

//MARK: - Extensions

