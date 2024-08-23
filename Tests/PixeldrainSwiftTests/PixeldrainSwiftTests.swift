import XCTest
@testable import PixeldrainSwift

final class PixeldrainSwiftTests: XCTestCase {
    func testGetFileInfo() async throws {
        let fileId = "uZ2uCvQf"
        let api = PixeldrainAPI(apiKey: "bd617f5c-2661-4521-8d60-6d376edf5c0d")
        let result = try await api.getFileInfo(fileId: fileId)
        XCTAssertEqual(result.name, "Nagranie z ekranu 2024-07-27 o 22.22.20.mov")
    }
    
    func testGetUserInfo() async throws {
        let api = PixeldrainAPI(apiKey: "bd617f5c-2661-4521-8d60-6d376edf5c0d")
        let result = try await api.getUserInfo()
        XCTAssertEqual(result.username, "xxmalik")
        XCTAssertEqual(result.subscription.name, "Free")
    }
}
