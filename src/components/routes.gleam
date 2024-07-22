import gleam/uri.{type Uri}
import lustre/ui
import lustre/effect.{type Effect}
import lustre/element.{type Element, text}
import modem

import lustre/attribute.{class, href, attribute}
import lustre/element/html.{div, button, nav}
import lustre/element/svg
import lustre/event.{on_click}

import views/home.{home}
import views/projects.{projects}
import views/myuse.{myuse}
import components/navbar.{desktop_menu, hamburger_menu}

import components/theme_switcher.{type Theme, Dark, Light}

pub type Model {
  Model(page_content: Route, theme: Theme)
}

pub type Route {
  Home
  Projects
  Blog
  MyUse
}

pub type Msg {
  RouteChanged(Route)
  ToggleTheme(Theme)
}

pub fn init(_flags) -> #(Model, Effect(Msg)) {
  #(
    Model(page_content: Home, theme: Light), // At init we always start at home and dark theme
    modem.init(change_route),
  )
}

pub fn change_route(uri: Uri) -> Msg {
  case uri.path_segments(uri.path) {
    ["projects"] -> RouteChanged(Projects)
    ["blog"] -> RouteChanged(Blog)
    ["myuse"] -> RouteChanged(MyUse)
    _ -> RouteChanged(Home)
  }
}

pub fn toggle_theme(theme: Theme) -> Msg {
  case theme {
    Dark -> ToggleTheme(Light)
    Light -> ToggleTheme(Dark)
  }
}

pub fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    RouteChanged(route) -> {
      let model = Model(..model, page_content: route)
      #(model, effect.none())
    }
    ToggleTheme(theme) -> {
      let model = Model(..model, theme: theme)
      #(model, effect.none())
    }
  }
}

pub fn view(model: Model) -> Element(Msg) {
  let content = case model.page_content {
    Home -> home(model)
    Projects -> projects(model)
    MyUse -> myuse(model)
    _ -> todo as "rest of views"
  }

  let theme_class = case model.theme {
    Dark -> "dark"
    Light -> "light"
  }

  // TODO: Handle the cycle error, and move nav to navbar as it was before
  ui.stack([class(theme_class)], [
    // navbar(model),
    div([class("bg-gray-100 dark:bg-gray-800 flex flex-wrap items-center p-4 sticky top-0 z-50")], [
      nav([class("flex flex-row md:px-8 sm:px-8 justify-between container mx-auto")], [
        // Logo
        html.a(
          [
            class("
              text-gray-600 dark:text-stone-100 font-serif
              text-2xl hover:text-cyan-600 dark:hover:text-stone-50
              transition-colors duration-200 ease-in-out
            "),
            href("/")
          ],
          [
            div([class("w-16 h-16 rounded-full overflow-hidden")],
            [
              html.img([
                class("w-full h-full object-cover"),
                attribute.src("https://avatars.githubusercontent.com/u/84054959?v=4")
              ])
            ]),
          ]
        ),
        div([class("flex items-center lg:order-2 space-x-1 lg:space-x-0 rtl:space-x-reverse")], [
          theme_view(model.theme),
          desktop_menu(),
          hamburger_menu(),
        ]),
      ]),
    ]),
    content
  ])
}

// NOTE: For now theme switcher is goin' to live here
fn theme_view(theme: Theme) -> element.Element(Msg) {
  div([class("text-gray-800 dark:text-stone-100 hover:text-emerald-500 dark:hover:text-emerald-500")], [
    button(
      [
        class("
          inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 dark:text-gray-400
          hover:text-emerald-400 dark:hover:text-emerald-300
          rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-200 dark:focus:ring-gray-600
          transition-colors duration-200 ease-in-out
        "),
        attribute("aria-controls", "navbar-language"),
        attribute("aria-expanded", "false"),
        on_click(toggle_theme(theme))
      ],
      [
        html.svg(
          [
            class("w-6 h-6 fill-current"),
            attribute("aria-hidden", "true"),
            attribute("xmlns", "http://www.w3.org/2000/svg"),
            attribute("fill", "none"),
            attribute("viewBox", "0 0 20 20"),
          ],
          [
            svg.path([
              attribute("fill", "currentColor"),
              attribute("stroke", "currentColor"),
              attribute("stroke-linecap", "round"),
              attribute("stroke-linejoin", "round"),
              attribute("stroke-width", "2"),
              attribute("d", "M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"),
            ]),
          ]
        ),
      ]
    ),
  ])
}
