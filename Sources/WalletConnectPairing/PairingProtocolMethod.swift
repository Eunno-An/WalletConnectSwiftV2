import Foundation
import WalletConnectNetworking

struct PairingPingProtocolMethod: ProtocolMethod {
    var method: String = "wc_pairingPing"

    var requestConfig = RelayConfig(tag: 1002, prompt: false, ttl: 30)

    var responseConfig = RelayConfig(tag: 1003, prompt: false, ttl: 30)
}
