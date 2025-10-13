pub mod components;
pub mod home;
pub mod images;
pub mod nav;
pub mod utils;

use crate::{home::Home, nav::Navbar};
use leptos::prelude::*;

#[allow(non_snake_case)]
#[component]
pub fn App() -> impl IntoView {
    let (theme, set_theme) = signal(true); // false = light
    let (lang, set_lang) = signal(String::from("en"));

    view! {
        <div class="app__wrapper" class:dark=move || theme.get() == true>
            <div class="app__container" class:dark=move || theme.get() == true>
                <Navbar theme set_theme lang set_lang />
                <Home theme lang />
            </div>
        </div>
    }
}
