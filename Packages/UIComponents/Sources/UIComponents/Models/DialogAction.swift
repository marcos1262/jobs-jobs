public struct DialogAction {
    public let title: LocalizedString
    public let action: (() -> Void)?

    public init(title: LocalizedString,
                action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
    }

    public func copy(title: LocalizedString? = nil,
                     action: (() -> Void)? = nil) -> DialogAction {
        return DialogAction(title: title ?? self.title,
                            action: action ?? self.action)
    }
}
