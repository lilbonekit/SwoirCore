import XCTest
@testable import SwoirCore

final class SwoirCoreTests: XCTestCase {

    class MockSwoirBackend: SwoirBackendProtocol {
        static func setup_srs(bytecode: Data, srs_path: String? = nil) throws -> UInt32 {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            return 0
        }

        static func prove(bytecode: Data, witnessMap: [Int64], proof_type: String, num_points: UInt32) throws -> Proof {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            if witnessMap.isEmpty { throw SwoirBackendError.emptyWitnessMap }
            if proof_type.isEmpty { throw SwoirBackendError.emptyProofType }
            return Proof(proof: Data("foo".utf8), vkey: Data("bar".utf8))
        }
        static func verify(bytecode: Data, proof: Proof, proof_type: String, num_points: UInt32) throws -> Bool {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            if proof.proof.isEmpty { throw SwoirBackendError.emptyProofData }
            if proof.vkey.isEmpty { throw SwoirBackendError.emptyVerificationKey }
            if proof_type.isEmpty { throw SwoirBackendError.emptyProofType }
            return true
        }
    }

    func testErrorCases() throws {
        let bytecode = Data([0x01])
        let witnessMap = [Int64(1), Int64(2)]
        let emptyBytecode = Data()
        let emptyWitnessMap = [Int64]()
        let proof = Proof(proof: Data([0x01]), vkey: Data([0x01]))
        let proofEmptyProof = Proof(proof: Data(), vkey: Data([0x01]))
        let proofEmptyVKey = Proof(proof: Data([0x01]), vkey: Data())

        XCTAssertThrowsError(try MockSwoirBackend.prove(bytecode: emptyBytecode, witnessMap: witnessMap, proof_type: "plonk", num_points: 0)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyBytecode)
        }
        XCTAssertThrowsError(try MockSwoirBackend.prove(bytecode: bytecode, witnessMap: emptyWitnessMap, proof_type: "plonk", num_points: 0)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyWitnessMap)
        }
        XCTAssertThrowsError(try MockSwoirBackend.verify(bytecode: emptyBytecode, proof: proof, proof_type: "plonk", num_points: 0)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyBytecode)
        }
        XCTAssertThrowsError(try MockSwoirBackend.verify(bytecode: bytecode, proof: proofEmptyProof, proof_type: "plonk", num_points: 0)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyProofData)
        }
        XCTAssertThrowsError(try MockSwoirBackend.verify(bytecode: bytecode, proof: proofEmptyVKey, proof_type: "plonk", num_points: 0)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyVerificationKey)
        }
        XCTAssertThrowsError(try MockSwoirBackend.prove(bytecode: bytecode, witnessMap: witnessMap, proof_type: "", num_points: 0)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyProofType)
        }
    }
}
