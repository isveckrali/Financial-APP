//
//  APIService.swift
//  FinancialApp
//
//  Created by Mehmet Can Seyhan on 2021-05-22.
//

import Foundation
import Combine

struct APIService {
    
    enum APIServiceError: Error {
        case encoding
        case badRequest
    }
    
    var API_KEY: String {
        return keys.randomElement() ?? ""
    }
    
    let keys = ["N483IC64XUG8M4VQ", "HXMUNDJIX81H2UDJ", "6DUG1TOBABY1SOPG"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        
        let result = parseQuery(text: keywords)
        var symbol = String()
        
        switch result {
        case .success(let query):
            symbol = query
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(symbol)&apikey=\(API_KEY)"
        let urlResult = parseURL(urlString: urlString)

        switch urlResult {
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url)
                .map({ $0.data })
                .decode(type: SearchResults.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func fetchTimeSeriesMonthlyAdjustedPublisher(keywords: String) -> AnyPublisher<TimeSeriesMonthlyAdjusted, Error> {
        
        let result = parseQuery(text: keywords)
        var symbol = String()
        
        switch result {
        case .success(let query):
            symbol = query
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(symbol)&apikey=\(API_KEY)"
        let urlResult = parseURL(urlString: urlString)
        
        switch urlResult {
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url)
                .map({ $0.data })
                .decode(type: TimeSeriesMonthlyAdjusted.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    private func parseQuery(text: String) -> Result<String, Error> {
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return .success(query)
        } else {
            return .failure(APIServiceError.encoding)
        }
    }
    
    private func parseURL(urlString: String) -> Result<URL, Error> {
        if let url = URL(string: urlString) {
            return .success(url)
        } else {
            return .failure(APIServiceError.badRequest)
        }
    }
    
}
