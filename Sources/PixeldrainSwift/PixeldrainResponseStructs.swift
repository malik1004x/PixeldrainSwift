//
//  PixeldrainResponseStructs.swift
//
//
//  Created by Robert Malikowski on 29/07/2024.
//

import Foundation

struct PixeldrainFileListResponse: Decodable {
    public let files: [PixeldrainFileInfo]
}

public struct PixeldrainFileInfo: Decodable {
    public let id: String
    public let name: String
    public let size: UInt
    public let views: UInt
    public let bandwidthUsed: UInt
    public let bandwidthUsedPaid: UInt
    public let downloads: UInt
    public let dateUpload: Date
    public let dateLastView: Date
    public let mimeType: String
    public let thumbnailHref: String
    public let SHA256Hash: String
    public let canEdit: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case size
        case views
        case bandwidthUsed = "bandwidth_used"
        case bandwidthUsedPaid = "bandwidth_used_paid"
        case downloads
        case dateUpload = "date_upload"
        case dateLastView = "date_last_view"
        case mimeType = "mime_type"
        case thumbnailHref = "thumbnail_href"
        case SHA256Hash = "hash_sha256"
        case canEdit = "can_edit"
    }
    
    init(data: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
        self = try decoder.decode(PixeldrainFileInfo.self, from: data)
    }
    
    static func array(from data: Data) throws -> [PixeldrainFileInfo] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
        let response = try decoder.decode(PixeldrainFileListResponse.self, from: data)
        return response.files
    }
}

public struct PixeldrainSubscriptionInfo: Decodable {
    public let id: String
    public let name: String
    public let fileSizeLimit: UInt
    public let fileExpiryDays: Int
    public let storageSpace: Int
    public let pricePerTbStorage: UInt
    public let pricePerTbBandwidth: UInt
    public let monthlyTransferCap: Int
    public let fileViewerBranding: Bool
    public let filesystemAccess: Bool
    public let filesystemStorageLimit: UInt
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fileSizeLimit = "file_size_limit"
        case fileExpiryDays = "file_expiry_days"
        case storageSpace = "storage_space"
        case pricePerTbStorage = "price_per_tb_storage"
        case pricePerTbBandwidth = "price_per_tb_bandwidth"
        case monthlyTransferCap = "monthly_transfer_cap"
        case fileViewerBranding = "file_viewer_branding"
        case filesystemAccess = "filesystem_access"
        case filesystemStorageLimit = "filesystem_storage_limit"
    }
    
    init(data: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
        self = try decoder.decode(PixeldrainSubscriptionInfo.self, from: data)
    }
}

public struct PixeldrainUserInfo: Decodable {
    public let username: String
    public let email: String
    public let subscription: PixeldrainSubscriptionInfo
    public let storageSpaceUsed: UInt
    public let filesystemStorageUsed: UInt
    public let isAdmin: Bool
    public let balanceMicroEur: UInt
    public let hotlinkingEnabled: Bool
    public let monthlyTransferCap: UInt
    public let monthlyTransferUsed: UInt
    public let skipFileViewer: Bool
    
    enum CodingKeys: String, CodingKey {
        case username
        case email
        case subscription
        case storageSpaceUsed = "storage_space_used"
        case filesystemStorageUsed = "filesystem_storage_used"
        case isAdmin = "is_admin"
        case balanceMicroEur = "balance_micro_eur"
        case hotlinkingEnabled = "hotlinking_enabled"
        case monthlyTransferCap = "monthly_transfer_cap"
        case monthlyTransferUsed = "monthly_transfer_used"
        case skipFileViewer = "skip_file_viewer"
    }
    
    init(data: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
        self = try decoder.decode(PixeldrainUserInfo.self, from: data)
    }
}

public struct PixeldrainUserListsResponse: Decodable {
    public let lists: [PixeldrainListInfo]
}

public struct PixeldrainListInfo: Decodable {
    public let id: String
    public let title: String
    public let dateCreated: Date
    public let fileCount: Int
    public let files: [PixeldrainFileInfo]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case dateCreated = "date_created"
        case fileCount = "file_count"
        case files
    }
    
    init(data: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
        self = try decoder.decode(PixeldrainListInfo.self, from: data)
    }
    
    static func array(from data: Data) throws -> [PixeldrainListInfo] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
        let response = try decoder.decode(PixeldrainUserListsResponse.self, from: data)
        return response.lists
    }
}
