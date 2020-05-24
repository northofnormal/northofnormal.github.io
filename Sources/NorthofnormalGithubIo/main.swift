import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct NonDotDev: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case bio
        case talks
        case code
        case cheers
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "💻 🍸 North of Normal 🍸 💻"
    var description = ""
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try NonDotDev().publish(using: [
    .addMarkdownFiles(),
    .copyResources(),
    .addDefaultSectionTitles(),
    .generateHTML(withTheme: .anneTheme),
    .generateSiteMap(),
    .deploy(using: .gitHub("northofnormal/northofnormal.github.io", useSSH: false))
])


extension PublishingStep where Site == NonDotDev {
    static func addDefaultSectionTitles() -> Self {
        .step(named: "Default section titles") { context in
            context.mutateAllSections { section in
                
                switch section.id {
                case .bio:
                    section.title = "About Me"
                case .talks:
                    section.title = "Conference Talks"
                case .code:
                    section.title = "Thinking About Code"
                case .cheers:
                    section.title = "Cheers!"
                }
            }
        }
    }
}
