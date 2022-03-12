//
//  ColorsView.swift
//  SampleApp
//
//  Created by Pedro Contine on 05/03/22.
//

import SwiftUI
import Treco

struct ColorsView: View {
    var body: some View {
        List {
            Section(header: TrecoText("Brand")) {
                ColorTokenView(.brandPure)
            }
            Section(header: TrecoText("Light")) {
                ColorTokenView(.neutralLightPure)
            }
            Section(header: TrecoText("Dark")) {
                ColorTokenView(.neutralDarkPure)
                ColorTokenView(.neutralDark2)
                ColorTokenView(.neutralDark3)
            }
            Section(header: TrecoText("Feedback")) {
                ColorTokenView(.feedbackSuccess)
                ColorTokenView(.feedbackError)
                ColorTokenView(.feedbackInfo)
            }
        }
        .navigationTitle("Colors")
        .listStyle(.plain)
    }
}

struct ColorTokenView: View {
    
    private let color: Colors
    
    init(_ color: Colors) {
        self.color = color
    }
    
    var body: some View {
        VStack {
            HStack {
                TrecoText(color.rawValue + " (\(hex()))")
                    .textStyle(.caption)
                Spacer()
            }
            Rectangle()
                .fill(Color.treco(color))
                .frame(height: Spacing.lg.value)
        }
        .listSectionSeparator(.visible)
        .listRowSeparator(.hidden)
    }
    
    private func hex() -> String {
        let uiColor: UIColor = .treco(color)
        return uiColor.toHexString()
    }
}

struct ColorsView_Previews: PreviewProvider {
    static var previews: some View {
        ColorsView()
    }
}
