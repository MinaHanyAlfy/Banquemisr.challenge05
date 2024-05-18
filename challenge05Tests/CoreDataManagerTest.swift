//
//  challenge05Tests.swift
//  challenge05Tests
//
//  Created by Mina Hanna on 2024-05-14.
//

import XCTest
@testable import challenge05

final class CoreDataManagerTest: XCTestCase {
    let coredata = CoreDataManager.shared
    var movies = [Movie(adult: false, id: 1200, originalTitle: "Marvel", posterPath: "", releaseDate: "", title: "Marvel"), Movie(adult: true, id: 1100, originalTitle: "Injustice", posterPath: "", releaseDate: "", title: "Injustice")]
    
    func testSaveAndFetch() throws {
        coredata.saveMovies(movies: movies, type: .Populer)
        let savedMovies = coredata.fetchMovies(type: .Populer)
        XCTAssertEqual(movies.count, savedMovies.count)
    }
    
    func testMovieIsExist() throws {
        let isExist = coredata.isExist(id: 1200)
        XCTAssertEqual(isExist, true)
    }
    
    func testSaveMovies() throws {
        coredata.saveMovies(movies: [Movie(adult: false, id: 1020, originalTitle: "Dune", posterPath: "", releaseDate: "", title: "Dune")], type: .Upcoming)
        let movies = coredata.fetchMovies(type: .Upcoming)
        XCTAssertEqual(movies.count, 1)
    }
    
    func testFetchMovies() throws {
        let movies = coredata.fetchMovies(type: .Populer)
        XCTAssertEqual(movies.count, 2)
    }
    
    func testClearMovies() async throws {
        coredata.clearMovies()
        let count = coredata.fetchMovies(type: .Populer).count
        XCTAssertEqual(count, 0)
    }
}
