

import UIKit
import AVFoundation

class HomeViewController: UIViewController {

    
    @IBOutlet weak var previewView: UIView!
    
  
   

    //Camera Capture requiered properties
    var videoDataOutput: AVCaptureVideoDataOutput!
    var videoDataOutputQueue: DispatchQueue!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var captureDevice : AVCaptureDevice!
    let session = AVCaptureSession()
    var currentFrame: CIImage!
    var done = false

    override func viewDidLoad() {
        super.viewDidLoad()
       

        //Add a box view
     

        self.setupAVCapture()
    }

    override func viewWillAppear(_ animated: Bool) {
        if !done {
            session.startRunning()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var shouldAutorotate: Bool {
        if (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft ||
        UIDevice.current.orientation == UIDeviceOrientation.landscapeRight ||
            UIDevice.current.orientation == UIDeviceOrientation.unknown) {
            return false
        }
        else {
            return true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopCamera()
    }
}


// AVCaptureVideoDataOutputSampleBufferDelegate protocol and related methods
extension HomeViewController:  AVCaptureVideoDataOutputSampleBufferDelegate{
    func setupAVCapture(){
        session.sessionPreset = AVCaptureSession.Preset.hd1280x720
        guard let device = AVCaptureDevice
        .default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                 for: .video,
                 position: AVCaptureDevice.Position.back) else{
                            return
        }
        captureDevice = device
        beginSession()
        done = true
    }

    func beginSession(){
        var deviceInput: AVCaptureDeviceInput!
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            guard deviceInput != nil else {
                print("error: cant get deviceInput")
                return
            }

            if self.session.canAddInput(deviceInput){
                self.session.addInput(deviceInput)
            }

            videoDataOutput = AVCaptureVideoDataOutput()
            videoDataOutput.alwaysDiscardsLateVideoFrames=true
            videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
            videoDataOutput.setSampleBufferDelegate(self, queue:self.videoDataOutputQueue)

            if session.canAddOutput(self.videoDataOutput){
                session.addOutput(self.videoDataOutput)
            }

            videoDataOutput.connection(with: AVMediaType.video)?.isEnabled = true

            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
            self.previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect

            let rootLayer: CALayer = self.previewView.layer
            rootLayer.masksToBounds = true
            self.previewLayer.frame = rootLayer.bounds
            rootLayer.addSublayer(self.previewLayer)
            session.startRunning()
        } catch let error as NSError {
            deviceInput = nil
            print("error: \(error.localizedDescription)")
        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        currentFrame =   self.convertImageFromCMSampleBufferRef(sampleBuffer)
    }


    // clean up AVCapture
    func stopCamera(){
        session.stopRunning()
        done = false
    }

    func convertImageFromCMSampleBufferRef(_ sampleBuffer:CMSampleBuffer) -> CIImage{
        let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        let ciImage:CIImage = CIImage(cvImageBuffer: pixelBuffer)
        return ciImage
    }
}
