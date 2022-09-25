public enum UseCaseResult {
    case success(Any)
    case failed(Error)
}

open class BaseUseCase {
    public var result: ((UseCaseResult) -> Void)!

    public init() {}

    open func execute(input _: Any?) {
        fatalError("UseCase execute method not implemented.")
    }
}
