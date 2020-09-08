//
//  CryptoCurrency.swift
//  ByteCoin
//
//  Created by Artem Vaniukov on 07.09.2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let rate: Double
    let asset_id_quote: String
}
