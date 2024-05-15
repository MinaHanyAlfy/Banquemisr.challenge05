//
//  CoreDataManager.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import UIKit
import CoreData

enum MovieType: String {
    case Populer    = "populer"
    case Upcoming   = "coming"
    case NowPlaying = "playing"
}

class CoreDataManager {
    static let shared = CoreDataManager()
    
    func appDelegate() -> AppDelegate? {
        if Thread.isMainThread {
            return UIApplication.shared.delegate as? AppDelegate
        } else {
            var appDelegate: AppDelegate?
            DispatchQueue.main.sync {
                appDelegate = UIApplication.shared.delegate as? AppDelegate
            }
            return appDelegate
        }
    }
    
    func context() ->  NSManagedObjectContext? {
        let context = appDelegate()?.persistentContainer.viewContext
        return context
    }
    
    func save() {
        appDelegate()?.saveContext()
    }
    
    
}

//MARK: Movie Handler
extension CoreDataManager {
    /////////// Manage All Movies
    func fetchMovies(type: MovieType) -> [Movie] {
        let context = context()
        let fetchRequest: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        guard let objects = try?  context?.fetch(fetchRequest) else { return [] }
        var movies: [Movie] = []
        for objc in objects {
            if objc.type == type.rawValue {
                let movie = Movie(adult: objc.adult , id: Int(objc.id), originalTitle: objc.originalTitle , posterPath: objc.posterPath, releaseDate: objc.releaseDate , title: objc.title)
                
                movies.append(movie)
            }
        }
        return movies
    }
    
    func saveMovies(movies: [Movie], type: MovieType) {
        for movie in movies {
            if !isExist(id: movie.id ?? 0) {
                let mov = MovieCD(context: context() ?? NSManagedObjectContext())
                mov.id = Int64(movie.id ?? 0)
                mov.title = movie.title ?? ""
                mov.originalTitle = movie.originalTitle ?? ""
                mov.releaseDate = movie.releaseDate ?? ""
                mov.posterPath = movie.posterPath ?? ""
                mov.adult = movie.adult ?? false
                mov.type = type.rawValue
                do {
                    try context()?.save()
                    print("✅ Success")
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    func clearMovies() {
        let fetchRequestProduct: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        let objects = try! context()?.fetch(fetchRequestProduct)
        
        for obj in objects ?? [] {
            context()?.delete(obj)
        }
        
        do {
            try context()?.save()
        } catch {
            print("❌ Error Delete Object")
        }
    }

    ///////Finding Movie Duplicate
    func isExist(id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %@" ,"\(id)")

        do {
            let count = try context()?.count(for: fetchRequest) ?? 0
            if count > 0 {
                return true
            } else {
                return false
            }
        }catch let error as NSError {
            print("❌ Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    //TODO: Make a func to check for each movie type - Upcoming, Populer And Now Playing
    
}
