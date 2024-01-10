public enum JobsListError: Error, Equatable {
    case forbidden
    case connectionError(innerError: Error?)
    case other

    case notEnoughPermissions
    case notAvailable
    case blocked

    public static func == (lhs: JobsListError, rhs: JobsListError) -> Bool {
        switch (lhs, rhs) {
        case (.connectionError, .connectionError):
            return true
        case (.forbidden, .forbidden):
            return true
        case (.other, .other):
            return true
        case (.notEnoughPermissions, .notEnoughPermissions):
            return true
        case (.notAvailable, .notAvailable):
            return true
        case (.blocked, .blocked):
            return true
        default:
            return false
        }
    }
}

// Necessary to be renderable in SwiftUI
extension JobsListError: Identifiable {
    public var id: String { String(describing: self) }
}
