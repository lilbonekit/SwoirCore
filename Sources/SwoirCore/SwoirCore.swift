import Foundation

public enum SwoirBackendError: Error, Equatable {
    case errorProving(String)
    case errorVerifying(String)
    case networkError(String)
    case memoryLimitExceeded
    case invalidBytecode
    case emptyBytecode
    case emptyWitnessMap
    case emptyProofData
    case emptyVerificationKey
    case emptyProofType
}

public struct Proof {
    public let proof: Data
    public let vkey: Data

    public init(proof: Data, vkey: Data) {
        self.proof = proof
        self.vkey = vkey
    }
}

public protocol SwoirBackendProtocol {
    static func prove(bytecode: Data, witnessMap: [Int64], proof_type: String) throws -> Proof
    static func verify(bytecode: Data, proof: Proof, proof_type: String) throws -> Bool
}
