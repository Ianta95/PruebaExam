//
//  ChartsEntity.swift
//  Prueba Viper
//
//  Created by GSSQ6LXMACD01EX on 03/05/22.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id, currency, symbol, name: String
    let logoURL: String
    let status, platformCurrency, price: String
    let priceDate, priceTimestamp: String
    let circulatingSupply, marketCap, marketCapDominance, numExchanges: String
    let numPairs, numPairsUnmapped: String
    let firstCandle, firstTrade, firstOrderBook: String
    let rank, rankDelta, high: String
    let highTimestamp: String
    let the1D, the30D: Period

    enum CodingKeys: String, CodingKey {
        case id, currency, symbol, name
        case logoURL = "logo_url"
        case status
        case platformCurrency = "platform_currency"
        case price
        case priceDate = "price_date"
        case priceTimestamp = "price_timestamp"
        case circulatingSupply = "circulating_supply"
        case marketCap = "market_cap"
        case marketCapDominance = "market_cap_dominance"
        case numExchanges = "num_exchanges"
        case numPairs = "num_pairs"
        case numPairsUnmapped = "num_pairs_unmapped"
        case firstCandle = "first_candle"
        case firstTrade = "first_trade"
        case firstOrderBook = "first_order_book"
        case rank
        case rankDelta = "rank_delta"
        case high
        case highTimestamp = "high_timestamp"
        case the1D = "1d"
        case the30D = "30d"
    }
}

// MARK: - The1_D
struct Period: Codable {
    let volume, priceChange, priceChangePct, volumeChange: String
    let volumeChangePct, marketCapChange, marketCapChangePct: String

    enum CodingKeys: String, CodingKey {
        case volume
        case priceChange = "price_change"
        case priceChangePct = "price_change_pct"
        case volumeChange = "volume_change"
        case volumeChangePct = "volume_change_pct"
        case marketCapChange = "market_cap_change"
        case marketCapChangePct = "market_cap_change_pct"
    }
}




