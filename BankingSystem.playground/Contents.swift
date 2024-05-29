import UIKit

// MARK: Bank Account Implementation
class BankAccount {
    
    let accountNumber: String
    //here this is a priv var coz it shouldnt be accessed by anyone outside its class
    private var _balance: Double
        
    var balance: Double {
        return _balance
    }
    
    init(accountNumber: String , initialBalance: Double) {
        self.accountNumber = accountNumber
        self._balance = initialBalance
    }
    
    func deposit (amount : Double){
        _balance += amount
    }
    
    func withdraw (amount: Double){
        guard _balance>=amount else{
            print("Insufficient Funds")
            return
        }
        _balance -= amount
    }
    
    deinit {
        print("Account \(accountNumber) is being closed.")
    }
    
    func printAccountDetails() {
           print("Account Number: \(accountNumber)\nBalance: \(balance)")
       }
}

// MARK: Savings Account Implementation
class SavingsAccount : BankAccount {
    let interestRate : Double
    
  
    init(interestRate: Double, accountNumber: String , initialBalance: Double) {
        self.interestRate = interestRate
        super.init(accountNumber: accountNumber, initialBalance: initialBalance)
    }
    
    override func withdraw(amount: Double) {
        guard balance - amount>=100 else{
            print("Withdrawal not allowed. Balance must remain above 100 Rs.")
            return
        }
        super.withdraw(amount: amount)
    }
    
      func applyInterest() {
          let interest = super.balance * interestRate
          deposit(amount: interest)
//          print("Balance after applying interest :" \(balance))
      }
    override func printAccountDetails() {
          super.printAccountDetails()
          print("Interest Rate: \(interestRate)")
      }
}

// MARK: Current Account Implementation
class CurrentAccount : BankAccount {
    let overdraftLimit: Double
        
        init(accountNumber: String, initialBalance: Double, overdraftLimit: Double) {
            self.overdraftLimit = overdraftLimit
            super.init(accountNumber: accountNumber, initialBalance: initialBalance)
        }
        
        override var balance: Double {
            return super.balance + overdraftLimit
        }
        
        override func withdraw(amount: Double) {
            let effectiveBalance = super.balance + overdraftLimit
            guard effectiveBalance >= amount else {
                print("Overdraft limit exceeded.")
                return
            }
            super.withdraw(amount: amount)
        }
        
        override func printAccountDetails() {
            super.printAccountDetails()
            print("Overdraft Limit: \(overdraftLimit)")
        }
}


// Example of usage
let savings = SavingsAccount(interestRate: 0.05, accountNumber: "SA123", initialBalance: 1000)
savings.deposit(amount: 500)
savings.applyInterest()
savings.printAccountDetails()

let current = CurrentAccount(accountNumber: "CA456", initialBalance: 2000, overdraftLimit: 500)
current.withdraw(amount: 2500)
current.withdraw(amount: 300)
current.printAccountDetails()
