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
pub fn LanguagePicker(theme: ReadSignal<bool>, set_lang: WriteSignal<String>) -> impl IntoView {
    let (open, set_open) = signal(false);
    let languages = vec![("en", "🇺🇸 English"), ("es", "🇲🇽 Español")];

    view! {
        <div class="language__picker">
            <button class="button__theme language__dropdown" on:click=move |_| set_open.set(!open.get())>
                <Translate theme />
            </button>

            <Show
                when=move || open.get()
                fallback=|| view! { <div></div> }
            >
                <ul class="language__menu">
                    {languages.iter()
                        .map(|(code, label)| {
                            let code = code.to_string();
                            let label = label.to_string();
                            view! {
                                <li
                                    class="dropdown__item"
                                    on:click=move |_| {
                                        set_lang.set(code.to_string());
                                        set_open.set(false);
                                    }
                                >
                                    {label}
                                </li>
                            }
                        })
                        .collect::<Vec<_>>()}
                </ul>
            </Show>
        </div>
    }
}

#[component]
pub fn AvatarIcon() -> impl IntoView {
    view! {
    <div class="avatar">
            <svg class="progress-ring" width="84" height="84">
            <circle
                class="progress-ring-circle"
                stroke="currentColor"
                stroke-width="2"
                fill="transparent"
                r="40"
                cx="42"
                cy="42"
            />
        </svg>
        <img class="default" src="public/img-user.jpg"/>
        <img class="hover" src="public/img-pedri.jpg"/>
    </div>
    }
}
