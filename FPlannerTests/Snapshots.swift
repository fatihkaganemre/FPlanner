//
//  Snapshots.swift
//  FPlannerTests
//
//  Created by Fatih Kagan Emre on 25/06/2024.
//

import SnapshotTesting
import XCTest
import SwiftUI
@testable import FPlanner

class Snapshots: XCTestCase {
    func test_mainView() {
        let view = MainView()
        let hostingController = UIHostingController(rootView: view)
        
        assertSnapshot(of: hostingController, as: .image)
    }
}
