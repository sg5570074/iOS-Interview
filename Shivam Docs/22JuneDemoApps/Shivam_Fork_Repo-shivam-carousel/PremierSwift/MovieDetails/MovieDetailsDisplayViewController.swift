import UIKit

final class MovieDetailsDisplayViewController: UIViewController {
    let movieDetails: MovieDetails
    let similairMovies: [Movie]
    let scrollView = UIScrollView()
    let backdropImageView = UIImageView()
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    private var collectionViewHeightConstraint: NSLayoutConstraint!
    private lazy var contentStackView = UIStackView(arrangedSubviews: [backdropImageView, titleLabel, overviewLabel])
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Movie>!

    init(movieDetails: MovieDetails, similarMovies: [Movie]) {
        self.movieDetails = movieDetails
        self.similairMovies = similarMovies
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(movieDetails: movieDetails)
        commonInit()
    }

    private func commonInit() {
        view.backgroundColor = .white
        configureCollectionView()
        configureDataSource()
        loadData()

        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true

        titleLabel.font = UIFont.Heading.medium
        titleLabel.textColor = UIColor.Text.charcoal
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.setContentHuggingPriority(.required, for: .vertical)

        overviewLabel.font = UIFont.Body.small
        overviewLabel.textColor = UIColor.Text.grey
        overviewLabel.numberOfLines = 0
        overviewLabel.lineBreakMode = .byWordWrapping

        contentStackView.axis = .vertical
        contentStackView.spacing = 24
        contentStackView.setCustomSpacing(8, after: titleLabel)

        setupViewsHierarchy()
        setupConstraints()

    }

    private func setupViewsHierarchy() {
        view.addSubview(scrollView)
        scrollView.dm_addSubviews(contentStackView, collectionView)
    }

    private func setupConstraints() {
        [scrollView, backdropImageView, contentStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false }
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 300) // Temporary height
            collectionViewHeightConstraint.isActive = true

        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 11 / 16, constant: 0),

                // ContentStackView constraints
                contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
                contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),


                // CollectionView constraints
                collectionView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 24),
                collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ]
        )

        scrollView.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        view.preservesSuperviewLayoutMargins = false
    }

    private func updateCollectionViewHeight() {
        collectionView.layoutIfNeeded() // Ensure layout updates
        collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        view.layoutIfNeeded() // Refresh the view
    }

    func configure(movieDetails: MovieDetails) {
        backdropImageView.dm_setImage(backdropPath: movieDetails.backdropPath)

        titleLabel.text = movieDetails.title

        overviewLabel.text = movieDetails.overview
    }
}

extension MovieDetailsDisplayViewController {
    func createCarouselLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return UICollectionViewCompositionalLayout(section: section)
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCarouselLayout())
        collectionView.register(SimilarMovieCell.self, forCellWithReuseIdentifier: SimilarMovieCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Movie>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCell.reuseIdentifier, for: indexPath) as? SimilarMovieCell
                cell?.configure(item)
                return cell
            }
        )
    }

    private func loadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(similairMovies)
        dataSource.apply(snapshot, animatingDifferences: true)
        DispatchQueue.main.async {
            self.updateCollectionViewHeight()
        }
    }
    
}

extension MovieDetailsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

    }
}

extension MovieDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
    }
}

#if DEBUG
extension MovieDetailsDisplayViewController {
    var _collectionView: UICollectionView {
        collectionView
    }

    var _dataSource: UICollectionViewDiffableDataSource<Int, Movie>! {
        dataSource
    }
}
#endif


