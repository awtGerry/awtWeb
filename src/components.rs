use leptos::prelude::*;

use crate::images::{Theme, Translate};

#[component]
pub fn ThemeSwitcher(theme: ReadSignal<bool>, set_theme: WriteSignal<bool>) -> impl IntoView {
    view! {
        <button class="button__theme" on:click=move |_| {
            set_theme.set(!theme.get())
        }>
            <Theme theme />
        </button>
    }
}

#[component]
pub fn LanguagePicker(
    theme: ReadSignal<bool>,
    lang: ReadSignal<String>,
    set_lang: WriteSignal<String>,
) -> impl IntoView {
    view! {
        <div class="language-picker">
            <Translate theme />

            <select
                prop:value=move || lang.get().to_string()
                on:change:target=move |x| {
                    set_lang.set(x.target().value().parse().unwrap());
                }
            >
                <option lang="en" value="en">"🇺🇸 English"</option>
                <option lang="es" value="es">"🇲🇽 Español"</option>
            </select>
        </div>
    }
}
