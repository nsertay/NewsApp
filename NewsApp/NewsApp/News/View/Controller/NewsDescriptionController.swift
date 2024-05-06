//
//  NewsDescriptionController.swift
//  NewsApp
//
//  Created by Nurmukhanbet Sertay on 06.05.2024.
//

import UIKit
import SafariServices

class NewsDescriptionController: UIViewController, SFSafariViewControllerDelegate {
    
    let newsViewModel = NewsViewModel.shared
    
    var article: Article! {
        didSet {
            titleLabel.text = article.title
            descriptionLabel.text = article.description
            authorLabel.text = article.author
            
            guard let urlToImage = article.urlToImage, let url = URL(string: urlToImage)  else { return }
            imageView.sd_setImage(with: url)
        }
    }
    
    var savedLocal = false
    
    let scrollView = UIScrollView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "camera.metering.unknown")
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let textView = UILabel()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.numberOfLines = 0
        return textView
    }()
    
    let sourceButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.setTitle("Go to the source", for: .normal)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, imageView, descriptionLabel, sourceButton])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupTarget()
        setupNavigationBar()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        savedLocal = newsViewModel.isSavedLocal(article: article)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(220)
        }
    }
    
    func setupTarget() {
        sourceButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
    }
    
    func setupNavigationBar() {
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: savedLocal ? "star.fill" : "star"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        favoriteButton.tintColor = .systemYellow
        
        navigationItem.rightBarButtonItem = favoriteButton
    }
    @objc func favoriteButtonTapped() {
        if savedLocal {
            newsViewModel.removeLocal(article: article)
        } else {
            newsViewModel.saveLocal(article: article)
        }
        
        let buttonImage = savedLocal ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
        navigationItem.rightBarButtonItem?.image = buttonImage
    }
    
    @objc func sourceButtonTapped() {
        guard let urlToSource = article.url, let url = URL(string: urlToSource)  else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        
        self.present(safariViewController, animated: true, completion: nil)
    }
}
