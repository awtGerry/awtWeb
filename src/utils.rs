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
    Python,
    AWS,
    Android,
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
                color: "#FF3E00",
            },
            Tech::Sass => &TechData {
                name: "Sass",
                svg_path: "public/icon-sass.svg",
                color: "#EBEFF1",
            },
            Tech::Sqlite => &TechData {
                name: "SQLite",
                svg_path: "public/icon-sqlite.svg",
                color: "#EBEFF1",
            },
            Tech::Lua => &TechData {
                name: "Lua",
                svg_path: "public/icon-lua.svg",
                color: "#EBEFF1",
            },
            Tech::Nix => &TechData {
                name: "Nix",
                svg_path: "public/icon-nix.svg",
                color: "#1B3C53",
            },
            Tech::Bash => &TechData {
                name: "Bash",
                svg_path: "public/icon-bash.svg",
                color: "#EBEFF1",
            },
            Tech::Python => &TechData {
                name: "Python",
                svg_path: "public/icon-python.svg",
                color: "#EBEFF1",
            },
            Tech::AWS => &TechData {
                name: "AWS",
                svg_path: "public/icon-aws.svg",
                color: "#FF3300",
            },
            Tech::Android => &TechData {
                name: "Android Studio",
                svg_path: "public/icon-android.svg",
                color: "#40513B",
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
            (
                "engine",
                HashMap::from([
                    (
                        "en",
                        "2D/3D game engine made with rust to explore computer graphics.",
                    ),
                    (
                        "es",
                        "Motor de juego 2D/3D hecho con rust para explorar graficas por computadora.",
                    ),
                ]),
            ),
            (
                "baseball-da",
                HashMap::from([
                    ("en", "Baseball game analysis with a prediction model."),
                    (
                        "es",
                        "Analisis de encuentros de beisbol con modelo de predicciones.",
                    ),
                ]),
            ),
            (
                "furry-nvim",
                HashMap::from([
                    (
                        "en",
                        "Accessible, fast and easy to run configuration for neovim.",
                    ),
                    (
                        "es",
                        "Configuración accesible, rápida y sencilla de ejecutar para editor neovim.",
                    ),
                ]),
            ),
            (
                "embedded-iot",
                HashMap::from([
                    (
                        "en",
                        "Arduino sensors with AWS conection (server) for a small weather app (client) and a trained model.",
                    ),
                    (
                        "es",
                        "Sensores de Arduino con conexion a AWS (servidor) para una pequeña aplicación meteorológica (cliente) y un modelo entrenado.",
                    ),
                ]),
            ),
            (
                "mybar",
                HashMap::from([
                    ("en", "Status bar for X used by my systems on Linux."),
                    (
                        "es",
                        "Barra de estado para X utilizada en mis sistemas Linux.",
                    ),
                ]),
            ),
            (
                "k-means",
                HashMap::from([
                    (
                        "en",
                        "K-means clustering representation using my rust engine.",
                    ),
                    (
                        "es",
                        "Representacion de agrupamiento K-means usando mi motor hecho con rust.",
                    ),
                ]),
            ),
            (
                "tropicana",
                HashMap::from([
                    (
                        "en",
                        "K-means clustering representation using my rust engine.",
                    ),
                    (
                        "es",
                        "Representacion de agrupamiento K-means usando mi motor hecho con rust.",
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
