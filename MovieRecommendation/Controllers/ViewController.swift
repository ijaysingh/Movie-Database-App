import UIKit

class ViewController: UIViewController {
    
    private var viewmodel: MovieViewModel!
    private var sectionStates: [Bool] = []
    private var filteredMovies: [MovieDataModel] = []
    
    fileprivate lazy var movieOptionTV: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.rowHeight = UITableView.automaticDimension
        tableview.sectionHeaderHeight = 50
        tableview.delegate = self
        tableview.dataSource = self
        tableview.sectionHeaderTopPadding = 0
        tableview.sectionFooterHeight = 0
        tableview.backgroundColor = .white
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.register(LabelTC.self, forCellReuseIdentifier: "labelTC")
        tableview.register(MovieDetailTC.self, forCellReuseIdentifier: "movieDetailTC")
        return tableview
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search by title, genre, actor, or director"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    init() {
        viewmodel = .init()
        sectionStates = Array(repeating: false, count: 5)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewmodel = .init()
        sectionStates = Array(repeating: false, count: 5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movie Recommendation"
        
        view.addSubview(searchBar)
        view.addSubview(movieOptionTV)
        
        setupSearchBar()
        setupMoviOptionTableView()
    }
    
    private func setupSearchBar() {
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setupMoviOptionTableView(){
        movieOptionTV.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8).isActive = true
        movieOptionTV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        movieOptionTV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        movieOptionTV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    private func toggleSection(_ section: Int) {
        if sectionStates[section] {
            sectionStates = Array(repeating: false, count: sectionStates.count)
        } else {
            sectionStates = Array(repeating: false, count: sectionStates.count)
            sectionStates[section] = true
        }
        movieOptionTV.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        filteredMovies.isEmpty ? viewmodel.sectionsCount() : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredMovies.isEmpty ? (sectionStates[section] ? viewmodel.numOfRows(for: section) : 0) : filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filteredMovies.isEmpty{
            switch indexPath.section {
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "movieDetailTC", for: indexPath) as! MovieDetailTC
                if let movieData = viewmodel.rowData(for: indexPath.row, in: indexPath.section) as? MovieDataModel{
                    cell.populate(movie: movieData)
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "labelTC", for: indexPath) as! LabelTC
                cell.rowLabel.text = viewmodel.rowData(for: indexPath.row, in: indexPath.section) as? String
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieDetailTC", for: indexPath) as! MovieDetailTC
            cell.populate(movie: filteredMovies[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if filteredMovies.isEmpty {
            let headerview = MovieOptionHeaderView()
            headerview.buttonLabel.text = viewmodel.sectionHeading(for: section)
            headerview.buttonIcon.image = sectionStates[section] ? UIImage(named: "up.icon") : UIImage(named: "down.icon")
            headerview.tag = section
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
            headerview.addGestureRecognizer(tapGesture)
            return headerview
        }else{
            let label = UILabel()
            label.text = "\(filteredMovies.count) results"
            label.font = UIFont.systemFont(ofSize: 14.0)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
        
    }
    
    @objc private func headerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let section = gestureRecognizer.view?.tag else { return }
        toggleSection(section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredMovies.isEmpty{
            switch indexPath.section {
            case 4:
                let vc = MovieViewController()
                let movieData = sectionStates[indexPath.section] ? viewmodel.movieData[indexPath.row] : filteredMovies[indexPath.row]
                vc.movie = movieData
                navigationController?.pushViewController(vc, animated: true)
            default:
                let vc = MovieListByOptionVC()
                let movieData = viewmodel.getMovieData(for: indexPath.section, query: viewmodel.rowData(for: indexPath.row, in: indexPath.section) as? String ?? "")
                vc.populate(with: movieData)
                navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            let vc = MovieViewController()
            vc.movie = filteredMovies[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMovies.removeAll()
        } else {
            filteredMovies = viewmodel.movieData.filter { movie in
                let lowercasedQuery = searchText.lowercased()
                return movie.year.lowercased().contains(lowercasedQuery) ||
                movie.genre.lowercased().contains(lowercasedQuery) ||
                movie.director.lowercased().contains(lowercasedQuery) ||
                movie.actors.lowercased().contains(lowercasedQuery)
            }
        }
        movieOptionTV.reloadData()
    }
}
