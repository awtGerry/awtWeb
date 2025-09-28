use leptos::prelude::*;

#[component]
pub fn ThemeSwitcher(theme: ReadSignal<bool>, set_theme: WriteSignal<bool>) -> impl IntoView {
    view! {
        <button on:click=move |_| {
            set_theme.set(!theme.get())
        }>
            {move || if theme.get() {
                "Dark"
            } else {
                "Light"
            }}
        </button>
    }
}
