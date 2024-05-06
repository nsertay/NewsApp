//
//  NewsCell.swift
//  NewsApp
//
//  Created by Nurmukhanbet Sertay on 06.05.2024.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    
    var article: Article! {
        didSet {
            titleLabel.text = article.title
            descriptionLabel.text = article.description
            
            guard let urlToImage = article.urlToImage, let url = URL(string: urlToImage)  else { return }
            newsImageView.sd_setImage(with: url)
        }
    }
    
    static let identifier = "NewsCell"
    
    let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(systemName: "camera.metering.unknown")
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [newsImageView, textStackView])
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .center
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.applyShadowStackView()
        
        return view
    }()
    
    lazy var textStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        view.axis = .vertical
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = UIImage(systemName: "camera.metering.unknown")
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        newsImageView.snp.makeConstraints {
            $0.width.equalTo(130)
            $0.height.equalTo(120)
        }
        
        textStackView.snp.makeConstraints {
            $0.height.equalTo(110)
            $0.top.bottom.equalToSuperview().inset(5)
        }
    }
}

