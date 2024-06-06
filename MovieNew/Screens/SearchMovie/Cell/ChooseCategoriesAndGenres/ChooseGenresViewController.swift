//
//  ChooseGenresViewController.swift
//  MovieNew
//
//  Created by QuocTN on 20/01/2024.
//

import UIKit
protocol ChooseGenresDelegate: AnyObject {
    func didSelectgenres(_ genres: String)
}
class ChooseGenresViewController: BaseViewController {
    
    @IBOutlet var homeView: UIView!
    @IBOutlet weak var chooseGenresView: UIView!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    var genresData: ListGenresResponseEntity?
    let model: SearchScreenModel = SearchScreenModel()
    var selectedTitle: Set<String> = Set<String>()
    var textGenres: String?
    weak var delegateGenres: ChooseGenresDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpCollectionView()
        getHomeMovie()
    }
    
    private func setUpView() {
        chooseGenresView.layer.cornerRadius = 32
        cancelButton.layer.cornerRadius = 12
        applyButton.layer.cornerRadius = 12
    }
    
    private func setUpCollectionView() {
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
        
        let nibListGenres = UINib(nibName: "GenresCollectionViewCell", bundle: nil)
        genresCollectionView.register(nibListGenres, forCellWithReuseIdentifier: "GenresCollectionViewCell")
        
        let columnLayout = CustomViewFlowLayout()
        if #available(iOS 10.0, *) {
            columnLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        } else {
            columnLayout.estimatedItemSize = CGSize(width: 41, height: 41)
        }
        genresCollectionView.collectionViewLayout = columnLayout
    }
    
    func getHomeMovie() {
        model.onGetDataSuccess = { [weak self] () in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.genresCollectionView.reloadData()
        }
        
        model.onGetDataFail = { [weak self] (error: NetworkServiceError) in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.genresCollectionView.reloadData()
        }
        
        
        self.didGetData = false
        self.displayActivityIndicatorView(display: true)
        self.model.requestGenresData()
    }
    
    @IBAction func clickCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        cancelButton.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
        cancelButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        applyButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        applyButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func clickApply(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if let textGenres = textGenres {
            delegateGenres?.didSelectgenres(textGenres)
        }
        applyButton.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
        applyButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cancelButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cancelButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

extension ChooseGenresViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.listGenresData?.genres.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = genresCollectionView.dequeueReusableCell(withReuseIdentifier: "GenresCollectionViewCell", for: indexPath) as? GenresCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let dataGenres = model.listGenresData {
            didGetData = true
            cell.bindData(data: dataGenres, indexCell: indexPath.row)
            if selectedTitle.contains(model.listGenresData?.genres[indexPath.row].name ?? "") {
                cell.homeViewCell.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
            } else {
                cell.homeViewCell.backgroundColor = #colorLiteral(red: 0.118523322, green: 0.118523322, blue: 0.118523322, alpha: 1)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let titleGenres = model.listGenresData?.genres[indexPath.row].name
        if selectedTitle.contains(titleGenres ?? "") {
            selectedTitle.remove(titleGenres ?? "")
        } else {
            selectedTitle.insert(titleGenres ?? "")
        }
        textGenres = selectedTitle.joined(separator: ", ")
        genresCollectionView.reloadData()
        
    }
}

class CustomViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 10
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 10.0
        self.sectionInset = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 0.0, right: 16.0)
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
