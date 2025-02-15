//
//  StarRatingView.swift
//  FakeNFT
//
//  Created by Максим on 27.12.2023.
//

import UIKit

final class StarRatingView: UIStackView {

    private var starImageViews: [UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        spacing = 2
        distribution = .fillEqually
        for _ in 1...5 {
            let starView = makeStarView()
            starImageViews.append(starView)
            addArrangedSubview(starView)
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureRating(_ rating: Int) {
        for (index, imageView) in starImageViews.enumerated() {
            if index < rating {
                imageView.tintColor = .yellowUni
            } else {
                imageView.tintColor = .lightGreyDayNight
            }
        }
    }

    private func makeStarView() -> UIImageView {
        let star = UIImageView()
        star.image = UIImage(systemName: "star.fill")
        star.contentMode = .scaleAspectFit
        star.translatesAutoresizingMaskIntoConstraints = false
        return star
    }
}
