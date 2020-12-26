//
//  ViewController.swift
//  MoveAxisTest
//
//  Created by Abigail Aryaputra Sudarman on 22/12/20.
//

import UIKit
import SceneKit
import ARKit

class AnchoringViewController: UIViewController, ARSCNViewDelegate {
    
    ///Reveived images from segues
var refImage: UIImage?
    
    var assetImage: UIImage?
    var savedPosition: SCNVector3?
    var savedRotation: SCNVector4?

    var zoneName: String? = ""
    var zoneID: String? = ""
    
    @IBOutlet var sceneView: ARSCNView!
    
    
    
    
    //MOVE BY
    ///Plus
    let moveByY = SCNAction.moveBy(x: 0, y: 0.1, z: 0, duration: 1)
    let moveByX = SCNAction.moveBy(x: 0.1, y: 0, z: 0, duration: 1)
    let moveByZ = SCNAction.moveBy(x: 0, y: 0, z: 0.1, duration: 1)
    
    ///Minus
    let moveByMinY = SCNAction.moveBy(x: 0, y: -0.1, z: 0, duration: 1)
    let moveByMinX = SCNAction.moveBy(x: -0.1, y: 0, z: 0, duration: 1)
    let moveByMinZ = SCNAction.moveBy(x: 0, y: 0, z: -0.1, duration: 1)
    
    //ROTATE BY
    let rotateByX = SCNAction.rotateBy(x: 0.1, y: 0, z: 0, duration: 1)
    let rotateByY = SCNAction.rotateBy(x: 0, y: 0.1, z: 0, duration: 1)
    let rotateByZ = SCNAction.rotateBy(x: 0, y: 0, z: 0.1, duration: 1)
    
    
    
    //RESET POSITION
    let resetPosition = SCNAction.move(to: SCNVector3(0, 0, 0), duration: 1)
    
    
    //RESET ROTATION
    
    let resetRotation = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)
    
    
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
                                        ".serialSceneKitQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        var cgi = refImage?.cgImage
        print(cgi)
        

        let ref = ARReferenceImage(cgi!, orientation: .up, physicalWidth: 0.5)
        ref.name = "hhh"
        
        configuration.detectionImages.insert(ref)
        configuration.automaticImageScaleEstimationEnabled = true
        configuration.maximumNumberOfTrackedImages = 1
        configuration.environmentTexturing = .automatic
        configuration.frameSemantics.insert(.personSegmentationWithDepth)
         //Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    @IBAction func moveMinZTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(moveByMinZ)
    }
    
    
    @IBAction func moveMinYTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(moveByMinY)
    }
    
    
    @IBAction func moveByMinXTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(moveByMinX)
    }
    
    
    @IBAction func moveZTapped(_ sender: Any) {
        
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(moveByZ)
    }
    @IBAction func moveYTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(moveByY)
    }
    
    @IBAction func moveXTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(moveByX)
    }
    
    
    @IBAction func rotateZTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(rotateByZ)
    }
    @IBAction func rotateYTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(rotateByY)
    }
    @IBAction func rotateXTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(rotateByX)
    }
    
    @IBAction func resetPosTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(resetPosition)
    }
    @IBAction func resetRotTapped(_ sender: Any) {
        sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.runAction(resetRotation)
    }
    
    
    
    //save
    @IBAction func save(_ sender: Any) {
        saveAnchor()
        
        //Get value each axis by adding (.x)
    }
    
    
    
    // MARK: - ARSCNViewDelegate
    
    
    func saveAnchor() {
        savedPosition = sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.position
        savedRotation = sceneView.scene.rootNode.childNode(withName: "popup", recursively: true)?.rotation
        
        let convertedPos = convertV3ToDouble(vector: savedPosition!)
        let convertedRot = convertV4ToDouble(vector: savedRotation!)
        
        
        var imageRefURL: URL
        var assetsURL: URL
        zoneID = GenerateUniqueCode()
        //just save 1 image
        
        
        imageRefURL = imageToURL(image: refImage!)
        
        //assetsURL is fake
        assetsURL = imageToURL(image: assetImage!)
        //Remove force unwrap and give UI warning if field is empty
        
        if isZoneAvailable(zoneIDToCheck: zoneID!) == true {
            
            uploadNewZone(zoneID: zoneID!, references: imageRefURL, zoneName: zoneName!, assets: assetsURL, position: convertedPos, rotation: convertedRot)
            
            
            //segue after all finished
           
        } else {
            print("Zone ID duplicate available ")
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        
        //what size is this
        let referenceImage = imageAnchor.referenceImage
        updateQueue.async {
            
            print("rendered")
            // Create a plane to visualize the initial position of the detected image.
            let plane = SCNPlane(width: referenceImage.physicalSize.width,
                                 height: referenceImage.physicalSize.height)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 1
            
        
            let material = SCNMaterial()
            material.diffuse.contents = self.assetImage
            
            
            planeNode.geometry?.materials = [material]
            
            planeNode.eulerAngles.x = -.pi / 2
            planeNode.name = "popup"
           
            node.addChildNode(planeNode)
        }

        //Run when image detected
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    //MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "anchorToFinish" {
            let vc = segue.destination as! SuccesViewController
            vc.zoneID = zoneID
            
            
        }
    }
}
