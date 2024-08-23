import Foundation

@available(macOS 13.0, *)
public class PixeldrainAPI {
    static let baseURL = URL(string: "https://pixeldrain.com/api")
    let session: URLSession
    let operationQueue: OperationQueue
    public init(apiKey: String, delegate: URLSessionTaskDelegate?=nil) {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = [
            "Authorization": "Basic " + Data((":"+apiKey).utf8).base64EncodedString()
        ]
        self.operationQueue = OperationQueue()
        self.session = URLSession(configuration: sessionConfiguration, delegate: delegate, delegateQueue: self.operationQueue)
    }
    
    public func downloadFile(fileId: String) -> URLSessionDownloadTask {
        let url = PixeldrainAPI.baseURL!.appending(path: "/file/\(fileId)")
        let downloadTask = self.session.downloadTask(with: url)
        downloadTask.resume()
        return downloadTask
    }
    
    public func uploadFile(source: URL, name: String?=nil) -> URLSessionUploadTask {
        let nameToUpload = name ?? source.lastPathComponent
        let url = PixeldrainAPI.baseURL!.appending(path: "/file/\(nameToUpload)")
        var uploadRequest = URLRequest(url: url)
        uploadRequest.httpMethod = "PUT"
        let uploadTask = self.session.uploadTask(with: uploadRequest, fromFile: source)
        uploadTask.resume()
        return uploadTask
    }
    
    func makeDataRequest(body: String?=nil, target: String, method: String="GET") async throws -> Data {
        let url = PixeldrainAPI.baseURL!.appending(path: target)
        var request = URLRequest(url: url)
        request.httpMethod = method
        if body != nil {
            request.httpBody = Data(body!.utf8)
        }
        let (responseData, response) = try await self.session.data(for: request)
        return responseData
    }
    
    public func getFileInfo(fileId: String) async throws  -> PixeldrainFileInfo {
        let data = try await self.makeDataRequest(target: "/file/\(fileId)/info")
        return try PixeldrainFileInfo(data: data)
    }
    
    public func getListInfo(listId: String) async throws -> PixeldrainListInfo {
        let data = try await self.makeDataRequest(target: "/list/\(listId)")
        return try PixeldrainListInfo(data: data)
    }
    
    public func getUserInfo() async throws -> PixeldrainUserInfo {
        let data = try await self.makeDataRequest(target: "/user")
        return try PixeldrainUserInfo(data: data)
    }
    
    public func getUserFiles() async throws -> [PixeldrainFileInfo] {
        let data = try await self.makeDataRequest(target: "/user/files")
        return try PixeldrainFileInfo.array(from: data)
    }
    
    public func getUserLists() async throws -> [PixeldrainListInfo] {
        let data = try await self.makeDataRequest(target: "/user/lists")
        return try PixeldrainListInfo.array(from: data)
    }
}
