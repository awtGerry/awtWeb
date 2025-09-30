use leptos::prelude::*;

use awtWeb::nav::Navbar;

#[allow(non_snake_case)]
#[component]
fn App() -> impl IntoView {
    let (theme, set_theme) = signal(true); // false = light
    let (lang, set_lang) = signal(String::from("en"));

    view! {
        <div class="app-container" class:dark=move || theme.get() == true>
            <Navbar theme set_theme lang set_lang />
        </div>
    }
}

fn main() {
    console_error_panic_hook::set_once();
    leptos::mount::mount_to_body(App);
}
