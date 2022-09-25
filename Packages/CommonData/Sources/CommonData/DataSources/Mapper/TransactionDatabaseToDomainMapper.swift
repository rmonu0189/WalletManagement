import Domain

struct TransactionDatabaseToDomainMapper {
    func map(input: TransactionDatabaseModel) -> TransactionItemDomainModel {
        .init(
            uuid: input.uuid ?? "",
            toAccountUuid: input.toAccountUuid ?? "",
            toAccountName: input.toAccountName ?? "",
            fromAccountUuid: input.fromAccountUuid ?? "",
            fromAccountName: input.fromAccountName ?? "",
            amount: input.amount,
            date: input.date,
            comment: input.comment,
            type: input.type ?? ""
        )
    }
}
