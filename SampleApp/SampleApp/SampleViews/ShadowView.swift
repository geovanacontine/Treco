//
//  ShadowView.swift
//  SampleApp
//
//  Created by Pedro Contine on 12/03/22.
//

import SwiftUI
import Treco

struct ShadowView: View {
    var body: some View {
        List {
            ShadowTokenView(.level1)
            ShadowTokenView(.level2)
        }
        .navigationTitle("Shadow")
        .listStyle(.plain)
    }
}

struct ShadowTokenView: View {
    
    private let shadow: Shadow
    
    init(_ shadow: Shadow) {
        self.shadow = shadow
    }
    
    var body: some View {
        VStack {
            HStack {
                TrecoText(shadow.rawValue + " radius: (\(shadow.radius)) offset: \(shadow.offset)")
                    .textStyle(.caption)
                Spacer()
            }
            VStack {
                Rectangle()
                    .fill(Color.treco(.neutralDark3))
                    .frame(height: Spacing.lg.value)
                    .addShadow(shadow, color: .neutralDark3)
            }
        }
        .padding()
        .listSectionSeparator(.visible)
        .listRowSeparator(.hidden)
    }
}

struct ShadowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShadowView()
        }
    }
}
