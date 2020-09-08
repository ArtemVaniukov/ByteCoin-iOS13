//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didReceiveRate(_: CoinData)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "PUT_HERE_YOUR_OWN_KEY"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) {
        let urlString = baseURL + "/\(currency)?apikey=\(apiKey)"
        performRequest(wtih: urlString)
    }
    
    func performRequest(wtih urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                }
                
                if let data = data {
                    if let rate = self.parseJSON(from: data) {
                        self.delegate?.didReceiveRate(rate)
                    }
                }
            }.resume()
        }
    }
    
    func parseJSON(from data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let coinData = try decoder.decode(CoinData.self, from: data)
            return coinData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
