import Foundation
import Kitura
import KituraNet
import SwiftyJSON

import SwiftKuery

import HeliumLogger
import LoggerAPI

let logger = HeliumLogger(.verbose)
Log.logger = logger

HeliumLogger.use(.verbose)

let router = Router()

router.get("/get") { (req: RouterRequest, response: RouterResponse, next: @escaping () -> Void) in
    let table = ExampleTable()
    let select = Select(from: table)
    MySQLConnectionManager.shared.execute(select) { (results) in
        results.forEach { (result) in
            response.send("================\n")
            result.forEach { (key, value) in
                guard let value = value else {
                    response.send("\(key): nil\n")
                    return
                }
                response.send("\(key): \(value)\n")
            }
        }
        try? response.send("================").end()
    }
}

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
