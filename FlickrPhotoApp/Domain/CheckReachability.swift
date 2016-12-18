//
//  CheckReachability.swift
//  FlickrPhotoApp
//
//  Created by NishiokaKohei on 2016/12/17.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import SystemConfiguration
import Foundation

class CheckReachability: AnyObject {

    // MARK: - デバイスがオンラインかどうかを判定する。
    // ネットワークへの接続が確立できない場合にはfalseを返す。
    internal func checkReachability(hostName: String) -> Bool {

        let reachability = SCNetworkReachabilityCreateWithName(nil, hostName)!
        var flags = SCNetworkReachabilityFlags.ConnectionAutomatic

        //Determines if the given target is reachable using the current network configuration.
        guard SCNetworkReachabilityGetFlags(reachability, &flags) else {
            return false
        }

        return isReachable(flags) && !needsConnection(flags)
    }

    private func isReachable(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.rawValue & UInt32(kSCNetworkFlagsReachable) != 0
    }

    private func needsConnection(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired) != 0
    }

}
