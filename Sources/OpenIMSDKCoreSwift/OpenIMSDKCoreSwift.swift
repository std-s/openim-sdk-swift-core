import Foundation
import OpenIMSDKCore

public enum DataFormat: Int32 {
    case json = 1
    case protocolBuffers = 2
    case thrift = 3
    case flatBuffers = 4
}

public typealias CoreCallBackHandler = (Data) -> Void

fileprivate var callbackStorage: CoreCallBackHandler?
fileprivate typealias PtrCallBackHandler = @convention(c) (UnsafeMutableRawPointer?, Int32) -> Void

public struct OpenIMSDKCoreSwift {
    
    static public func ffiInit(protocolType: DataFormat = .protocolBuffers, callback: @escaping CoreCallBackHandler) -> Int64 {
        callbackStorage = callback

        return ffi_init(onResponse, protocolType.rawValue)
    }
    
    static fileprivate let onResponse: PtrCallBackHandler = { ptr, len in
        assert(ptr != nil)
        assert(len > 0)
        
        let byteBuffer = [UInt8](UnsafeBufferPointer(start: ptr!.assumingMemoryBound(to: UInt8.self), count: Int(len)))
        let data = Data(byteBuffer)
        
        callbackStorage?(data)
    }
    
    static public func ffiRequest(_ data: Data) {
        let count = data.count
            
        let pointer = UnsafeMutableRawPointer.allocate(byteCount: count, alignment: MemoryLayout<UInt8>.alignment)
        data.copyBytes(to: pointer.assumingMemoryBound(to: UInt8.self), count: count)

        ffi_request(pointer, Int32(count))
    }
    
    static public func dropHandle(handleID: Int64) {
        ffi_drop_handle(handleID)
    }
}

