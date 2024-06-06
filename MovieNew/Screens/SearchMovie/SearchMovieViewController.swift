//
//  SearchMovie.swift
//  MovieNew
//
//  Created by QuocTN on 18/11/2023.
//

import UIKit

class SearchMovieViewController: BaseViewController {
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var genresView: UIView!
    @IBOutlet weak var textCategorieLabel: UILabel!
    @IBOutlet weak var textGenresLabel: UILabel!
    @IBOutlet weak var chooseCategoriButton: UIButton!
    @IBOutlet weak var chooseGenresButton: UIButton!
    
    private let model: SearchScreenModel = SearchScreenModel()
    private var listSearchData: ListMovies?
    private var movieID: Int = 0
    private var defaultListTrendingMovies: Bool = true
    private var titleCategory: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        setUpView()
        setUpCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpTextField()
        animateTabBar(hidden: true)
    }
    
    func setUpTextField() {
        let hexColor = "#AAA6A6"
        let placeholderColor = UIColor(hexString: hexColor)
        let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: placeholderColor
                ]
        let attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
        searchTextField.attributedPlaceholder = attributedPlaceholder
    }
    
    func setUpView() {
        searchView.layer.cornerRadius = 4
        categoriesView.layer.cornerRadius = 8
        genresView.layer.cornerRadius = 8
    }
    
    func setUpCollectionView() {
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        
        let nibList = UINib(nibName: "DiscoverMovieCollectionViewCell", bundle: nil)
        searchCollectionView.register(nibList, forCellWithReuseIdentifier: "DiscoverMovieCollectionViewCell")
        let nibListMovieEmpty = UINib(nibName: "ListMovieEmptyCollectionViewCell", bundle: nil)
        searchCollectionView.register(nibListMovieEmpty, forCellWithReuseIdentifier: "ListMovieEmptyCollectionViewCell")
    }
    
    func getSearchMovie(with query: String) {
        model.onGetDataSuccess = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.didGetData = true
                self.displayActivityIndicatorView(display: false)
                self.searchCollectionView.reloadData()
            }
        }
        
        model.onGetDataFail = { [weak self] (error: NetworkServiceError) in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.searchCollectionView.reloadData()
        }
        self.didGetData = false
        self.displayActivityIndicatorView(display: true)
        self.model.requestMainData(titleSearch: query)
    }
    
    func navitoDetailScreen(movieID: Int) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailMovie") as! DetailMovieViewController
        detailVC.movieID = movieID
        self.navigationController?.pushViewController(detailVC, animated: false)
    }
    
    @IBAction func chooseCategories(_ sender: UIButton) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "categoriesID") as! ChooseCategoriesViewController
        detailVC.delegateCategory = self
        self.navigationController?.present(detailVC, animated: true)
    }
    
    @IBAction func chooseGenres(_ sender: UIButton) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "genresID") as! ChooseGenresViewController
        detailVC.delegateGenres = self
        self.navigationController?.present(detailVC, animated: true)
    }
    
    @IBAction func backPlayScreen(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !defaultListTrendingMovies {
            return model.listSearchMovies?.results.count ?? 0
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !defaultListTrendingMovies {
            guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverMovieCollectionViewCell", for: indexPath) as? DiscoverMovieCollectionViewCell else {
                return UICollectionViewCell()
            }
            if didGetData == true, let data = model.listSearchMovies {
                cell.setUpData(data: data.results[indexPath.row])
            }
            return cell
        } else {
            guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "ListMovieEmptyCollectionViewCell", for: indexPath) as? ListMovieEmptyCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navitoDetailScreen(movieID: model.listSearchMovies?.results[indexPath.row].id ?? 0)
    }
}

extension SearchMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if defaultListTrendingMovies {
            return CGSize(width:searchCollectionView.frame.width, height: 240)
        } else {
            return CGSize(width:searchCollectionView.frame.width / 3.0 - 12, height: 220)
        }
        
    }
}

extension SearchMovieViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (searchTextField.text ?? "") + string
        defaultListTrendingMovies = false
        getSearchMovie(with: currentText)
        searchCollectionView.reloadData()
        return true
    }
}

extension SearchMovieViewController: ListSearchMoviesCellDelegate {
    func gotoDiscoverDetailMovie(movieID: Int) {
        navitoDetailScreen(movieID: movieID)
    }
}

extension SearchMovieViewController: ChooseCategoriesDelegate {
    func didSelectCategory(_ category: String) {
        textCategorieLabel.text = category
    }
}

extension SearchMovieViewController: ChooseGenresDelegate {
    func didSelectgenres(_ genres: String) {
        textGenresLabel.text = genres
    }
}
