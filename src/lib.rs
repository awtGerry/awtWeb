pub mod components;
pub mod home;
pub mod images;
pub mod nav;
pub mod projects;
pub mod utils;

use crate::projects::AllProjects;
use crate::{home::Home, nav::Navbar};
use leptos::prelude::*;
use leptos_router::components::*;
use leptos_router::path;

#[allow(non_snake_case)]
#[component]
pub fn App() -> impl IntoView {
    let (theme, set_theme) = signal(true); // false = light
    let (lang, set_lang) = signal(String::from("en"));

    view! {
        <Router base="/awtWeb">
            <div class="app__wrapper" class:dark=move || theme.get() == true>
                <div class="app__container" class:dark=move || theme.get() == true>
                    <Navbar theme set_theme lang set_lang />
                    <Routes fallback=|| "404: Page not found">
                        <Route
                            path=path!("/")
                            view=move || view! {
                                <Home theme=theme lang=lang />
                            }
                        />
                        <Route
                            path=path!("/projects")
                            view=move || view! {
                                <AllProjects lang=lang />
                            }
                        />
                    </Routes>
                </div>
            </div>
        </Router>
    }
}
