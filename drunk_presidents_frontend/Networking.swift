import Foundation

enum Route {
    
    case get_FDR
    case get_Lincoln
    case get_Washington
    
    func method() -> String {
        switch self {
        case .get_FDR:
            return "GET"
        case .get_Lincoln:
            return "GET"
        case .get_Washington:
            return "GET"
        }
    }
    
    func path() -> String {
        switch self {
        case .get_Washington:
            return "Washington"
        case .get_FDR:
            return "FDR"
        case .get_Lincoln:
            return "Lincoln"
        }
    }
}

class Network {
    static let instance = Network()

    let baseURL = "https://tweet-generator-tc.herokuapp.com/"
    let session = URLSession.shared

    func fetch(route: Route, completion: @escaping (Data) -> Void) {
        let fullPath = baseURL + route.path()
        let pathURL = URL(string: fullPath)
        var request = URLRequest(url: pathURL!)

        request.httpMethod = route.method()

        session.dataTask(with: request) { (data, resp, err) in
                //                print(String(describing: data) + String(describing: resp) + String(describing: err))
                //                print(String(describing: resp))
            if let data = data {
                completion(data)
            }

            }.resume()
        }
    }

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
            //
        return URL(string: URLString)!
    }
        // This is formatting the query parameters with an ascii table reference therefore we can be returned a json file
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
        /**
         This computed property returns a query parameters string from the given NSDictionary. For
         example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
         string will be @"day=Tuesday&month=January".
         @return The computed parameters string.
         */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}

