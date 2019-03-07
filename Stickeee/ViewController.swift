import UIKit
import SpriteKit
import ARKit
import FirebaseDatabase
import Firebase
import SCSDKCreativeKit
import CoreLocation

class ViewController: UIViewController, ARSKViewDelegate, UITextFieldDelegate
{
    static var userInput = ""
    static var loaded = false

    //scene view for AR
    @IBOutlet weak var sceneView: ARSKView!
    
    //text box
    @IBOutlet weak var textBox: UITextField!
    
    
    //after pressing done on text box
    @IBAction func pressedEnd(_ sender: Any)
    {
        textBox.isHidden = true //hides text box
        button.isHidden = false //shows button
        textBox.resignFirstResponder()
        ViewController.userInput = textBox.text!
    }
    
    @IBAction func snappybutton(_ sender: Any)
    {
        let url = URL(string: "https://www.stickplace.net/image/getSnapChatImage")
        let sticker = SCSDKSnapSticker(stickerUrl: url!, isAnimated: false)
        let snap = SCSDKNoSnapContent()
        
        snap.caption = ViewController.userInput
        snap.sticker = sticker
        let api = SCSDKSnapAPI(content: snap)
        api.startSnapping{(error) in}
    }
    
    //button to show textbox
    @IBOutlet weak var button: UIButton!
    
    //action from pressing button
    @IBAction func showButton(_ sender: Any)
    {
        textBox.isHidden = false //shows text box
        button.isHidden = true //hides button
        textBox.becomeFirstResponder()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
        addListenerToDatabase()
    }

    func addListenerToDatabase()
    {
        let ref = Database.database().reference()
        
        ref.observe(.childAdded, with: { (snapshot) -> Void in
            var lat: Double = 0
            var lon: Double = 0
            var string: String?

            for child in snapshot.children.allObjects as? [DataSnapshot] ?? []
            {
                if child.key == "lat"
                {
                    lat = (child.value as? Double)!
                }
                if child.key == "lon"
                {
                    lon = (child.value as? Double)!
                }
                if child.key == "string"
                {
                    string = child.value as? String
                }
            }
            print("\nLat: " + String(lat))
            print("Lon: " + String(lon))
            print("String: " + string! + "\n")
            self.newStickerFromDatabase(lat, lon, string!)
        })
    }
    
    func newStickerFromDatabase(_ newLat: Double, _ newLon: Double, _ label: String)
    {
        if let currentFrame = sceneView.session.currentFrame
        {
            let xy = Sticker.GetXY(lat2: newLat, lon2: newLon)
            
            var translation = matrix_identity_float4x4
            translation.columns.3.z = Float(-xy["y"]! + 0.2)
            translation.columns.3.y = Float(xy["x"]!)
            
            let transform = simd_mul(currentFrame.camera.transform, translation)
            Sticker(transform, sceneView, xy["y"]!, xy["x"]!, label)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        
        let labelNode = SKLabelNode(text: anchor.name)
        labelNode.fontName = "Arial"
        labelNode.fontSize = 60
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode;
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
    
}
