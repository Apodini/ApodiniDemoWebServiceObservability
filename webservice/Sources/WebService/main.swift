import Foundation
import Apodini
import ApodiniObserve
import ApodiniOpenAPI
import ApodiniREST
import ApodiniWebSocket
import ArgumentParser
import Logging
import LoggingELK

struct ExampleWebService: WebService {
    @PathParameter(identifying: Greeter.CreateMoveMediator.self)
    var name: String
    
    var test: String = "aaf"
    
    @Environment(\.logger)
    var logger
    
    @Environment(\.eventLoopGroup)
    var eventLoopGroup
    
    @Flag(name: .shortAndLong, help: "Use XML coders")
    var xml = false
    
    var configuration: Configuration {
        REST {
            OpenAPI()
        }
        
        WebSocket()
        
        LoggerConfiguration(logLevel: .debug,
                            logHandlers: LogstashLogHandler.logstashOutput(label: "logstash",
                                                                           eventLoopGroup: eventLoopGroup,
                                                                           backgroundActivityLogger: logger,
                                                                           uploadInterval: TimeAmount.seconds(10),
                                                                           maximumLogStorageSize: 12000),
                            StreamLogHandler.standardOutput(label: "console"))
    }

    var content: some Component {
        Greeter()
    }
}


ExampleWebService.main()
