use once_cell::sync::Lazy;
use std::collections::HashMap;

static TRANSLATIONS: Lazy<HashMap<&'static str, HashMap<&'static str, &'static str>>> =
    Lazy::new(|| {
        HashMap::from([
            ("home", HashMap::from([("en", "home"), ("es", "inicio")])),
            (
                "projects",
                HashMap::from([("en", "projects"), ("es", "proyectos")]),
            ),
        ])
    });

pub fn t(key: &str, lang: &str) -> &'static str {
    TRANSLATIONS
        .get(key)
        .and_then(|m| m.get(lang))
        .copied()
        .unwrap_or("miss")
}
