import SwiftUI

// Alternate container to avoid duplicate @main app declarations.
// This prevents: Ambiguous implicit access level for import of 'SwiftUI',
// invalid redeclaration of 'GrokTVApp', and ambiguous use of init() from multiple @main entries.
struct GrokTVAppAlternate: View {
    var body: some View {
        ContentView()
            .preferredColorScheme(.dark) // Mimic Grok's dark UI
    }
}

#Preview("GrokTV Alternate") {
    GrokTVAppAlternate()
}
