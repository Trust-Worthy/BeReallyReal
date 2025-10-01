//
//  Feed/PostCell.swift
//  BeReallyReal
//
//  Created by Trust-Worthy on 10/1/25.
//
import UIKit
import Alamofire
import AlamofireImage

class FeedTableViewCell: UITableViewCell {

    static let identifier = "FeedTableViewCell"

    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let postImageView = UIImageView()
    private let captionLabel = UILabel()
    private let dateLabel = UILabel()

    private var imageDataRequest: DataRequest?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(captionLabel)
        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),

            usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            postImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),

            captionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            dateLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        // Optional styling
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        captionLabel.numberOfLines = 0
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .secondaryLabel
    }

    func configure(with post: Post) {
        // Username
        usernameLabel.text = post.user?.username

        // Image
        if let imageUrl = post.imageFile?.url {
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    self?.postImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                }
            }
        }

        // Caption
        captionLabel.text = post.caption

        // Date
        if let date = post.createdAt {
            dateLabel.text = DateFormatter.postFormatter.string(from: date)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        imageDataRequest?.cancel()
    }
}
