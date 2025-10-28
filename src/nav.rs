use leptos::prelude::*;
use leptos_router::components::A;

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
        <nav class="navbar">
            <div class="navbar__user">
                <p>"AWTGERRY"</p>
            </div>
            <div class="navbar__links">
                <div class="navbar__links__children">
                    <A href="">{move || t("home", &lang.get())}</A>
                    <A href="projects">{move || t("projects", &lang.get())}</A>
                    <LanguagePicker theme set_lang />
                    <ThemeSwitcher theme set_theme />
                </div>
            </div>
        </nav>
    }
}
