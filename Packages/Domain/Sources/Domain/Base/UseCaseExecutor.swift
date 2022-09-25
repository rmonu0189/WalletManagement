import Foundation

public class UseCaseExecutor {
    public init() {}

    public func execute(
        useCase: BaseUseCase,
        input: Any? = nil,
        success: ((Any) -> Void)? = nil,
        failed: ((Error) -> Void)? = nil
    ) {
        useCase.result = { response in
            DispatchQueue.main.async {
                switch response {
                case let .success(value):
                    success?(value)
                case let .failed(error):
                    failed?(error)
                }
            }
        }
        useCase.execute(input: input)
    }
}
