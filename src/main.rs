use leptos::prelude::*;

use awtWeb::components::ThemeSwitcher;
use awtWeb::nav::Navbar;

#[allow(non_snake_case)]
#[component]
fn App() -> impl IntoView {
    let (theme, set_theme) = signal(false); // false = light

    view! {
        <div class="app-container" class:dark=move || theme.get() == true>
            <Navbar theme set_theme />
        </div>
    }
}

fn main() {
    console_error_panic_hook::set_once();
    leptos::mount::mount_to_body(App);
}
