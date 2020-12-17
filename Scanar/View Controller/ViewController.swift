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
class ViewController: UIViewController, ARSCNViewDelegate {
    var newReferenceImages:Set<ARReferenceImage> = Set<ARReferenceImage>();
    /// A serial queue for thread safety when modifying the SceneKit node graph.
    var downloaded: [NSManagedObject] = []
    var assetsToPopUp: [UIImage] = []
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
          NSFetchRequest<NSManagedObject>(entityName: "Downloaded")
        
        //3
        do {
          downloaded = try managedContext.fetch(fetchRequest)
            print(downloaded)
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
        
        
        
        resetTracking()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Start the AR experience
      //  resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    //MARK: - Buttons
    
    @IBAction func newZoneDidTap(_ sender: Any) {
        
    }
    
    
    //MARK: - Image detection
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        updateQueue.async {
            
            // Create a plane to visualize the initial position of the detected image.
            let plane = SCNPlane(width: referenceImage.physicalSize.width,
                                 height: referenceImage.physicalSize.height)
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 0.25
            
            
            
            planeNode.eulerAngles.x = -.pi / 2
            planeNode.runAction(self.imageHighlightAction)
           
            node.addChildNode(planeNode)
        }

        //Run when image detected
    }
    
    
    func loadImageFrom(url: URL, completionHandler:@escaping(UIImage)->()) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        print("LOADED ASSET");
                        completionHandler(image);
                    }
                }
            }
        }
    }
    
    
    public func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
//        configuration.detectionImages = newReferenceImages
        configuration.maximumNumberOfTrackedImages = 1
        configuration.environmentTexturing = .automatic
        configuration.frameSemantics.insert(.personSegmentationWithDepth)
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    var imageHighlightAction: SCNAction {
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOut(duration: 0.5),
            .removeFromParentNode()
        ])
    }

    // MARK: - Error handling
    
    

    
    
    
}

//MARK: - Extensions

extension ViewController:JoinToHomeProtocol {
    func setupAR(refURL: [URL], assURL: [URL]) {
        
        //load reference image from local dir
        for url in refURL {
        loadImageFrom(url: url) { (result) in
            
            let arImage = ARReferenceImage(result.cgImage!, orientation: CGImagePropertyOrientation.up, physicalWidth: 10)
           
            arImage.name = "referenceOne"
            
            self.newReferenceImages.insert(arImage)
            
            self.resetTracking()
        }
        }
        
        
        for url in assURL {
            
        }
        
        
    }
    
    
}
