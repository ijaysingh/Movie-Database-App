//
//  MovieViewController.swift
//  MovieRecommendation
//
//  Created by mac1707 on 29/06/24.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movie: MovieDataModel? {
        didSet {
            configureView()
        }
    }
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let plotLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(yearLabel)
        scrollView.addSubview(genreLabel)
        scrollView.addSubview(directorLabel)
        scrollView.addSubview(plotLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            posterImageView.heightAnchor.constraint(equalToConstant: 500),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            yearLabel.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            yearLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            genreLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 8),
            genreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            genreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            directorLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),
            directorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            directorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            plotLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 8),
            plotLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            plotLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            plotLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8)
        ])
    }
    
    private func configureView() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        yearLabel.text = "Year: \(movie.year)"
        genreLabel.text = "Genre: \(movie.genre)"
        directorLabel.text = "Director: \(movie.director)"
        plotLabel.text = "Plot: \(movie.plot)"
        
        if let posterURL = URL(string: movie.poster) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: posterURL) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
