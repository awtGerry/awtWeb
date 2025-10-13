use once_cell::sync::Lazy;
use std::collections::HashMap;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Tech {
    C,
    Java,
    Rust,
    TypeScript,
    HTML5,
    CSS,
    Git,
    Linux,
    Svelte,
    Sass,
    Sqlite,
    Lua,
    Nix,
    Bash,
}

#[derive(Debug, Clone, PartialEq)]
pub struct TechData {
    pub name: &'static str,
    pub svg_path: &'static str,
    pub color: &'static str,
}

impl Tech {
    pub fn data(&self) -> &'static TechData {
        match self {
            Tech::C => &TechData {
                name: "C/C++",
                svg_path: "public/icon-c.svg",
                color: "#0000FF",
            },
            Tech::Java => &TechData {
                name: "Java",
                svg_path: "public/icon-java.svg",
                color: "#ED8B00",
            },
            Tech::Rust => &TechData {
                name: "Rust",
                svg_path: "public/icon-rust.svg",
                color: "#EBEFF1",
            },
            Tech::TypeScript => &TechData {
                name: "TypeScript",
                svg_path: "public/icon-typescript.svg",
                color: "#3178C6",
            },
            Tech::HTML5 => &TechData {
                name: "HTML5",
                svg_path: "public/icon-html5.svg",
                color: "#FFA500",
            },
            Tech::CSS => &TechData {
                name: "CSS",
                svg_path: "public/icon-css3.svg",
                color: "#663399",
            },
            Tech::Git => &TechData {
                name: "GIT",
                svg_path: "public/icon-git.svg",
                color: "#F1502F",
            },
            Tech::Linux => &TechData {
                name: "Linux",
                svg_path: "public/icon-linux.svg",
                color: "#F4BC00",
            },
            Tech::Svelte => &TechData {
                name: "Svelte",
                svg_path: "public/icon-svelte.svg",
                color: "#F4BC00",
            },
            Tech::Sass => &TechData {
                name: "Sass",
                svg_path: "public/icon-sass.svg",
                color: "#F4BC00",
            },
            Tech::Sqlite => &TechData {
                name: "SQLite",
                svg_path: "public/icon-sqlite.svg",
                color: "#F4BC00",
            },
            Tech::Lua => &TechData {
                name: "Lua",
                svg_path: "public/icon-lua.svg",
                color: "#F4BC00",
            },
            Tech::Nix => &TechData {
                name: "Nix",
                svg_path: "public/icon-nix.svg",
                color: "#F4BC00",
            },
            Tech::Bash => &TechData {
                name: "Bash",
                svg_path: "public/icon-bash.svg",
                color: "#F4BC00",
            },
        }
    }

    pub fn name(&self) -> &'static str {
        self.data().name
    }

    pub fn svg_path(&self) -> &'static str {
        self.data().svg_path
    }

    pub fn color(&self) -> &'static str {
        self.data().color
    }

    // Get the showcase tech
    pub fn default_tech() -> &'static [Tech] {
        &[
            Tech::C,
            Tech::Java,
            Tech::Rust,
            Tech::TypeScript,
            Tech::HTML5,
            Tech::CSS,
            Tech::Git,
            Tech::Linux,
        ]
    }
}

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
                "home-cfg",
                "https://github.com/awtgerry/home-cfg",
                "home-cfg",
                "public/projects/home_cfg.png",
                "#3D0000",
                vec![Tech::Nix, Tech::Bash, Tech::Lua, Tech::CSS],
                true,
            ),
        ]
    }
}

static TRANSLATIONS: Lazy<HashMap<&'static str, HashMap<&'static str, &'static str>>> = Lazy::new(
    || {
        HashMap::from([
            ("home", HashMap::from([("en", "home"), ("es", "inicio")])),
            (
                "projects",
                HashMap::from([("en", "projects"), ("es", "proyectos")]),
            ),
            (
                "about_title",
                HashMap::from([("en", "About me"), ("es", "Acerca de mi")]),
            ),
            (
                "about_description",
                HashMap::from([
                    (
                        "en",
                        "I'm a software developer from Mexico who loves turning repetitive tasks into automated, effortless solutions. I enjoy building programs that save time, improve workflows, and make everyday challenges simpler.",
                    ),
                    (
                        "es",
                        "Soy un desarrollador de software de México y me encanta convertir tareas repetitivas en soluciones automatizadas y sin esfuerzo. Disfruto crear programas que ahorran tiempo, mejorar flujos de trabajo y hacer que los retos cotidianos sean más simples.",
                    ),
                ]),
            ),
            (
                "projects_showcase",
                HashMap::from([("en", "Recent Projects"), ("es", "Proyectos Recientes")]),
            ),
            (
                "projects_all",
                HashMap::from([("en", "Show All"), ("es", "Mostrar todos")]),
            ),
            (
                "school-roster",
                HashMap::from([
                    (
                        "en",
                        "Desktop application for generating and managing school schedules and teacher lists",
                    ),
                    (
                        "es",
                        "Aplicación de escritorio para generar y gestionar horarios escolares y listas de profesores.",
                    ),
                ]),
            ),
            (
                "home-cfg",
                HashMap::from([
                    (
                        "en",
                        "Reproducible and immutable system configuration, making it easy to set up my environment on any machine.",
                    ),
                    (
                        "es",
                        "Configuración de sistema reproducible e inmutable, facilitando la creación y montaje de un entorno en cualquier máquina.",
                    ),
                ]),
            ),
        ])
    },
);

pub fn t(key: &str, lang: &str) -> &'static str {
    TRANSLATIONS
        .get(key)
        .and_then(|m| m.get(lang))
        .copied()
        .unwrap_or("miss")
}
