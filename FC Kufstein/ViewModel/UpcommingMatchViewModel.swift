//
//  UpcommingMatchViewModel.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 13.11.23.
//

import Foundation

class UpcommingMatchViewModel {
    let model: MetchInfo.KMData
    
    init(model: MetchInfo.KMData) {
        self.model = model
    }
    
    func heimLogoURL() -> URL? {
        return URL(string: "\(ApiURL.Constants.imageURL)\(model.heimLogo ?? "")")
    }
    
    func gastLogoURL() -> URL? {
        return URL(string: "\(ApiURL.Constants.imageURL)\(model.gastLogo ?? "")")
    }
}
