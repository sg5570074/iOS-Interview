//////
//////  MultipleImageDownloaderLLD.swift
//////  PremierSwift
//////
//////  Created by Shivam Gupta on 31/01/25.
//////  Copyright © 2025 Deliveroo. All rights reserved.
//////
//
import Foundation
import UIKit
////
////
final class ImageCacheManager {
    static let shared = ImageCacheManager()

    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskCacheURL: String

    private init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        diskCacheURL = paths[0].appendingPathComponent("ImageCache").path
        try? fileManager.createDirectory(atPath: diskCacheURL, withIntermediateDirectories: true, attributes: nil)
    }

    func getImage(forKey key: String) -> UIImage? {
        if let image = memoryCache.object(forKey: key as NSString) {
            return image
        }
        let fileURL = (diskCacheURL as NSString).appendingPathComponent(key)
        if let image = UIImage(contentsOfFile: fileURL) {
            memoryCache.setObject(image, forKey: key as NSString)
            return image
        }
        return nil
    }

    func saveImage(_ image: UIImage, forKey key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        let fileURL = (diskCacheURL as NSString).appendingPathComponent(key)
        if let imageData = image.pngData() {
            try? imageData.write(to: URL(fileURLWithPath: fileURL))
        }
    }
}



protocol ImageDownloadDelegate: AnyObject {
    func didUpdateProgress(for url: URL, progress: Float)
}

final class ImageDownloader: NSObject, URLSessionDataDelegate {
    static let shared = ImageDownloader()

    private var urlSession: URLSession!
    private var tasks: [URL: (progress: ((Float) -> Void)?, completion: (UIImage?) -> Void)] = [:]
    private var receivedData: [URL: Data] = [:]
    private var totalSize: [URL: Int64] = [:]

    weak var delegate: ImageDownloadDelegate?

    private override init() {
        super.init()
        let config = URLSessionConfiguration.default
        self.urlSession = URLSession(configuration: config, delegate: self, delegateQueue: .main)
    }

    func downloadImage(from url: URL, progress: ((Float) -> Void)? = nil, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: url.absoluteString) {
            completion(cachedImage)
            return
        }

        let task = urlSession.dataTask(with: url)
        tasks[url] = (progress, completion)
        receivedData[url] = Data()
        task.resume()
    
    }

    func cancelDownload(for url: URL) {
        tasks[url] = nil
        receivedData[url] = nil
    }

    // MARK: - URLSessionDataDelegate
    //Called when the server responds and the client must decide how to proceed.
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        totalSize[dataTask.originalRequest!.url!] = response.expectedContentLength
        completionHandler(.allow)
    }

   // Called when new data is available.
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let url = dataTask.originalRequest?.url else { return }
        receivedData[url]?.append(data)

        if let total = totalSize[url] {
            let progress = Float(receivedData[url]!.count) / Float(total)
            tasks[url]?.progress?(progress)
            delegate?.didUpdateProgress(for: url, progress: progress)
        }
    }


    // Called when the task completes—either successfully or with an error.
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let url = task.originalRequest?.url else { return }

        if let imageData = receivedData[url], let image = UIImage(data: imageData) {
            ImageCacheManager.shared.saveImage(image, forKey: url.lastPathComponent)
            tasks[url]?.completion(image)
        } else {
            tasks[url]?.completion(nil)
        }

        // Cleanup
        tasks.removeValue(forKey: url)
        receivedData.removeValue(forKey: url)
        totalSize.removeValue(forKey: url)
    }
}

private var progressBarKey: UInt8 = 0
//
extension UIImageView: ImageDownloadDelegate {

    private var progressBar: UIProgressView? {
        get { return objc_getAssociatedObject(self, &progressBarKey) as? UIProgressView }
        set { objc_setAssociatedObject(self, &progressBarKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func setImage(from urlString: String, placeholder: UIImage? = nil) {
        self.image = placeholder

        guard let url = URL(string: urlString) else { return }

        // Ensure ImageDownloader knows this imageView will receive progress updates
        ImageDownloader.shared.delegate = self

        // Add progress bar if not already present
        if progressBar == nil {
            let bar = UIProgressView(progressViewStyle: .default)
            bar.translatesAutoresizingMaskIntoConstraints = false
            bar.progressTintColor = .blue
            self.addSubview(bar)
            NSLayoutConstraint.activate([
                bar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                bar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                bar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
                bar.heightAnchor.constraint(equalToConstant: 2)
            ])
            self.progressBar = bar
        }

        progressBar?.progress = 0
        progressBar?.isHidden = false

        ImageDownloader.shared.downloadImage(from: url, progress: { [weak self] progress in
            DispatchQueue.main.async {
                self?.progressBar?.progress = progress
            }
        }, completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
                self?.progressBar?.isHidden = true
            }
        })
    }

    // Delegate method to update progress
    func didUpdateProgress(for url: URL, progress: Float) {
        DispatchQueue.main.async {
            self.progressBar?.progress = progress
        }
    }
}

