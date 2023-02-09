//
//  ViewController.swift
//  RxSwiftNeww
//
//  Created by 노영재 on 2023/02/01.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class ViewController: UIViewController {

    //MARK: Properties
    let viewModel : ViewModel
    let disposeBag = DisposeBag()
    
    let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    //MARK: Lifecycles
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        fetchArticles()
        subscribe()
    }

    // MARK: Configuress
    func configureUI() {
        view.backgroundColor = .white
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.resueidentifier)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    //MARK: Helpers
    func fetchArticles() {
        self.viewModel.fetchArticles().subscribe(onNext: { articlesViewModels in
            self.articleViewModel.accept(articlesViewModels)
        }).disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articleViewModelObserver.subscribe(onNext: { articles in
            //collectionView reload
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.resueidentifier, for: indexPath) as? ArticleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let articleViewModel = self.articleViewModel.value[indexPath.row]
        cell.viewModel.onNext(articleViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
