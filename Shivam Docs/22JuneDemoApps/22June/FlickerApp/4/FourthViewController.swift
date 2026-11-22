//
//  FourthViewController.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import UIKit

class FourthViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ThirdDelegate {
    func getCallBack(_ photos: [ThirdPhotos]) {
        DispatchQueue.main.async { [weak self] in
            self?.photo = photos
            self?.collectionView.reloadData()
        }
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    var photo = [ThirdPhotos]()
    var viewModel = ThirdVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let nib = UINib(nibName: "FourthCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "FourthCollectionViewCell")

        viewModel.delegate = self
        do {
           try viewModel.getPhotosResponse("df")
        } catch (let error) {
            print(error)
        }

    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthCollectionViewCell", for: indexPath) as! FourthCollectionViewCell
        cell.confogureCell(photo[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {

            let itemsPerRow: CGFloat = 3
            let spacing: CGFloat = 10
            let totalSpacing = (itemsPerRow - 1) * spacing
            let availableWidth = collectionView.bounds.width - totalSpacing
            let itemWidth = floor(availableWidth / itemsPerRow)

            return CGSize(width: itemWidth, height: itemWidth)
        }

}
