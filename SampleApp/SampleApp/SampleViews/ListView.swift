//
//  ListView.swift
//  SampleApp
//
//  Created by Pedro Contine on 05/03/22.
//

import SwiftUI
import Treco

struct ListView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: TrecoText("Tokens")) {
                    NavigationLink(destination: ColorsView()) {
                        TrecoText("Colors")
                    }
                    NavigationLink(destination: FontsView()) {
                        TrecoText("Fonts")
                    }
                    NavigationLink(destination: SpacingView()) {
                        TrecoText("Spacing")
                    }
                    NavigationLink(destination: BorderView()) {
                        TrecoText("Borders")
                    }
                    NavigationLink(destination: OpacityView()) {
                        TrecoText("Opacity")
                    }
                    NavigationLink(destination: ShadowView()) {
                        TrecoText("Shadow")
                    }
                }
            }
            .navigationTitle("Treco Design System")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
