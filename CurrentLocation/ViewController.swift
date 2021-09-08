import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    private var locationManager:CLLocationManager?
    private var mapView: MKMapView?
    private let spacer: CGFloat = 50.0

    private let latLngLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemFill
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.accessibilityIdentifier = "latLongLabel"
        return label
    }()

    private let accessRequestedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.text = "Access requested"
        label.tintColor = .green
        label.isHidden = true
        return label
    }()

    private let accessGrantedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.text = "Access granted"
        label.tintColor = .green
        label.accessibilityIdentifier = "accessGrantedLabel"
        label.isHidden = true
        return label
    }()


    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Request location", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 85, y: 500, width: 200, height: 50)
        button.addTarget(self, action: #selector(requestLocationAction), for: .touchUpInside)
        button.accessibilityIdentifier = "requestLocation"
        return button
    }()

    private let testButton: UIButton = {
        let button = UIButton()
        button.setTitle("Test me", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 85, y: 550, width: 200, height: 50)
        button.addTarget(self, action: #selector(didUpdateLocation), for: .touchUpInside)
        button.accessibilityIdentifier = "testButton"
        return button
    }()

    private let itWorkedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26)
        label.text = "It worked"
        label.tintColor = .green
        label.accessibilityIdentifier = "itWorkedLabel"
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MKMapView()
        mapView?.frame = CGRect(x: 10, y: 60, width: view.frame.size.width-20, height: 200)
        mapView?.mapType = MKMapType.standard
        mapView?.isZoomEnabled = true
        mapView?.isScrollEnabled = true
        mapView?.showsUserLocation = true
        view.addSubview(mapView!)

        latLngLabel.frame = CGRect(x: 10, y: view.bounds.height / 2 - 60, width: view.bounds.width - 20, height: 100)
        accessGrantedLabel.frame = CGRect(x: 20, y: view.bounds.height / 2 + 120 + spacer, width: view.bounds.width - 40, height: 100)
        accessRequestedLabel.frame = CGRect(x: 20, y: view.bounds.height / 2 + 60 + spacer, width: view.bounds.width - 40, height: 100)
        itWorkedLabel.frame = CGRect(x: 20, y: 570, width: view.bounds.width - 40, height: 100)
        view.addSubview(latLngLabel)
        view.addSubview(button)
        view.addSubview(accessGrantedLabel)
        view.addSubview(accessRequestedLabel)
        view.addSubview(itWorkedLabel)
        view.addSubview(testButton)
    }

    @objc private func requestLocationAction(_ sender:UIButton!) {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }

    @objc private func didUpdateLocation(_ sender:UIButton!) {
        itWorkedLabel.isHidden = false
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        accessRequestedLabel.isHidden = false
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        accessGrantedLabel.isHidden = false
        latLngLabel.text = "Lat : \(location.coordinate.latitude) \nLng : \(location.coordinate.longitude)"
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView!.setRegion(region, animated: true)
    }
}
