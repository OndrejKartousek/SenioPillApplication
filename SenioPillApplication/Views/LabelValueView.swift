//
//  LabelValueView.swift
//  SenioPillApplication
//
//  Created by Ondřej Kartousek on 23.06.2022.
//

import Foundation
import UIKit

open class LabelValueView: UIView {

    let titleLabel = UILabel()

    let valueTextField = UITextField()

    public init(title: String, isEditable: Bool = false) {
        super.init(frame: .zero)
        prepareView()
        titleLabel.text = title
        valueTextField.isUserInteractionEnabled = isEditable
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func prepareView() {
        backgroundColor = .white
        prepareTitle()
        prepareTextField()
    }

    func prepareTitle() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 19).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
    }

    func prepareTextField() {
        self.addSubview(valueTextField)
        valueTextField.translatesAutoresizingMaskIntoConstraints = false
        valueTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        valueTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        valueTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -19).isActive = true
        valueTextField.heightAnchor.constraint(equalToConstant: 15).isActive = true
        valueTextField.font = .systemFont(ofSize: 17, weight: .regular)
    }
}
