import UIKit

class BankAccount {
    
    let accountNumber: String
    //here this is a priv var coz it shouldnt be accessed by anyone outside its class
    private var _Balance: Double
    
    var Balance : Double {
        return _Balance
    }
    
    init(accountNumber: String , initialBalance: Double) {
        self.accountNumber = accountNumber
        self._Balance = initialBalance
    }
}

class SavingsAccount : BankAccount {
    let interestRate : Double
    
    
}
class CurrentAccount : BankAccount {
    let overdraftLimit: Double
}
