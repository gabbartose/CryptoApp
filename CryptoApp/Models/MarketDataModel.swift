//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 05.07.2023..
//

import Foundation
// JSON data:
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON response:
 {
   "data": {
     "active_cryptocurrencies": 9873,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 773,
     "total_market_cap": {
       "btc": 40526346.8931884,
       "eth": 645102698.9355055,
       "ltc": 12015850985.695536,
       "bch": 4716574594.9002695,
       "bnb": 5167768051.379818,
       "eos": 1704734266782.6777,
       "xrp": 2588918435185.941,
       "xlm": 12198914811503.527,
       "link": 195389885159.04663,
       "dot": 236706913895.17694,
       "yfi": 179213108.48094687,
       "usd": 1230996759055.847,
       "aed": 4521488025914.873,
       "ars": 319003214489585.2,
       "aud": 1845863637246.3733,
       "bdt": 133455534620882.44,
       "bhd": 464088240157.5727,
       "bmd": 1230996759055.847,
       "brl": 5971195979152.168,
       "cad": 1634602435450.7258,
       "chf": 1104799895304.4744,
       "clp": 983197111457904.8,
       "cny": 8914509230054.729,
       "czk": 26846844017154.93,
       "dkk": 8413092244175.531,
       "eur": 1129536775177.7053,
       "gbp": 967456355899.8558,
       "hkd": 9630223055737.361,
       "huf": 427107513222706.06,
       "idr": 18534966094220330,
       "ils": 4550453379655.491,
       "inr": 101248438316094.66,
       "jpy": 177784347512082.16,
       "krw": 1600304883838646.2,
       "kwd": 378272994090.27075,
       "lkr": 379038794712085.75,
       "mmk": 2584277853161889,
       "mxn": 20949349044964.17,
       "myr": 5727827919886.859,
       "ngn": 954280997587679.9,
       "nok": 13146256317793.885,
       "nzd": 1988334278152.4587,
       "php": 68229226367429.195,
       "pkr": 340876299809554.94,
       "pln": 5027046084891.537,
       "rub": 111712932495379.48,
       "sar": 4616853344838.94,
       "sek": 13356915562174.352,
       "sgd": 1663645341987.1296,
       "thb": 42956247405633.22,
       "try": 32117431731854.836,
       "twd": 38329299887370.05,
       "uah": 45447898097664.055,
       "vef": 123259705484.26187,
       "vnd": 29243304794989932,
       "zar": 23034312875712.24,
       "xdr": 925227012080.445,
       "xag": 53677970667.690414,
       "xau": 638136409.9269577,
       "bits": 40526346893188.4,
       "sats": 4052634689318840
     },
     "total_volume": {
       "btc": 1278532.7041782578,
       "eth": 20351819.52907117,
       "ltc": 379078294.28184724,
       "bch": 148799369.63402626,
       "bnb": 163033704.43703043,
       "eos": 53781272656.01956,
       "xrp": 81675678702.52739,
       "xlm": 384853625793.0831,
       "link": 6164196316.531632,
       "dot": 7467673598.060164,
       "yfi": 5653848.367192658,
       "usd": 38835713945.26252,
       "aed": 142644742392.36682,
       "ars": 10063972544524.557,
       "aud": 58233648196.63982,
       "bdt": 4210279944947.88,
       "bhd": 14641141828.79187,
       "bmd": 38835713945.26252,
       "brl": 188380397634.284,
       "cad": 51568740640.781715,
       "chf": 34854431894.44988,
       "clp": 31018084728081.17,
       "cny": 281236589677.40765,
       "czk": 846969211667.9332,
       "dkk": 265417793658.93918,
       "eur": 35634835566.180046,
       "gbp": 30521492453.863045,
       "hkd": 303816062122.3219,
       "huf": 13474467000312.334,
       "idr": 584744546177659.1,
       "ils": 143558546741.4999,
       "inr": 3194204500476.693,
       "jpy": 5608773551296.682,
       "krw": 50486715124767.2,
       "kwd": 11933826538.239706,
       "lkr": 11957986158213.623,
       "mmk": 81529276760605.27,
       "mxn": 660913947063.2653,
       "myr": 180702576987.3066,
       "ngn": 30105833807506.855,
       "nok": 414740531242.76465,
       "nzd": 62728338385.808655,
       "php": 2152508281130.115,
       "pkr": 10754028694825.215,
       "pln": 158594181752.54727,
       "rub": 3524340302654.0024,
       "sar": 145653345151.70667,
       "sek": 421386448134.5034,
       "sgd": 52484991639.89227,
       "thb": 1355191655976.9058,
       "try": 1013246689903.1252,
       "twd": 1209219857970.8486,
       "uah": 1433798713887.7988,
       "vef": 3888620037.3391337,
       "vnd": 922573200520367.9,
       "zar": 726690772486.6353,
       "xdr": 29189233286.97081,
       "xag": 1693442568.940219,
       "xau": 20132045.75208455,
       "bits": 1278532704178.2578,
       "sats": 127853270417825.78
     },
     "market_cap_percentage": {
       "btc": 47.92089218202931,
       "eth": 18.652396222722274,
       "usdt": 6.7642110367226245,
       "bnb": 3.016882638813355,
       "usdc": 2.2480211470338367,
       "xrp": 2.022051984073409,
       "steth": 1.173303679524539,
       "ada": 0.814143374982736,
       "doge": 0.7577727871776274,
       "sol": 0.6136994927116161
     },
     "market_cap_change_percentage_24h_usd": -2.1224292741796624,
     "updated_at": 1688561522
   }
 }
 */

// MARK: - MarketDataModel
struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "eur" }) {
            return item.value.formattedWithAbbreviations() + " €"
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "eur" }) {
            return item.value.formattedWithAbbreviations() + " €"
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
