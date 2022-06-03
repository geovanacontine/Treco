//
//  OpacityView.swift
//  SampleApp
//
//  Created by Pedro Contine on 06/03/22.
//

import SwiftUI
import Treco

struct OpacityView: View {
    var body: some View {
        List {
            OpacityTokenView(.none)
            OpacityTokenView(.semiOpaque)
            OpacityTokenView(.intense)
            OpacityTokenView(.medium)
            OpacityTokenView(.light)
        }
        .navigationTitle("Opacity")
        .listStyle(.plain)
    }
}

struct OpacityTokenView: View {
    
    private let opacity: Opacity
    
    init(_ opacity: Opacity) {
        self.opacity = opacity
    }
    
    var body: some View {
        VStack {
            HStack {
                TrecoText(opacity.rawValue + " (\(opacity.value))")
                    .textStyle(.description)
                Spacer()
            }
            Rectangle()
                .fill(Color.treco(.neutralDarkPure))
                .frame(height: Spacing.lg.value)
                .opacity(opacity.value)
        }
        .listSectionSeparator(.visible)
        .listRowSeparator(.hidden)
    }
}

struct OpacityView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OpacityView()
        }
    }
}
