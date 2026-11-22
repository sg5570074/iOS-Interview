import Foundation

enum MoviesDetailsViewModelState : Equatable {
    case loading(Movie)
    case loaded(MovieDetails, [Movie])
    case error

    var title: String? {
        switch self {
        case .loaded(let movie, _):
            return movie.title
        case .loading(let movie):
            return movie.title
        case .error:
            return nil
        }
    }

    static func == (lhs: MoviesDetailsViewModelState, rhs: MoviesDetailsViewModelState) -> Bool {
        return lhs.title == rhs.title
    }
}

final class MoviesDetailsViewModel {

    private let apiManager: APIManaging
    private let initialMovie: Movie
    private var movieDetails: MovieDetails?
    private var similarMovies: [Movie]?
    let dispatchGroup = DispatchGroup()

    init(movie: Movie, apiManager: APIManaging = APIManager()) {
        self.initialMovie = movie
        self.apiManager = apiManager
        self.state = .loading(movie)
    }

    var updatedState: (() -> Void)?
    var similarMovieUpdatedState: (() -> Void)?

    var state: MoviesDetailsViewModelState {
        didSet {
            updatedState?()
        }
    }

    func fetchData() {
        var fetchError: Bool = false

        dispatchGroup.enter()
        apiManager.execute(MovieDetails.details(for: initialMovie)) { [weak self] result in
            guard let self else { return }
            self.dispatchGroup.leave()
            switch result {
            case .success(let movieDetails):
                self.movieDetails = movieDetails
            case .failure:
                fetchError = true
            }
        }

        dispatchGroup.enter()
        apiManager.execute(Movie.similarMovie(for: initialMovie)) { [weak self] result in
            guard let self else { return }
            self.dispatchGroup.leave()
            switch result {
            case .success(let page):
                self.similarMovies = page.results
            case .failure:
                fetchError = true
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            if fetchError {
                self.state = .error
            } else if let movieDetails = self.movieDetails, let similarMovies = self.similarMovies {
                self.state = .loaded(movieDetails, similarMovies)
            }
        }
    }
}

