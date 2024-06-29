//
//  MovieListByOptionVC.swift
//  MovieRecommendation
//
//  Created by mac1707 on 29/06/24.
//

import UIKit

class MovieListByOptionVC: UIViewController {
    
    private var movieData: [MovieDataModel] = [] {
        didSet{
            movieTableview.reloadData()
        }
    }
    
    fileprivate lazy var movieTableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.rowHeight = UITableView.automaticDimension
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .white
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.register(MovieDetailTC.self, forCellReuseIdentifier: "movieDetailTC")
        return tableview
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie Recommendation"
        view.backgroundColor = .white
        view.addSubview(movieTableview)
        
        setupMovieTableView()
    }
    
    private func setupMovieTableView(){
        movieTableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        movieTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        movieTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        movieTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    func populate(with data: [MovieDataModel]){
        movieData = data
    }
    
    

}
extension MovieListByOptionVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieDetailTC", for: indexPath) as! MovieDetailTC
        cell.populate(movie: movieData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieViewController()
        vc.movie = movieData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
