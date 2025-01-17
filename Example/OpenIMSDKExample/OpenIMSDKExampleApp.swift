//
//  OpenIMSDKExampleApp.swift
//  OpenIMSDKExample
//
//  Created by x on 11/25/24.
//

import SwiftUI
import OpenIMSDKCoreSwift
@main
struct OpenIMSDKExampleApp: App {
    init() {
        let handleID = OpenIMSDKCoreSwift.ffiInit(protocolType: .json) { data in
            
        }
        
        let req = Data()
        OpenIMSDKCoreSwift.ffiRequest(req)
        
        OpenIMSDKCoreSwift.dropHandle(handleID: handleID)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
