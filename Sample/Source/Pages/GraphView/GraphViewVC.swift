//
//  GraphViewVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 13/05/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import CoreMotion
import Sejima

class GraphViewVC: UIViewController {
    @IBOutlet weak var accGraphView: MUGraphView!
    @IBOutlet weak var gyroGraphView: MUGraphView!
    @IBOutlet weak var magnetoGraphView: MUGraphView!

    private let motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gyroGraphView.xColor = .yellow
        gyroGraphView.yColor = .purple
        gyroGraphView.zColor = .orange

        //
        magnetoGraphView.xRange = -2.0...2.0
        magnetoGraphView.yRange = -2.0...2.0
        magnetoGraphView.zRange = -2.0...2.0

        //
        startUpdates()
    }

    deinit {
        stopUpdates()
    }

    func startUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }

//        showGraph(selectedDeviceMotion)
//        updateIntervalLabel.text = formattedUpdateInterval

        motionManager.deviceMotionUpdateInterval = 0.01 // 0.0 to 1.0
        motionManager.showsDeviceMovementDisplay = true

        motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical,
                                               to: .main) { [weak self] deviceMotion, error in
            guard let deviceMotion = deviceMotion else { return }

            self?.accGraphView.add(x: deviceMotion.userAcceleration.x,
                                   y: deviceMotion.userAcceleration.y,
                                   z: deviceMotion.userAcceleration.z)
            self?.gyroGraphView.add(x: deviceMotion.rotationRate.x,
                                    y: deviceMotion.rotationRate.y,
                                    z: deviceMotion.rotationRate.z)
            self?.magnetoGraphView.add(x: deviceMotion.gravity.x, y: deviceMotion.gravity.y, z: deviceMotion.gravity.z)
        }
    }

    func stopUpdates() {
        guard motionManager.isDeviceMotionActive else { return }

        motionManager.stopDeviceMotionUpdates()
    }
}
