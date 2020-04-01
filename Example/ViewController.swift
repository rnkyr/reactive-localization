//
//  ViewController.swift
//  Example
//
//  Created by Roman Kyrylenko on 01.04.2020.
//  Copyright © 2020 Roman Kyrylenko. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private let detailsButton = UIButton(type: .system)
    private let changeLanguageButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubviews()
        setupStylings()
        setupBindings()
    }
    
    private func layoutSubviews() {
        view.addSubview(detailsButton)
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        view.addSubview(changeLanguageButton)
        changeLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        changeLanguageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeLanguageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
    }
    
    private func setupStylings() {
        detailsButton.localizedTitle = RxL10n.firstScreenLabel
        changeLanguageButton.localizedTitle = RxL10n.firstScreenChangeLanguageTitle
    }
    
    private func setupBindings() {
        detailsButton.addTarget(self, action: #selector(proceedToDetails), for: .touchUpInside)
        changeLanguageButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
    }
    
    @objc
    private func proceedToDetails() {
        navigationController?.pushViewController(DetailsViewController(), animated: true)
    }
    
    @objc
    private func changeLanguage() {
        let alert = UIAlertController(title: L10n.firstScreenChangeLanguageTitle, message: nil, preferredStyle: .actionSheet)
        let supportingLanguages = ["en", "ru", "es"]
        supportingLanguages.forEach { lang in
            alert.addAction(UIAlertAction(title: lang, style: .default, handler: { _ in
                Bundle.setLanguage(with: lang)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

final class DetailsViewController: UIViewController {
    
    private let languageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubviews()
        setupStylings()
    }
    
    private func layoutSubviews() {
        view.addSubview(languageLabel)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        languageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupStylings() {
        view.backgroundColor = .white
        languageLabel.localizedText = RxL10n.secondScreenLabel(Bundle.currentLangauge ?? "")
    }
}
