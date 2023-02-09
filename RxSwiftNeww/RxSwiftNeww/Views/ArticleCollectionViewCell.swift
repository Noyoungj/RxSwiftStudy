//
//  ArticleCollectionViewCell.swift
//  RxSwiftNeww
//
//  Created by 노영재 on 2023/02/09.
//

import UIKit
import RxSwift
import Kingfisher

class ArticleCollectionViewCell: UICollectionViewCell {
    //MARK: properties
    static let resueidentifier = "ArticleCollectionViewCell"
    let disposeBag = DisposeBag()
    let viewModel = PublishSubject<ArticleViewModel>()
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let labelDescription : UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    //MARK: lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        subscribe()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Subscribe
    func subscribe() {
        self.viewModel.subscribe(onNext: { viewModelArticle in
            if let urlString = viewModelArticle.imageURL {
                let url = URL(string: urlString)
                self.imageView.kf.setImage(with: url)
                self.imageView.kf.indicatorType = .activity
            }
            
            if let title = viewModelArticle.title {
                self.labelTitle.text = title
            }
            
            if let description = viewModelArticle.description {
                self.labelDescription.text = description
            }
        })
    }
    //MARK: configures
    func configureUI() {
        backgroundColor = .systemBackground
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.width.height.equalTo(60)
            make.leading.equalTo(self).offset(20)
        }
        
        addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.leading.equalTo(imageView.snp.trailing)
            make.trailing.equalTo(self.snp.trailing).offset(-40)
        }
        
        addSubview(labelDescription)
        labelDescription.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.leading.trailing.equalTo(labelTitle)
        }
    }
}
