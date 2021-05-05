//
//  ViewController.swift
//  MagicPaper
//
//  Created by Angelique Babin on 05/05/2021.
//

import UIKit
import SceneKit
import ARKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet private var sceneView: ARSCNView!
    
    // MARK: - Properties
    
    private let audioSession = AudioSession()
    private let videoSession = VideoSession()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        setImageToTrack(with: configuration)

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - Methods
    
    private func setImageToTrack(with configuration: ARImageTrackingConfiguration) {
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: Constants.assetsGroupName, bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
//            print("Images Successfully Added")
        }
    }
}

// MARK: - ARSCNViewDelegate

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        guard let imageAnchor = anchor as? ARImageAnchor else { return nil }
//        print(imageAnchor.referenceImage.name as Any)
        let videoScene = videoSession.addVideoScn()
        audioSession.playSound()
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = videoScene // UIColor(white: 1.0, alpha: 0.5)
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2
        node.addChildNode(planeNode)
        return node
    }
}
