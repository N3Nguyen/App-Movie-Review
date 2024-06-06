import UIKit
import CommonCrypto

extension String {
    
    static let empty = ""
    
    func toStringVnWith(fromDateFormat: String, toDateFormat: String) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Contants.timeFormatVN)
            dateFormatter.dateFormat = fromDateFormat
        
        guard let newDate = dateFormatter.date(from: self) else {
            return String.empty
        }
        
        dateFormatter.dateFormat = toDateFormat
        return dateFormatter.string(from: newDate)

    }
}

