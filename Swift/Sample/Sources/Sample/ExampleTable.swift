import Foundation
import SwiftKuery

class ExampleTable: Table {
    let tableName = "example"

    let id = Column("id")
    let name = Column("name")
}
