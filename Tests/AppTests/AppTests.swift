@testable import App
import XCTVapor

final class AppTests: XCTestCase {

    fileprivate func checkResponse(_ app: Application, version: String, value be: Bool) throws {

        let headers = HTTPHeaders([
            ("app","tests"),
            ("platform","ios"),
            ("version", version),
        ])

        try app.test(.GET, "api/v1/remote", headers: headers) { res in
            XCTAssertEqual(res.status, .ok)
            do {
                let models = try res.content.decode([Settings.Public].self)
                XCTAssertTrue(!models.isEmpty)
                if let model = models.first {
                    XCTAssertTrue(model.version <= version)
                    XCTAssertTrue(model.key == "test_key")
                    XCTAssertTrue(model.value == be)
                } else {
                    XCTFail("Failed array is empty!")
                }
            } catch {
                XCTFail("Failed to decode response: \(error)")
            }
        }

    }

    func test_01_versions1() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try checkResponse(app, version: "1.0.0", value: false)
    }

    func test_02_versions2() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try checkResponse(app, version: "1.0.3", value: true)
    }

    func test_03_versions3() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try checkResponse(app, version: "1.0.10", value: false)
    }

    func test_04_versions4() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try checkResponse(app, version: "1.1.3", value: true)
    }

}
