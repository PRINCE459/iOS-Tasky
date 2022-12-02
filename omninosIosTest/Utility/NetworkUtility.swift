//
//  NetworkUtility.swift
//  ParkLinqValidation
//
//  Created by Prince 2.O on 16/11/22.
//

import Foundation
import Network

class NetworkUtility {
    
    static let shared = NetworkUtility()
    
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private let networkMonitor = NWPathMonitor()
    var isConnected: Bool = false
    
    private init(){}
    
    func startMonitoringNetwork()
    {
        networkMonitor.start(queue: queue)
        networkMonitor.pathUpdateHandler = { path in
            
            // Internet is Connected
            if path.status == .satisfied {
                self.isConnected = true
                print("Internet is Connected")
            } else { // Internet is Not Connected
                self.isConnected = false
                print("Internet is Not connected")
            }
        }
    }
    
    func stopNetworkMonitoring()
    {
        networkMonitor.cancel()
    }
    
}
