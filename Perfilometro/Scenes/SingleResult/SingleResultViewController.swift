//
//  SingleResultViewController.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import MapKit
import SceneKit

enum ChartType : Int {
    case cylinder = 0, cube, pie
}

class SingleResultViewController: UIViewController, SCNSceneRendererDelegate {

    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeInMap: MKMapView!
    @IBOutlet weak var graph: SCNView!
    
    //properties
    private var objectScene: SCNScene?
    private var cameraNode: SCNNode?
    private var overlay: CameraControll?
//    private var scnView: SCNView?
    private var object3D: SCNNode?
    private var chartNode:SCNNode!
    var road: Road?
    
    let data = GraphicSettings()
    private var initialBlockPosition: SCNVector3 = SCNVector3(-2.0, 0.0, 0.0)
    private let defaultBlockDimension: CGFloat = 1.0
    private var blockDistances: [Float] = [0.5, 0.7, 0.4, 0.7, 1.0, 0.3, 1.5,1.5,1.5,1.6,1.7, 2.0, 2.0, 2.0, 0.7, 0.8, 0.9, 0.6, 0.6, 0.6, 0.6, 0.5]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routeName.text = road?.name
        setupView()
        setupScene()
        setUpOmniLight()
        setupAmbientLight()
        addCamera(scene: self.objectScene!)
        setupOverlay()
        showData()
        setSensorsValue(road: road!)
        
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    func setSensorsValue(road: Road) {
        if road != nil {
            data.sensor1Values = road.lasers[0]
            data.sensor2Values = road.lasers[1]
            data.sensor3Values = road.lasers[2]
            data.sensor4Values = road.lasers[3]
            data.sensor5Values = road.lasers[4]
            
//            data.sensor6Values = road.lazers[5]
//            data.sensor7Values = road.lazers[6]
//            data.sensor8Values = road.lazers[7]
//            data.sensor9Values = road.lazers[8]
//            data.sensor10Values = road.lazers[9]
        }

    }
    fileprivate func setupView() {
        self.graph?.delegate = self
        graph?.backgroundColor = UIColor.black
        graph?.allowsCameraControl = true
    }

    fileprivate func setupScene() {
        self.objectScene = SCNScene()
        self.graph?.scene = self.objectScene
    }

    fileprivate func setupOverlay() {
        self.overlay = CameraControll(size: (self.graph?.bounds.size)!)
        self.overlay?.moveDelegate = self
        self.graph?.overlaySKScene = self.overlay
    }
    fileprivate func setupAmbientLight() {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .ambient
        lightNode.light?.color = UIColor.darkGray
        self.objectScene?.rootNode.addChildNode(lightNode)
        
    }

    fileprivate func setUpOmniLight() {
        let lightNode = SCNNode()
        lightNode.light?.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(0, 10, 15)
        self.objectScene?.rootNode.addChildNode(lightNode)
    }

    fileprivate func addCamera(scene: SCNScene) {
        self.cameraNode = SCNNode()
        cameraNode!.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode!)
        
        // place the camera
        cameraNode?.position = SCNVector3(x: 0, y: 0, z: 90)
        cameraNode?.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(-Double.pi/9 * 0.25))
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
    }

    private func showData() {
        self.chartNode = SCNNode()
        self.chartNode = createChart(.cylinder)
        self.objectScene?.rootNode.addChildNode(self.chartNode)
        chartNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(-Double.pi / 2.0))
        
    }

    private func createChart(_ type: ChartType) -> SCNNode{
        let gridSize:CGFloat = 2.0
        data.updateValues()
        let numRows = data.numberOfRows()
        let numColumns = data.numberOfColums()
        let height = CGFloat(numRows)*gridSize
        let width = CGFloat(numColumns)*gridSize
        
        let node = SCNNode()
        let base = SCNNode(geometry: SCNPlane(width: width, height: height))
        node.addChildNode(base)
        
        var min:SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
        
        (min, _) = base.boundingBox
        
        //println("bounds is \(min.x), \(min.y), \(min.z), \(max.x), \(max.y), \(max.z)")
        
        for idx in 0 ..< numRows {
            let txt = SCNText(string: data.legendForRow(idx), extrusionDepth: 0.0)
            txt.font = UIFont(name: "MarkerFelt-Thin", size: 1.0)
            let txtNode = SCNNode(geometry: txt)
            let posX = min.x - 10.0
            let posY = min.y + Float(idx) * Float(gridSize)
            txtNode.position = SCNVector3(x: posX, y: posY, z: 0.0)
            node.addChildNode(txtNode)
        }
        
        //        for idx in 0 ..< numColumns {
        //            let txt = SCNText(string: data.legendForColumn(idx), extrusionDepth: 0.0)
        //            txt.font = UIFont(name: "MarkerFelt-Thin", size: 2.0)
        //            let txtNode = SCNNode(geometry: txt)
        //            let posX = min.x + Float(idx+1) * Float(gridSize)
        //            let posY = min.y - 2.0
        //            txtNode.position = SCNVector3(x: posX, y: posY, z: 0.0)
        //            txtNode.rotation = SCNVector4(x: 0, y: 0, z: 1, w: Float(-Double.pi / 2.0))
        //            node.addChildNode(txtNode)
        //        }
        
        for i in 0 ..< numRows {
            for j in 0 ..< numColumns {
                let val = data.valueForIndexPath(row:i, column: j) / 10.0 //3.0
                var aNode = SCNNode()
                if(type == .cylinder) {
                    aNode = SCNNode(geometry: SCNCylinder(radius: 1.0, height: CGFloat(val)))
                } else {
                    aNode = SCNNode(geometry: SCNBox(width: 1.0, height: CGFloat(val), length: 1.0, chamferRadius: 0))
                }
                
                let posX = min.x + Float(j) * Float(gridSize) + Float(gridSize/2)
                let posY = min.y + Float(i) * Float(gridSize) + Float(gridSize/2)
                aNode.position = SCNVector3(x: posX, y:posY , z: val/2)
                aNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(-Double.pi / 2.0))
                aNode.geometry?.firstMaterial?.diffuse.contents = data.colorForIndexPath(row: i, column: j)
                node.addChildNode(aNode)
            }
        }
        
        return node
    }
}

extension SingleResultViewController: MoveCameraDelegate {
    
    func moveCameraForward() {
        let mvAction = SCNAction.move(by: SCNVector3(x: -10.0, y: 0, z: 0), duration: 0.5)
        self.chartNode.runAction(mvAction)
        
    }
    
    func moveCameraBackward() {
        let mvAction = SCNAction.move(by: SCNVector3(x: 10.0, y: 0, z: 0), duration: 0.5)
        self.chartNode.runAction(mvAction)
    }
}
