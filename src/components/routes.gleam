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
    Model(page_content: Home, theme: Dark), // At init we always start at home and dark theme
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
  ui.stack([class("w-full antialiased " <> theme_class)], [
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
          hamburger_menu(),
          desktop_menu(),
        ]),
      ]),
    ]),
    content
  ])
}

// NOTE: For now theme switcher is goin' to live here
fn theme_view(theme: Theme) -> element.Element(Msg) {
  let theme_icon = case theme {
    Dark -> {
      html.svg(
        [
          class("w-6 h-6 fill-current"),
          attribute("aria-hidden", "true"),
          attribute("xmlns", "http://www.w3.org/2000/svg"),
          attribute("fill", "none"),
          attribute("viewBox", "0 0 384 512"),
        ],
        [
          svg.path([
            attribute("fill", "currentColor"),
            attribute("stroke", "currentColor"),
            attribute("stroke-linecap", "round"),
            attribute("stroke-linejoin", "round"),
            attribute("stroke-width", "2"),
            attribute("d", "M223.5 32C100 32 0 132.3 0 256S100 480 223.5 480c60.6 0 115.5-24.2 155.8-63.4c5-4.9 6.3-12.5 3.1-18.7s-10.1-9.7-17-8.5c-9.8 1.7-19.8 2.6-30.1 2.6c-96.9 0-175.5-78.8-175.5-176c0-65.8 36-123.1 89.3-153.3c6.1-3.5 9.2-10.5 7.7-17.3s-7.3-11.9-14.3-12.5c-6.3-.5-12.6-.8-19-.8z"),
          ]),
        ]
      )
    }
    Light -> {
      html.svg(
        [
          class("w-6 h-6 fill-current"),
          attribute("aria-hidden", "true"),
          attribute("xmlns", "http://www.w3.org/2000/svg"),
          attribute("fill", "none"),
          attribute("viewBox", "0 0 512 512"),
        ],
        [
          svg.path([
            attribute("fill", "currentColor"),
            attribute("stroke", "currentColor"),
            attribute("stroke-linecap", "round"),
            attribute("stroke-linejoin", "round"),
            attribute("stroke-width", "2"),
            attribute("d", "M361.5 1.2c5 2.1 8.6 6.6 9.6 11.9L391 121l107.9 19.8c5.3 1 9.8 4.6 11.9 9.6s1.5 10.7-1.6 15.2L446.9 256l62.3 90.3c3.1 4.5 3.7 10.2 1.6 15.2s-6.6 8.6-11.9 9.6L391 391 371.1 498.9c-1 5.3-4.6 9.8-9.6 11.9s-10.7 1.5-15.2-1.6L256 446.9l-90.3 62.3c-4.5 3.1-10.2 3.7-15.2 1.6s-8.6-6.6-9.6-11.9L121 391 13.1 371.1c-5.3-1-9.8-4.6-11.9-9.6s-1.5-10.7 1.6-15.2L65.1 256 2.8 165.7c-3.1-4.5-3.7-10.2-1.6-15.2s6.6-8.6 11.9-9.6L121 121 140.9 13.1c1-5.3 4.6-9.8 9.6-11.9s10.7-1.5 15.2 1.6L256 65.1 346.3 2.8c4.5-3.1 10.2-3.7 15.2-1.6zM160 256a96 96 0 1 1 192 0 96 96 0 1 1 -192 0zm224 0a128 128 0 1 0 -256 0 128 128 0 1 0 256 0z")
          ]),
        ]
      )
    }
  }
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
        theme_icon
      ]
    ),
  ])
}
