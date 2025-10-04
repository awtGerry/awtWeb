use once_cell::sync::Lazy;
use std::collections::HashMap;

// pub struct ProgramingLang {
//     pub name: String,
//     pub svg: String,
//     pub color: String,
// }

// pub fn get_lang_list() -> Vec<ProgramingLang> {
//     let list = Vec::from::<ProgramingLang>(
//         {name: "C/C++"},
//     );
// }

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
