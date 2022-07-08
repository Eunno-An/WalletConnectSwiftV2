import UIKit
import Combine

final class InvitePresenter: ObservableObject {

    private let interactor: InviteInteractor
    private let router: InviteRouter
    private var disposeBag = Set<AnyCancellable>()

    @Published var input: String = .empty {
        didSet { didInputChanged() }
    }

    lazy var rightBarButtonItem: UIBarButtonItem? = {
        let item = UIBarButtonItem(
            title: "Invite",
            style: .plain,
            target: self,
            action: #selector(invite)
        )
        item.isEnabled = false
        return item
    }()

    init(interactor: InviteInteractor, router: InviteRouter) {
        self.interactor = interactor
        self.router = router
    }

    var isClearVisible: Bool {
        return input.count > 0
    }

    @MainActor
    func setupInitialState() async {

    }

    func didPressClear() {
        input = .empty
    }
}

// MARK: SceneViewModel

extension InvitePresenter: SceneViewModel {

    var sceneTitle: String? {
        return "New Chat"
    }

    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        return .always
    }
}

// MARK: Privates

private extension InvitePresenter {

    @MainActor
    @objc func invite() {
        Task(priority: .userInitiated) {
            await interactor.invite(account: input)
            router.dismiss()
        }
    }

    func didInputChanged() {
        rightBarButtonItem?.isEnabled = !input.isEmpty
    }
}