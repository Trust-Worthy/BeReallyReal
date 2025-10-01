//
//  Feed/FeedViewController.swift
//  BeReallyReal
//
//  Created by Trust-Worthy on 10/1/25.
//
import UIKit
import ParseSwift
import Alamofire
import AlamofireImage


class FeedViewController: UIViewController {

    // MARK: - Properties
    private let tableView = UITableView()
    
    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTableView()
        setupNavigationBar()
        queryPosts()
    }

    // MARK: - Setup
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        // Register your programmatic cell
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
    }

    private func setupNavigationBar() {
        title = "BeReallyReal"
        navigationController?.navigationBar.prefersLargeTitles = true

        let personButton = UIBarButtonItem(
            image: UIImage(systemName: "person.2.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapPersonButton)
        )
        personButton.tintColor = .white
        navigationItem.leftBarButtonItem = personButton
        
        let postButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: #selector(didTapPostButton)
        )
//        postButton.tintColor = .white
        navigationItem.rightBarButtonItem = postButton
    }

    // MARK: - Actions
    @objc private func didTapPersonButton() {
        print("Person button tapped")
    }
    
    @objc private func didTapPostButton() {
        
    }

    // MARK: - Networking
    private func queryPosts() {
        let query = Post.query()
            .include("user")
            .order([.descending("createdAt")])
        
        query.find { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }

    // MARK: - Alerts
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(
            title: "Oops...",
            message: description ?? "Please try again...",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

// MARK: - TableView DataSource & Delegate
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: posts[indexPath.row])
        return cell
    }
}
