//
//  Reachability.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-15.
//

import Foundation
import Network

public class Reachability {

    static let shared = Reachability()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private var isConnected: Bool = false {
        didSet {
            // Notify on main thread
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .reachabilityChanged, object: nil)
            }
        }
    }
    
    private init() {
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    private func stopMonitoring() {
        monitor.cancel()
    }
    
    public func isConnectedToNetwork() -> Bool {
        return isConnected
    }
}

extension Notification.Name {
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
}
