//
//  ViewController.swift
//  RxSwiftNeww
//
//  Created by 노영재 on 2023/02/01.
//

import UIKit
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
    }
    
    //MARK: Helpers
    func fetchArticles() {
        self.viewModel.fetchArticles().subscribe(onNext: { articlesViewModel in
            self.articleViewModel.accept(articlesViewModel)
        }).disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articleViewModelObserver.subscribe(onNext: { articles in
            //collectionView reload
            print(articles)
        }).disposed(by: disposeBag)
    }
    
}

