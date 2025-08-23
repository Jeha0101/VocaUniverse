//
//  VocaUniverseApp.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI
import SwiftData

@main
struct VocaUniverseApp: App {
    
    private let modelContainer: ModelContainer = {
        do {
            let container = try ModelContainer(for:
                                                StarModel.self,
                                               WordModel.self
            )
            
            if needBootstrapped() {
                let bootstrapper = DataBootstrapper(context: container.mainContext)
                try bootstrapper.bootstrap()
                setBootstrapSuccess(value: true)
            }

            return container
        } catch {
            setBootstrapSuccess(value: false)
            fatalError("SwiftData 컨테이너 초기화 실패: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
            }
        }
        .modelContainer(modelContainer)
    }
}

extension VocaUniverseApp {
    //부트스트랩이 필요한지 여부 판단
    private static func needBootstrapped() -> Bool {
        let key = "hasBootstrapped"
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: key) {
            return false
        } else {
            return true
        }
    }
    
    //부트스트랩 필요 여부 업데이트
    private static func setBootstrapSuccess(value: Bool) {
        let key = "hasBootstrapped"
        UserDefaults.standard.set(value, forKey: key)
    }
}

