import Foundation

struct MovieWeb: Decodable {
    let id: Int
    let title: String
    let genreIds: [Int]
    let overview: String
    let image: Image
    let popularity: Float

    init(from decoder: Decoder) throws {
        do {
            let map = try decoder.container(keyedBy: CodingKeys.self)
            id = try map.decode(Int.self, forKey: .id)
            title = try map.decode(String.self, forKey: .title)
            genreIds = try map.decode([Int].self, forKey: .genre_ids)
            overview = try map.decode(String.self, forKey: .overview)
            // we are interested for vote_average property from the api (Probably this property should be renamed).
            popularity = try map.decode(Float.self, forKey: .vote_average)

            let posterPath = try map.decode(String.self, forKey: .poster_path)
            // image paths consists from base_url, file_size and a file_path, but it is hardcoded for purpose of this
            // assignment. See https://developers.themoviedb.org/4/getting-started/images
            image = Image(
                small: "https://image.tmdb.org/t/p/w185" + posterPath,
                large: "https://image.tmdb.org/t/p/w500" + posterPath)
        } catch {
            throw error
        }
    }

    private enum CodingKeys: CodingKey {
        case id
        case title
        case genre_ids
        case overview
        case vote_average
        case poster_path
    }
}

extension MovieWeb {
    func mapToMovie(genres: [Genre]) -> Movie {
        let genres: String = genreIds.reduce(into: "") { (partialResult: inout String, i: Int) in
            let genre = genres.first { $0.id == i }

            guard let genre = genre else {
                return
            }

            if !partialResult.isEmpty {
                partialResult += ", "
            }

            partialResult += genre.name
        }

        return Movie(
            id: id,
            title: title,
            genres: genres,
            overview: overview,
            image: image,
            popularity: popularity)
    }
}