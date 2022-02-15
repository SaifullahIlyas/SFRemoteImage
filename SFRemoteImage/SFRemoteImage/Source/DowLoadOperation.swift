//
//  SFRemoteImage.swift
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit

private protocol URLSessionDataDownloader {
    func startDownload(url : String)
}
extension URLSessionDataDownloader {
}

final class DownLoadOperation : Operation,URLSessionDataDownloader {
    let url : String
    var state : OperationState
    var imageForOperation :((UIImage?,Data?)->Void)?
    required init(url : String,state : OperationState) {
        self.url = url
        self.state = state
    }
    
    override func main() {
        guard !isCancelled else {
            updateOperation(withState: .finished)
            return
        }
        updateOperation(withState: .downloading)
        self.startDownload(url: url)
    }
    /**update operation state*/
    private func updateOperation(withState state : OperationState) {
        self.state = state
    }
    fileprivate  func startDownload(url: String) {
        let downloadSession  = URLSession.shared
        guard let url = URL(string: url) else {
            updateOperation(withState: .finished)
            return
        }
        let downloadTask = downloadSession.dataTask(with: url) {[self]  data, _, error in
            guard error == nil else {
                updateOperation(withState: .failed)
                return
            }
            guard let data = data else{
                imageForOperation?(nil,nil)
                return
                
            }
            let image = UIImage(data: data)
            imageForOperation?(image,data)
        }
        downloadTask.resume()
    }
}

