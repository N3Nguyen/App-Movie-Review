import Foundation
import UIKit

struct Accounts: Codable {
    var accountName: String
    var accountPassword: String
}

class AccountClass {
    var accountArray: [Accounts] = []

    // save in array Default
    func saveAccountArray(account: [Accounts]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(account)
            UserDefaults.standard.set(data, forKey: "accountArrayKey")
        } catch {
            print("error: \(error)")
        }
    }

    // decoder array from UserDefaults
    func loadAccountArray() {
        if let data = UserDefaults.standard.data(forKey: "accountArrayKey") {
            do {
                let decoder = JSONDecoder()
                let loadedAccountArray = try decoder.decode([Accounts].self, from: data)
                accountArray = loadedAccountArray
            } catch {
                print("error decoder: \(error)")
            }
        }
    }
}
