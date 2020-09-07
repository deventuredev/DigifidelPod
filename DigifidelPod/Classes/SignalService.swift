import Foundation
import SwiftSignalRClient

public class SignalRService {
    private var connection: HubConnection
    public let SIGNALR_URL:String = "http://84.232.230.195:4099";

    public init() {
        let url = URL(string: SIGNALR_URL)
        connection = HubConnectionBuilder(url: url!).withLogging(minLogLevel: .error).build()
        connection.on(method: "MessageReceived", callback: { (user: String, message: String) in
            do {
                self.handleMessage(message, from: user)
            } catch {
                print(error)
            }
        })
        
        connection.start()
        connection.send(method: "ChangeRoomBylatLongIdentifier", "")

    }
    
    private func handleMessage(_ message: String, from user: String) {
        // Do something with the message.
    }
}
