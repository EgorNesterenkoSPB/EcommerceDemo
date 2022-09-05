import Foundation
import UIKit

func errorAC(_ message:String) -> UIAlertController
{
    let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    return ac
}
