//
//  LastGameInfoViewModel.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 06.11.23.
//

import Foundation

class LastGameInfoViewModel {
    let model: LastGameInfo

    init(model: LastGameInfo) {
        self.model = model
    }

    func heimLogoURL() -> URL? {
        return URL(string: "\(ApiURL.Constants.imageURL)\(model.letztes.heimLogo)")
    }

    func gastLogoURL() -> URL? {
        return URL(string: "\(ApiURL.Constants.imageURL)\(model.letztes.gastLogo)")
    }
}
