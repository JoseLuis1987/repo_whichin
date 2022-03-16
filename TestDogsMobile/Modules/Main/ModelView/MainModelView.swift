//
//  MainModelView.swift
//  TestDogsMobile
//
//  Created by Jose Luis on 16/03/22.
//

import Foundation
protocol MainModelViewPresenter {
    func didErrorGetDogs(detailError:String)
    func didLoadDogs(dogs: [Dog])
}
final class MainModelView {
    let apiService = APIService()
    var dogs:[Dog]?
    var presenter: MainModelViewPresenter?

    init() {
        
    }
    func saveAllDogs(dogs:[Dog]){
        for  dog in dogs {
            HelperCoreData().saveDog(withDog: dog)
        }
    }
    func getLocalDogsSaved() -> [Dog]{
        return HelperCoreData().gatAllDogs()
    }
    func getAllDogs(){
        apiService.getAllDogs { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let allDogs):
                self?.saveAllDogs(dogs: allDogs)
                strongSelf.presenter?.didLoadDogs(dogs: allDogs)
            case .failure(let error):
                strongSelf.presenter?.didErrorGetDogs(detailError: error.get())
            }
        }
    }
}
