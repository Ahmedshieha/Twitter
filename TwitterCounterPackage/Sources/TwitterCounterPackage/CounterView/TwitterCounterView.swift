//
//  TwitterCounterView.swift
//
//
//  Created by Reda on 01/05/2024.
//

import UIKit

public protocol TwitterCounterViewProtocol: AnyObject {
    func postTweet(text: String)
}

public class TwitterCounterView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var characterRemainingLabel: UILabel!
    @IBOutlet private weak var characterTypedLabel: UILabel!
    @IBOutlet private weak var tweetTextView: UITextView!
    @IBOutlet private weak var postButton: UIButton!
    
    public weak var delegate: TwitterCounterViewProtocol?
    
    private lazy var viewModel: TwitterCounterViewModelProtocol = {
        TwitterCounterViewModel()
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupTextView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContentView()
        setupTextView()
    }
    
    @IBAction private func didTapCopyText(_ sender: Any) {
        copyText()
    }
    
    @IBAction private func didTapClearText(_ sender: Any) {
        tweetTextView.text = ""
    }
    
    @IBAction private func didTapPostTweet(_ sender: Any) {
        let tweetText = tweetTextView.text ?? ""
        delegate?.postTweet(text: tweetText)
    }
}

// MARK: - Setup TextView Delegate
extension TwitterCounterView: UITextViewDelegate {
    
    private func setupTextView() {
        tweetTextView.delegate = self
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        validateTweet()
        characterTypedLabel.text = "\(viewModel.tweetCount(with: textView.text))/280"
    }
}

// MARK: - setup Views
private extension TwitterCounterView {
    
    func setupContentView() {
        Bundle.module.loadNibNamed("TwitterCounterView", owner: self)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func copyText() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = tweetTextView.text
    }
    
    func validateTweet() {
        let tweetText = tweetTextView.text ?? ""
        viewModel.validateTweetCount(tweetText) ? updateLabelColor(true) : updateLabelColor(false)
    }
    
    func updateLabelColor(_ valid: Bool) {
        postButton.isEnabled = valid
        characterTypedLabel.textColor = valid ? .black : .red
    }
}
