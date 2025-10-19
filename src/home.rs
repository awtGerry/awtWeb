use leptos::prelude::*;

use crate::components::{Profile, ShowcaseProject};
use crate::projects::Project;
use crate::utils::Tech;
use crate::utils::t;

#[component]
pub fn Home(theme: ReadSignal<bool>, lang: ReadSignal<String>) -> impl IntoView {
    let lang_list = Tech::default_tech();
    let projects = Project::create_projects();
    view! {
        <div class="home__container">

            <Profile theme />

             <div class="about__container">
                <h2 class="kodchasan-bold">
                    {move || t("about_title", &lang.get())}
                </h2>
                <p class="geist-regular">
                    {move || t("about_description", &lang.get())}
                </p>
            </div>

            <div class="lang__container">
                {lang_list.iter().map(|x| {
                    let lang_name = x.data().name.to_string();
                    view! {
                        <div class="lang__item">
                            <img
                                class="default"
                                src=move || {
                                    let default_path = String::from(x.data().svg_path.to_string());
                                    let theme_path = if theme.get() == true { "-dark.svg" } else { "-light.svg" };

                                    default_path + theme_path
                                }
                            />
                            <p class="kodchasan-regular">{lang_name}</p>
                        </div>
                    }
                }).collect::<Vec<_>>()}
            </div> // lang__container

            <div class="project__container">
                <div class="project__header">
                    <p class="kodchasan-bold">
                        {move || t("projects_showcase", &lang.get())}
                    </p>
                    <a href="/projects" class="project__all">
                        <p class="kodchasan-bold">
                            {move || t("projects_all", &lang.get())}
                        </p>
                        <svg xmlns="http://www.w3.org/2000/svg"
                            width="18" height="18"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.5"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="feather feather-chevron-right">
                            <polyline points="9 18 15 12 9 6"></polyline>
                        </svg>
                    </a>
                </div>

                <div class="project__items">
                    {projects.iter()
                        .filter(|p| p.showcase)
                        .map(|p| {
                            let project = p.clone();
                            view! {
                                <ShowcaseProject project lang />
                            }
                        }).collect::<Vec<_>>()}
                </div> // project__item

            </div> // project__container
        </div> // home__container
    }
}
