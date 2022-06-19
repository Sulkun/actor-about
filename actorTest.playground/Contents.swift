import UIKit

actor BankAccount {
    let accountNumber: Int
    var balance: Double
    
    init(accountNumber: Int, initialDeposit: Double) {
        self.accountNumber = accountNumber
        self.balance = initialDeposit
    }
}

extension BankAccount {
    enum BankError: Error {
        case insufficientFunds
    }
    
    func deposit(amount: Double) {
        assert(amount >= 0)
        balance = balance + amount
    }
    
    func transfer(amount: Double, to other: BankAccount) async throws {
        if amount > self.balance  {
            throw BankError.insufficientFunds
        }
        
        print("Transferring \(amount) form \(accountNumber) to \(other.accountNumber)")

        balance = balance - amount
        //other.balance = other.balance + amount // Actor-isolated property 'balance' can not be mutated on a non-isolated actor instance
        await other.deposit(amount: amount)
    }
}






