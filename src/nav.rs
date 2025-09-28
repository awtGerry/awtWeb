use leptos::prelude::*;

use crate::components::ThemeSwitcher;

#[component]
pub fn Navbar(theme: ReadSignal<bool>, set_theme: WriteSignal<bool>) -> impl IntoView {
    view! {
        <div class="navbar">
            <div class="navbar__user">
                <p>"AWTGERRY"</p>
            </div>
            <div class="navbar__links">
                <a>"home"</a>
                <a>"projects"</a>
                <ThemeSwitcher theme set_theme />
            </div>
        </div>
    }
}
