//
//  ChatViewController.swift
//  ChatBot
//
//  Created by nayeon  on 4/15/24.
//

import UIKit
import SnapKit
import Then

class ChatViewController: UIViewController, UICollectionViewDelegate {
    private var dataSource: UICollectionViewDiffableDataSource<Int, MessageDTO>!
    private var viewModel = ChatViewModel(chatService: ChatService())

    lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()).then {
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.backgroundColor = .white
        $0.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.reuseIdentifier)
    }

    private lazy var horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.addArrangedSubview(commentTextView)
        $0.addArrangedSubview(sendButton)
    }

    private lazy var commentTextView = UITextView().then {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.layer.cornerRadius = (($0.font?.pointSize ?? 24) / 2)
        $0.backgroundColor = .lightGray
        $0.textColor = .black
        $0.isScrollEnabled = true
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    }

    private lazy var sendButton = UIButton().then {
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 32)
        let uiImage = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: imageConfiguration)
        $0.setImage(uiImage, for: .normal)
        $0.contentMode = .scaleToFill
        $0.addTarget(nil, action: #selector(sendButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupCollectionView()
        setupViewModel()

    }

    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(horizontalStackView)

        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(horizontalStackView.snp.top)
        }

        horizontalStackView.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(4)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-4)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-4)
            $0.height.equalTo(40)
        }
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.delegate = self

        dataSource = UICollectionViewDiffableDataSource<Int, MessageDTO>(collectionView: collectionView) { [self]
            (collectionView: UICollectionView, indexPath: IndexPath, message: MessageDTO) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.reuseIdentifier, for: indexPath) as? MessageCell else {
                fatalError("메세지 셀 오류")
            }
            cell.configure(with: message)
            return cell
        }

    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // 그룹 크기를 조정하여 한 번에 여러 개의 아이템을 보여줌
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1) // count 값 변경하여 한 번에 보여지는 셀 수 조절 가능
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8 // 셀 사이 간격 조절
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    private func setupViewModel() {
        viewModel.messageUpdateHandler = { [weak self] in
            self?.applySnapshot()
        }
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MessageDTO>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.messages)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func scrollToBottom() {
        guard !viewModel.messages.isEmpty else { return }
        let indexPath = IndexPath(item: viewModel.messages.count - 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }

    @objc private func sendButtonTapped() {
        guard let message = commentTextView.text, !message.isEmpty else { return }
        viewModel.sendMessage(message)
        commentTextView.text = nil
    }
}
