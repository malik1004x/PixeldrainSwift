//
//  PixeldrainResponseStructsTests.swift
//
//
//  Created by Robert Malikowski on 29/07/2024.
//

import XCTest
@testable import PixeldrainSwift

final class PixeldrainResponseStructsTests: XCTestCase {
    func testFileInfoStruct() {
        let input = """
                    {"success":true,"id":"1234abcd","name":"file.exe","size":27345252,"views":23423,"bandwidth_used":13123213,"bandwidth_used_paid":445345,"downloads":1000,"date_upload":"2024-07-27T13:49:13.988Z","date_last_view":"2024-07-29T11:06:18.167Z","mime_type":"application/octet-stream","thumbnail_href":"/file/1234abcd/thumbnail","hash_sha256":"74ba705905fd623e2db51ce8c9a321f887e7eb4bcaae1dcfdd891d1dbabb2040","delete_after_date":"0001-01-01T00:00:00Z","delete_after_downloads":0,"availability":"","availability_message":"","abuse_type":"","abuse_reporter_name":"","can_edit":false,"can_download":true,"show_ads":true,"allow_video_player":true,"download_speed_limit":0}
                    """
        do {
            let fileInfo = try PixeldrainFileInfo(data: Data(input.utf8))
            XCTAssertEqual(fileInfo.id, "1234abcd")
            XCTAssertEqual(fileInfo.name, "file.exe")
            XCTAssertEqual(fileInfo.size, 27345252)
            XCTAssertEqual(fileInfo.views, 23423)
            XCTAssertEqual(fileInfo.bandwidthUsed, 13123213)
            XCTAssertEqual(fileInfo.bandwidthUsedPaid, 445345)
            XCTAssertEqual(fileInfo.downloads, 1000)
            XCTAssertEqual(fileInfo.dateUpload.ISO8601Format(), "2024-07-27T13:49:13Z")
            XCTAssertEqual(fileInfo.dateLastView.ISO8601Format(), "2024-07-29T11:06:18Z")
            XCTAssertEqual(fileInfo.mimeType, "application/octet-stream")
            XCTAssertEqual(fileInfo.SHA256Hash, "74ba705905fd623e2db51ce8c9a321f887e7eb4bcaae1dcfdd891d1dbabb2040")
            XCTAssertEqual(fileInfo.canEdit, false)
        } catch {
            XCTFail("Error while creating struct: " + String(describing: error))
        }
    }
}
