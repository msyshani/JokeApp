//
//  JokeTableViewCell.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 03/10/23.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    
    private var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 4
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    private func initialSetup() {
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(dateLabel)
        setUpConstraints()
        self.layoutIfNeeded()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Spaces.spacing4x.rawValue),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Spaces.spacing4x.rawValue),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spaces.spacing4x.rawValue),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Spaces.spacing4x.rawValue),
        ])
    }
    
    func configureData(from model: JokeModel) {
        titleLabel.text = model.joke
        dateLabel.text = model.jokeTime
    }


}
