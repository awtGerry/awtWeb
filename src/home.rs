use leptos::prelude::*;

use crate::components::AvatarIcon;

#[component]
pub fn Home() -> impl IntoView {
    let (icon, set_icon) = signal(false);

    view! {
        <div>
            <div>
                <div>
                    <AvatarIcon />
                    <div>
                        <p>"Victor Rodriguez"</p>
                        <div>
                            // <img>
                            <p>"Guadalajara, Jalisco"</p>
                        </div>
                    </div>
                </div>
                <div>
                </div>
            </div>
        </div>
    }
}
