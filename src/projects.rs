use leptos::prelude::*;

use crate::{
    components::ShowcaseProject,
    utils::{Tech, TechData},
};

#[derive(Debug, Clone)]
pub struct Project {
    pub name: String,
    pub url: String,
    pub description_key: String,
    pub image: String, //path
    pub color: String,
    pub languages: Vec<Tech>,
    pub showcase: bool,
}

impl Project {
    pub fn new(
        name: impl Into<String>,
        url: impl Into<String>,
        description_key: impl Into<String>,
        image: impl Into<String>,
        color: impl Into<String>,
        languages: Vec<Tech>,
        showcase: bool,
    ) -> Self {
        Self {
            name: name.into(),
            url: url.into(),
            description_key: description_key.into(),
            image: image.into(),
            color: color.into(),
            languages,
            showcase,
        }
    }

    pub fn language_data(&self) -> Vec<&'static TechData> {
        self.languages.iter().map(|lang| lang.data()).collect()
    }

    pub fn create_projects() -> Vec<Project> {
        vec![
            Project::new(
                "home-cfg",
                "https://github.com/awtgerry/home-cfg",
                "home-cfg",
                "public/projects/home_cfg.png",
                "#3D0000",
                vec![Tech::Nix, Tech::Bash, Tech::Lua, Tech::CSS],
                true,
            ),
            Project::new(
                "School Roster",
                "https://schoolroster.netlify.app/",
                "school-roster",
                "public/projects/school_roster.jpg",
                "#11999E",
                vec![
                    Tech::Svelte,
                    Tech::Rust,
                    Tech::TypeScript,
                    Tech::Sass,
                    Tech::Sqlite,
                ],
                true,
            ),
            Project::new(
                "engine",
                "https://github.com/awtGerry/engine",
                "engine",
                "public/projects/engine.png",
                "#ED3F27",
                vec![Tech::Rust],
                false,
            ),
            Project::new(
                "baseball-da",
                "https://github.com/awtGerry/baseball-da",
                "baseball-da",
                "public/projects/baseball_da.png",
                "#041E42",
                vec![Tech::Python],
                false,
            ),
            Project::new(
                "furry-nvim",
                "https://github.com/awtGerry/furry-nvim",
                "furry-nvim",
                "public/projects/neovim.png",
                "#4C763B",
                vec![Tech::Lua],
                false,
            ),
            Project::new(
                "embedded-iot",
                "https://gitea.com/awtgerry/embedded-iot",
                "embedded-iot",
                "public/projects/iot.jpg",
                "#FFC400",
                vec![Tech::C, Tech::TypeScript, Tech::Python, Tech::AWS],
                false,
            ),
            Project::new(
                "mybar",
                "https://github.com/awtgerry/mybar",
                "mybar",
                "public/projects/bar.png",
                "#C71E64",
                vec![Tech::C, Tech::Rust],
                false,
            ),
            Project::new(
                "k-means",
                "https://github.com/awtGerry/engine/blob/master/examples/k-means.rs",
                "k-means",
                "public/projects/k-means.png",
                "#715A5A",
                vec![Tech::Rust],
                false,
            ),
            Project::new(
                "La Tropicana",
                "https://github.com/ocurrentduke1/LaTropicana",
                "tropicana",
                "public/projects/tropicana.png",
                "#4DFFBE",
                vec![Tech::Java, Tech::Android, Tech::Sqlite],
                false,
            ),
        ]
    }
}

#[component]
pub fn AllProjects(lang: ReadSignal<String>) -> impl IntoView {
    let projects = Project::create_projects();
    view! {
        <div>
            <div class="project__items">
                {projects.iter()
                    .map(|p| {
                        let project = p.clone();
                        view! {
                            <ShowcaseProject project lang />
                        }
                    }).collect::<Vec<_>>()}
            </div> // project__item
        </div>
    }
}
