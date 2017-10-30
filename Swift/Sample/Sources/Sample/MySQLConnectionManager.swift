import Foundation
import SwiftKueryMySQL
import SwiftKuery
import LoggerAPI

class MySQLConnectionManager {
    static let shared = MySQLConnectionManager()

    private let connection: Connection
    private let pool: ConnectionPool

    init() {
        pool = MySQLThreadSafeConnection.createPool(host: "mysql-db", user: "example", password: "example", database: "Example", characterSet: "utf8", reconnect: true, poolOptions: ConnectionPoolOptions(initialCapacity: 10))
        guard let connection = pool.getConnection() else {
            pool.disconnect()
            fatalError("getConnection is nil")
        }
        self.connection = connection
    }

    deinit {
        connection.closeConnection()
        pool.disconnect()
    }

    func execute(_ query: Query, parameters: [String: Any] = [:], _ handler: @escaping ([[String: Any?]]) -> Void ) {
        connection.execute(query: query, parameters: parameters) { (result) in
            if let error = result.asError {
                Log.error(error.localizedDescription)
                return
            }
            guard let rows = result.asRows else {
                handler([])
                return
            }
            handler(rows)
        }
    }
}
