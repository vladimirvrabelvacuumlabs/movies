import Combine
import Foundation

struct MemoryStore {
    var popularMovies: CurrentValueSubject<[Movie], Error> = CurrentValueSubject<[Movie], Error>([])
    var genres: CurrentValueSubject<[Genre], Error> = CurrentValueSubject<[Genre], Error>([])
}