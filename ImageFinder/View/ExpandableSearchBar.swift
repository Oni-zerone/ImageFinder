//
//  ExpandableSearchBar.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

@IBDesignable
class ExpandableSearchBar: UIView {
    
    weak var searchLabel: UILabel!
    weak var textField: UITextField!
    fileprivate weak var bubbleView: UIView!
    
    var text: String? {
        set {
            self.textField.text = newValue
        }
        get {
            return self.textField.text
        }
    }
    
    weak var delegate: ExpandableSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    private func setupUI() {
        
        self.backgroundColor = .clear
        self.clipsToBounds = false
        
        self.setupLabel()
        self.setupField()
    }
    
    private func setupLabel() {
        
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .white
        label.text = "SEARCH"
        label.transform = CGAffineTransform(translationX: 0, y: 10)
        self.searchLabel = label
        
        self.addSubview(label)
        
        self.centerXAnchor.constraint(equalTo: label.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
    }
    
    private func setupField() {
        
        self.setupContainer()
        
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.bubbleView.addSubview(textField)
        textField.keyboardAppearance = .dark
        textField.backgroundColor = .clear
        textField.returnKeyType = .search
        textField.textAlignment = .center
        textField.delegate = self
        
        self.bubbleView.topAnchor.constraint(equalTo: textField.topAnchor).isActive = true
        self.bubbleView.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
        self.bubbleView.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        self.bubbleView.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        self.textField = textField
    }
    
    private func setupContainer() {
        
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        self.addSubview(view)
        
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.bubbleView = view
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {

        return self.textField.becomeFirstResponder()
    }
}

//MARK: - UITextFieldDelegate

extension ExpandableSearchBar: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.zoomInAnimation()
        self.delegate?.searchBarDidBeginEditing(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.zoomOutAnimation()
        self.delegate?.searchBar(self, didEndEditingWith: self.textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}

// MARK: - Animations

extension ExpandableSearchBar {
    
    fileprivate func zoomInAnimation() {
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {

            let transformation = CGAffineTransform(scaleX: 1.2, y: 1.2).translatedBy(x: 0, y: 40)
            self.bubbleView.transform = transformation
            self.bubbleView.backgroundColor = .white
            
            self.searchLabel.transform = .identity
            self.textField.textColor = .black
        }, completion: nil)
    }
    
    fileprivate func zoomOutAnimation() {
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {

            self.bubbleView.backgroundColor = .darkGray
            self.bubbleView.transform = .identity
            
            self.searchLabel.transform = CGAffineTransform(translationX: 0, y: 10)
            self.textField.textColor = .acidGreen

        }, completion: nil)
    }
}

protocol ExpandableSearchBarDelegate: class {
    
    func searchBarDidBeginEditing(_ searchBar: ExpandableSearchBar)
    
    func searchBar(_ searchBar: ExpandableSearchBar, didEndEditingWith string: String?)
}
