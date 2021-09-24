import XCTest

extension XCTestCase {
    open override func setUp() {
        super.setUp()
        BaseScreen.app.launch()
        addUIInterruptionMonitor(withDescription: "Allow “CurrentLocation“ to use your location?") { alert -> Bool in
            if alert.label.contains("Allow “CurrentLocation” to use your location?") {
                alert.buttons["Allow While Using App"].tap()
                print("Allert interrupted")
                return true
            }
            return false
        }
    }
}

class CurrentLocationUITests: XCTestCase {

    private let app: XCUIApplication = BaseScreen.app

    func testCurrentLocation() throws {
        Thread.sleep(forTimeInterval: 2)
        app/*@START_MENU_TOKEN@*/.staticTexts["Request location"]/*[[".buttons[\"Request location\"].staticTexts[\"Request location\"]",".buttons[\"requestLocation\"].staticTexts[\"Request location\"]",".staticTexts[\"Request location\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        Thread.sleep(forTimeInterval: 2)
        _ = app.staticTexts["Test me"].waitForExistence(timeout: 20)
        Thread.sleep(forTimeInterval: 2)
        app.staticTexts["Test me"].tap()
        Thread.sleep(forTimeInterval: 2)
        XCTAssertTrue(app.staticTexts["itWorkedLabel"].isEnabled)
        Thread.sleep(forTimeInterval: 2)
        XCTAssertTrue(app.staticTexts["latLongLabel"].label != "")
    }

    func testEmpty() throws {
    }
}

struct BaseScreen {
    private init() {}
    static let app: XCUIApplication = XCUIApplication()
}
