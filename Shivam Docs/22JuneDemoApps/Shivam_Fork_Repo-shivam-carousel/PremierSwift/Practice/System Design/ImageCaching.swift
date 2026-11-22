//
//  SystenDesign.swift
//  PremierSwift
//
//  Created by Shivam Gupta on 06/06/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Custom SDWebImage SDK (Caching & Disk )

class ImageCacheManagers {
    static let shared = ImageCacheManagers()

    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskCachePath: String

    private init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        diskCachePath = paths[0].appendingPathComponent("CustomImageCache").path

        if !fileManager.fileExists(atPath: diskCachePath) {
            try? fileManager.createDirectory(atPath: diskCachePath, withIntermediateDirectories: true)
        }
    }

    func getImage(forKey key: String) -> UIImage? {
        // Check memory cache
        if let image = cache.object(forKey: key as NSString) {
            return image
        }

        // Check disk cache
        let filePath = (diskCachePath as NSString).appendingPathComponent(key)
        if let image = UIImage(contentsOfFile: filePath) {
            cache.setObject(image, forKey: key as NSString)
            return image
        }

        return nil
    }

    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)

        // Save to disk
        let filePath = (diskCachePath as NSString).appendingPathComponent(key)
        if let data = image.pngData() {
            try? data.write(to: URL(fileURLWithPath: filePath))
        }
    }
}


//2. UIImageView+CustomLoader:

extension UIImageView {
    func setImage(with url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder

        // Check cache first
        if let cachedImage = ImageCacheManagers.shared.getImage(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }


        // Download in background
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }

            // Save to cache
            ImageCacheManagers.shared.saveImage(image, forKey: url.absoluteString)

            // Set on main thread
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()

        Task {

            let (data, error) = try await URLSession.shared.data(for: URLRequest(url: url))

            let image = UIImage(data: data)

            ImageCacheManagers.shared.saveImage(image!, forKey: url.absoluteString)

            updateImage(image)
        }
        @MainActor
        func updateImage(_ image: UIImage?) {
            self.image = image
        }


    }


}


//📱 3. Use in Your Cell
//cell.imageView.setImage(with: URL(string: "https://picsum.photos/200/300")!, placeholder: UIImage(named: "placeholder"))




//MARK: -  LRU Cache Implementation

class LRUCache {

    private var capacity: Int
    private var cache: [Int: DLinkedNode] = [:]
    private var size = 0
    private var head: DLinkedNode
    private var tail: DLinkedNode

    init(_ capacity: Int) {
        self.capacity = capacity
        self.head = DLinkedNode(key: 0, value: 0) // Dummy head
        self.tail = DLinkedNode(key: 0, value: 0) // Dummy tail
        head.next = tail
        tail.prev = head
    }

    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            moveToHead(node)
            return node.value
        } else {
            return -1
        }
    }

    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node)
        } else {
            let newNode = DLinkedNode(key: key, value: value)
            cache[key] = newNode
            addNode(newNode)
            size += 1

            if size > capacity {
                if let tailNode = removeTail() {
                    cache.removeValue(forKey: tailNode.key)
                    size -= 1
                }
            }
        }
    }

    // MARK: - Helper Methods

    private func addNode(_ node: DLinkedNode) {
        node.prev = head
        node.next = head.next

        head.next?.prev = node
        head.next = node
    }

    private func removeNode(_ node: DLinkedNode) {
        let prevNode = node.prev
        let nextNode = node.next

        prevNode?.next = nextNode
        nextNode?.prev = prevNode
    }

    private func moveToHead(_ node: DLinkedNode) {
        removeNode(node)
        addNode(node)
    }

    private func removeTail() -> DLinkedNode? {
        guard let tailNode = tail.prev, tailNode !== head else {
            return nil
        }
        removeNode(tailNode)
        return tailNode
    }
}


class DLinkedNode {
    var key: Int
    var value: Int
    var prev: DLinkedNode?
    var next: DLinkedNode?

    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */



// MARK: - IF there are thousands of images in Home Screen, Design How you will perform Caching effeciently andavoid race conditions

//1. ImageCache
final class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()

    private init() {
        ImageCache.shared.totalCostLimit = 50 * 1024 * 1024 // 50MB
    }
}

//2. ImageLoader (Actor-based): If not inside actor → ❌ race condition on runningTasks
actor ImageLoader {
    static let shared = ImageLoader()

    private var runningTasks: [URL: Task<UIImage?, Never>] = [:]

    func loadImage(from url: URL) async -> UIImage? {
        // ✅ Memory Cache
        if let cached = ImageCache.shared.object(forKey: url as NSURL) {
            return cached
        }

        // ✅ Deduplication
        if let existingTask = runningTasks[url] {
            return await existingTask.value
        }

        let task = Task<UIImage?, Never> {
            defer { runningTasks[url] = nil }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else { return nil }

                ImageCache.shared.setObject(image, forKey: url as NSURL)
                return image
            } catch {
                return nil
            }
        }

        runningTasks[url] = task
        return await task.value
    }

    func cancel(for url: URL) {
        runningTasks[url]?.cancel()
        runningTasks[url] = nil
    }
}

//3. ViewModel
final class FeedViewModel {
    let imageURLs: [URL]

    init(urls: [URL]) {
        self.imageURLs = urls
    }

    func url(at indexPath: IndexPath) -> URL {
        return imageURLs[indexPath.item]
    }
}


//4. UICollectionViewCell
class ImageCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private var currentURL: URL?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil

        if let url = currentURL {
            Task {
                await ImageLoader.shared.cancel(for: url)
            }
        }
    }

    func configure(with url: URL) {
        currentURL = url

        Task {
            let image = await ImageLoader.shared.loadImage(from: url)

            // ✅ Prevent race condition
            if self.currentURL == url {
                self.imageView.image = image
            }
        }
    }
}

///5. ViewController/
class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private var collectionView: UICollectionView!
    private let viewModel: FeedViewModel

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageURLs.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell

        let url = viewModel.url(at: indexPath)
        cell.configure(with: url)

        return cell
    }
}
