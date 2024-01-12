//
//  ProfileEditStackView.swift
//  FakeNFT
//
//  Created by Максим on 23.12.2023.
//

import UIKit

class ProfileEditStackView: UIStackView {

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .blackDayNight
        return label
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGreyDayNight
        textView.textColor = .blackDayNight
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isScrollEnabled = false
        textView.text = ""

        textView.layer.cornerRadius = 12
        textView.clipsToBounds = true

        textView.textContainerInset = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 16)
        return textView
    }()

    private var originalTextContent: String?

    init(labelText: String, textContent: String) {
        super.init(frame: .zero)

        label.text = labelText
        textView.text = textContent
        originalTextContent = textContent

        textView.inputAccessoryView = setupKeyboardToolBar()

        setupViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupViews() {
        addArrangedSubview(label)
        addArrangedSubview(textView)

        axis = .vertical
        spacing = 8
    }
    // MARK: - Private Methods
    private func setupKeyboardToolBar() -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: TextLabels.ProfileEditStackView.keyboardDoneButton,
                                         style: .done, target: self, action: #selector(dismissKeyboard))
        let resetButton = UIBarButtonItem(title: TextLabels.ProfileEditStackView.keyboardResetButton,
                                          style: .done, target: self, action: #selector(resetTextToOriginal))
        toolBar.setItems([flexibleSpace, resetButton, doneButton], animated: false)
        return toolBar
    }
    // MARK: - Public Methods
    func getTextContent() -> String? {
        return textView.text
    }

    func updateTextContent(_ text: String) {
        textView.text = text
        originalTextContent = text
    }

    @objc func resetTextToOriginal() {
        textView.text = originalTextContent
    }

    @objc func dismissKeyboard() {
        textView.resignFirstResponder()
    }

}
