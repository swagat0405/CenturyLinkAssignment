//
//  Assets.swift
//  CenturyLinkAssignment
//
//  Created by Swagat Mishra on 4/22/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import Foundation

class Assets: Codable {
    
    var id: String?
    var techId: String?
    var assetTag: String?
    var assetStatus: String?
    var verification: String?
    var assetStatusHistories: [AssetStatusHistory]?
    var releaseReason: String?
    var remarks: String?
    var createdDate: Date?
    var lastModifiedDate: Date?
    var transferredFrom: String?
    var transferredTo: String?
    var phoneNumber: Int?
}

class AssetStatusHistory: Codable {
    var assetStatus: String?
    var createdDate: Date?
}
