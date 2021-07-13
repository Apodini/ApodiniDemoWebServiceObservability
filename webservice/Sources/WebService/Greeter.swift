import Logging
import Apodini
import ApodiniObserve

struct Greeter: Handler {
    @Parameter(.http(.body))
    var name: String? = "World"

    @Parameter(.http(.body))
    var newMove: CreateMoveMediator
    
    @Environment(\.logger) var logger
    @ConfiguredLogger var loggerNew
    
    func handle() -> String {
        logger.info("Hello world")
        loggerNew.info("Hello world2")
        return "Hello, \(newMove.name)! 👋"
    }
    
    public struct CreateMoveMediator: Codable, Identifiable {
        public var id: String
        let name: String
        let type: String
        let location: Location
        
        struct Location: Codable {
            let x: Int
            let y: Int
        }
    }
}
