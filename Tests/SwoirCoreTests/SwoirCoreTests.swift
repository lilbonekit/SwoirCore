import XCTest
@testable import SwoirCore

final class SwoirCoreTests: XCTestCase {

    class MockSwoirBackend: SwoirBackendProtocol {
        static func setup_srs(bytecode: Data, srs_path: String? = nil, recursive: Bool) throws -> UInt32 {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            return 0
        }

        static func prove(bytecode: Data, witnessMap: [String], proof_type: String, recursive: Bool) throws -> Proof {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            if witnessMap.isEmpty { throw SwoirBackendError.emptyWitnessMap }
            if proof_type.isEmpty { throw SwoirBackendError.emptyProofType }
            return Proof(proof: Data("foo".utf8), vkey: Data("bar".utf8))
        }
        static func verify(proof: Proof, proof_type: String) throws -> Bool {
            if proof.proof.isEmpty { throw SwoirBackendError.emptyProofData }
            if proof.vkey.isEmpty { throw SwoirBackendError.emptyVerificationKey }
            if proof_type.isEmpty { throw SwoirBackendError.emptyProofType }
            return true
        }

        static func execute(bytecode: Data, witnessMap: [String]) throws -> [String] {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            if witnessMap.isEmpty { throw SwoirBackendError.emptyWitnessMap }
            return witnessMap
        }
    }

    func testErrorCases() throws {
        let bytecode = Data([0x01])
        let witnessMap = ["1", "2"]
        let emptyBytecode = Data()
        let emptyWitnessMap = [String]()
        let proofEmptyProof = Proof(proof: Data(), vkey: Data([0x01]))
        let proofEmptyVKey = Proof(proof: Data([0x01]), vkey: Data())

        XCTAssertThrowsError(try MockSwoirBackend.prove(bytecode: emptyBytecode, witnessMap: witnessMap, proof_type: "honk", recursive: false)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyBytecode)
        }
        XCTAssertThrowsError(try MockSwoirBackend.prove(bytecode: bytecode, witnessMap: emptyWitnessMap, proof_type: "honk", recursive: false)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyWitnessMap)
        }
        XCTAssertThrowsError(try MockSwoirBackend.verify(proof: proofEmptyProof, proof_type: "honk")) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyProofData)
        }
        XCTAssertThrowsError(try MockSwoirBackend.verify(proof: proofEmptyVKey, proof_type: "honk")) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyVerificationKey)
        }
        XCTAssertThrowsError(try MockSwoirBackend.prove(bytecode: bytecode, witnessMap: witnessMap, proof_type: "", recursive: false)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyProofType)
        }
        XCTAssertThrowsError(try MockSwoirBackend.execute(bytecode: emptyBytecode, witnessMap: witnessMap)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyBytecode)
        }
        XCTAssertThrowsError(try MockSwoirBackend.execute(bytecode: bytecode, witnessMap: emptyWitnessMap)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyWitnessMap)
        }
    }
}
