public protocol AccountRepositoryProtocol {
    func saveAccount(with model: SaveAccountDomainModel)
    func getAllAccounts(handler: ([AccountDomainModel]) -> Void)
    func getMyFinanceAccounts(handler: ([AccountDomainModel]) -> Void)
}
