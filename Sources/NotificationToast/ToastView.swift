//
//  ToastView.swift
//  Toast
//
//  Created by Philippe Weidmann on 20.12.20.
//

import UIKit
import QuartzCore

public class ToastView: UIView {

    public override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private let height: CGFloat = 50
    private var hStack: UIStackView
    private let darkBackgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
    private let lightBackgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.00)
    
    public var autoHide = true

    public init(title: String, subtitle: String? = nil, icon: UIImage? = nil) {
        hStack = UIStackView(frame: CGRect.zero)
        super.init(frame: CGRect.zero)
        
        backgroundColor = traitCollection.userInterfaceStyle == .dark ? darkBackgroundColor : lightBackgroundColor

        getTopViewController()?.view.addSubview(self)
        hStack.spacing = 16
        hStack.axis = .horizontal
        hStack.alignment = .center

        let vStack = UIStackView(frame: CGRect.zero)
        vStack.axis = .vertical
        vStack.alignment = .center

        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.numberOfLines = 1
        titleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        titleLabel.text = title
        vStack.addArrangedSubview(titleLabel)

        if let icon = icon {
            let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
            iconImageView.tintColor = .label
            iconImageView.image = icon
            hStack.addArrangedSubview(iconImageView)
        }

        if let subtitle = subtitle {
            let subtitleLabel = UILabel(frame: CGRect.zero)
            subtitleLabel.textColor = .secondaryLabel
            subtitleLabel.numberOfLines = 1
            subtitleLabel.font = .systemFont(ofSize: 11, weight: .light)
            subtitleLabel.text = subtitle
            vStack.addArrangedSubview(subtitleLabel)
        }

        hStack.addArrangedSubview(vStack)
        addSubview(hStack)

        setupConstraints()
        setupStackViewConstraints()

        transform = CGAffineTransform(translationX: 0, y: -100)
    }

    public func show() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { [self] (completed) in
            if autoHide {
                hide()
            }
        }
    }

    public func hide() {
        UIView.animate(withDuration: 0.2, delay: 1, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -100)
        }) { (completed) in
            self.removeFromSuperview()
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        backgroundColor = traitCollection.userInterfaceStyle == .dark ? darkBackgroundColor : lightBackgroundColor
    }
    
    private func getTopViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)

        let centerConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .topMargin, multiplier: 1, constant: 0)

        let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: .leadingMargin, multiplier: 1, constant: 8)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .trailingMargin, multiplier: 1, constant: -8)
        clipsToBounds = true
        layer.cornerRadius = height / 2
        superview?.addConstraints([heightConstraint, leadingConstraint, trailingConstraint, centerConstraint, topConstraint])
    }

    private func setupStackViewConstraints() {
        hStack.translatesAutoresizingMaskIntoConstraints = false

        let leadingConstraint = NSLayoutConstraint(item: hStack, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 24)
        let trailingConstraint = NSLayoutConstraint(item: hStack, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -24)
        let topConstraint = NSLayoutConstraint(item: hStack, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: hStack, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)

        addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }

    private func setupShadow() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 1
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
