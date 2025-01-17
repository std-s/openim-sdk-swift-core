import XCTest
@testable import OpenIMSDKCoreSwift

final class OpenIMSDKTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
        
        let handleID = OpenIMSDKCoreSwift.ffiInit(protocolType: .json) { data in
            let jsonStr = String(data: data, encoding: .utf8)
            
            print(jsonStr)
        }
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print("Documents paht: \(documents)")
        
        let config = [
            "logLevel": 6,
            "apiAddr": "http://192.168.0.63:10002",
            "dataDir": documents,
            "logFilePath": documents,
            "dbPath": documents,
            "appFramework": 12,
            "isLogStandardOutput": true,
            "platform": 2,
            "wsAddr": "ws://192.168.0.63:10001"
        ] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: config, options: .fragmentsAllowed)
        let base64String = jsonData.base64EncodedString()
        let requestJSONStr = "{\"handleID\":1,\"funcName\":1,\"data\":\"" + base64String + "\"}"
        
        if let req = requestJSONStr.data(using: .utf8) {
            OpenIMSDKCoreSwift.ffiRequest(req)
        }
        
//        OpenIMSDKCoreSwift.dropHandle(handleID: handleID)
        
        XCTAssertEqual(handleID, 1)
    }
}
