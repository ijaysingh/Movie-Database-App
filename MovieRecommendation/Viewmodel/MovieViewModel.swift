//
//  MovieViewModel.swift
//  MovieRecommendation
//
//  Created by mac1707 on 29/06/24.
//

import Foundation

class MovieViewModel{
    
    var movieData = [MovieDataModel]()
    lazy var movieYears = [String]() //0
    lazy var movieGenres = [String]() //1
    lazy var movieDirectors = [String]() //2
    lazy var movieActors = [String]() //3
    lazy var allMovies = [String]() //4
    lazy var movieOptions = [movieYears,
                        movieGenres,
                        movieDirectors,
                        movieActors]
    let optionNames = ["Year", "Genre", "Directors", "Actors"]
    
    init(){
        if let url = Bundle.main.url(forResource: "movies", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                movieData = try JSONDecoder().decode([MovieDataModel].self, from: data)
                getMovieOptions()
                print("[DEBUG] this is json data: \(movieData)")
            }catch{
                print("[DEBUG] eerror parsing json")
            }
        }else{
            print("[DEBUG] file not found")
        }
    }
    
    private func getMovieOptions(){
        movieYears = getYearData()
        
        let allGenres = movieData.flatMap{$0.genre.components(separatedBy: ", ")}
        movieGenres = Array(Set(allGenres))
        
        let allDirectors = movieData.flatMap{$0.director.components(separatedBy: ", ")}
        movieDirectors = Array(Set(allDirectors))
        
        let allActors = movieData.flatMap{$0.actors.components(separatedBy: ", ")}
        movieActors = Array(Set(allActors))
        
        allMovies = Array(Set(movieData.map{$0.year}))
    }
    
    private func getYearData() -> [String] {
        var allYears = [String]()
        movieData.forEach{  movie in
            let year = movie.year.components(separatedBy: "–")
            allYears.append(year.first ?? "")
            if year.last != "–"{
                allYears.append(year.last ?? "")
            }
        }
        
        return Array(Set(allYears.filter{$0 != ""}).sorted())
    }
    
    func sectionsCount() -> Int {movieOptions.count + 1}
    func numOfRows(for section: Int) -> Int {section == 4 ? movieData.count : movieOptions[section].count}
    func sectionHeading(for section: Int) -> String {section == 4 ? "All Movies" : optionNames[section]}
    func rowData(for row: Int, in section: Int) -> Any {section == 4 ? movieData[row]: movieOptions[section][row]}
    func getMovieData(for section: Int, query: String) -> [MovieDataModel] {
        return movieData.filter{
            $0.year.contains(query) ||
            $0.genre.contains(query) ||
            $0.director.contains(query) ||
            $0.actors.contains(query)
        }
    }
}
