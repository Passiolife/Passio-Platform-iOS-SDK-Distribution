//  Copyright © 2022 Passio Inc. All rights reserved.
//
import UIKit
import AVFoundation
import PassioPlatformSDK

class VideoViewController: UIViewController {

    @IBOutlet weak var labelBackgroundView: UIView!
    @IBOutlet weak var labelDetected: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let passioSDK = PassioPlatformAISDK.shared
    var videoLayer: AVCaptureVideoPreviewLayer?

    var passioIsDetecting = false

    override func viewDidLoad() {
        super.viewDidLoad()
#error("Replace the SDK Key and the project ID. For directions open the README.md under the Documentations.")
        let key = "Your_SDK_Key"
        let projectID = "Your_projectID"
        var passioConfig = PassioConfiguration(key: key)
        passioConfig.projectID = projectID
        passioSDK.configure(passioConfiguration: passioConfig) { status in
            print( "SDK status = \(status)")
        }
        passioSDK.statusDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        labelDetected.text = "Configuring SDK"
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized { // already authorized
            setupVideoLayer()
        } else {
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted { // access to video granted
                    DispatchQueue.main.async {
                        self.setupVideoLayer()
                    }
                } else {
                    print("The user didn't grant access to use camera")
                }
            }
        }
    }

    func setupVideoLayer() {
        guard videoLayer == nil else { return }
        if let vLayer = passioSDK.getPreviewLayer() {
            self.videoLayer = vLayer
            videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoLayer?.frame = view.frame
            view.layer.insertSublayer(vLayer, at: 0)
        }
        if passioSDK.status.mode == .isReadyForDetection {
            startDetection()
        }
    }

    func startDetection() {
        guard !passioIsDetecting else { return }
        passioSDK.startDetection(detectionDelegate: self) { isReady in
            print("startCustomObjectDetection started \(isReady)" )
            self.passioIsDetecting = true
        }
    }

    func stopDetection() {
        passioSDK.stopDetection()
        passioIsDetecting = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        passioSDK.stopDetection()
        videoLayer?.removeFromSuperlayer()
        videoLayer = nil
    }

}

extension VideoViewController: DetectionDelegate {

    func detectionResult(candidates: [DetectionCandidate]?,
                         image: UIImage?) {
        //        print("candidate  =\(candidates)")
        DispatchQueue.main.async {
            self.labelBackgroundView.isHidden = false
            self.activityIndicator.startAnimating()
            self.labelDetected.text = "Scanning"
            if let first = candidates?.first {
                self.displayCandidate(candidate: first)
            }
        }
    }

    func displayCandidate(candidate: DetectionCandidate) {
        self.activityIndicator.stopAnimating()
        self.labelDetected.text = candidate.label?.capitalized ?? candidate.passioID
    }

}

extension VideoViewController: PassioStatusDelegate {

    func passioStatusChanged(status: PassioStatus) {
        if status.mode == .isReadyForDetection {
            DispatchQueue.main.async {
                self.startDetection()
            }
        }
    }

    func passioProcessing(filesLeft: Int) {
        DispatchQueue.main.async {
            self.labelBackgroundView.isHidden = false
            self.activityIndicator.startAnimating()
            self.labelDetected.text = "Files left to Process \(filesLeft)"
        }
    }

    func completedDownloadingAllFiles(filesLocalURLs: [FileLocalURL]) {
        DispatchQueue.main.async {
            self.labelBackgroundView.isHidden = false
            self.activityIndicator.startAnimating()
            self.labelDetected.text = "Completed downloading all files"
        }
    }

    func completedDownloadingFile(fileLocalURL: FileLocalURL, filesLeft: Int) {
        DispatchQueue.main.async {
            self.labelBackgroundView.isHidden = false
            self.activityIndicator.startAnimating()
            self.labelDetected.text = "Files left to download \(filesLeft)"
        }
    }

    func downloadingError(message: String) {
        print("downloadError   ---- =\(message)")
        DispatchQueue.main.async {
            self.labelBackgroundView.isHidden = false
            self.labelDetected.text = "\(message)"
            self.activityIndicator.stopAnimating()
        }
    }

}
