use leptos::prelude::*;

use crate::components::{LanguagePicker, ThemeSwitcher};
use crate::utils::t;

#[component]
pub fn Navbar(
    theme: ReadSignal<bool>,
    set_theme: WriteSignal<bool>,
    lang: ReadSignal<String>,
    set_lang: WriteSignal<String>,
) -> impl IntoView {
    view! {
        <div class="navbar">
            <div class="navbar__user">
                <p>"AWTGERRY"</p>
            </div>
            <div class="navbar__links">
                <div class="navbar__links__children">
                <a>{move || t("home", &lang.get())}</a>
                <a>{move || t("projects", &lang.get())}</a>
                <LanguagePicker theme set_lang />
                <ThemeSwitcher theme set_theme />
                </div>
            </div>
        </div>
    }
}
