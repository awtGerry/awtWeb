import gleam/option.{type Option, None, Some}
import gleam/io

import lustre
import lustre/ui
import lustre/effect.{type Effect}
import lustre/element.{type Element, text}
import gleam/uri.{type Uri}
import modem

import lustre/attribute.{class, href, attribute}
import lustre/element/html.{div, button}
import lustre/element/svg
import lustre/event.{on_click}

import views/home.{home}
import views/projects.{projects_view}

import icons

import components/navbar.{desktop_menu}
import components/routes.{type Route, Home, Projects, NotFound}
import components/theme_switcher.{type Theme, Dark, Light}

// INIT THE APP AS A LUSTRE APPLICATION
pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
  Nil
}

pub type Model {
  // page_content contains the current view that is accessed through the navbar
  // mobile_menu is an option that is activated when the hamburger menu is clicked, it uses 1 for clicked and any other value for unclicked
  // theme simply toggles between dark and light theme
  Model(page_content: Route, mobile_menu: Option(Int), theme: Theme)
}

pub type Msg {
  RouteChanged(Route)
  HamburgerClicked(Int)
  ToggleTheme(Theme)
}

pub fn init(_flags) -> #(Model, Effect(Msg)) {
  #(
    Model(
      page_content: Home,
      mobile_menu: None, // Mobile menu is not clicked by default
      theme: Dark, // default theme (TODO: This could be changed to system theme or local storage)
    ),
    modem.init(change_route),
  )
}

pub fn change_route(uri: Uri) -> Msg {
  io.debug(uri)
  case uri.path_segments(uri.path) {
    ["awtWeb"] -> RouteChanged(Home)
    ["awtWeb", "home"] -> RouteChanged(Home)
    ["awtWeb", "projects"] -> RouteChanged(Projects)
    _ -> RouteChanged(NotFound)
  }
}


pub fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    RouteChanged(route) -> {
      let model = Model(..model, page_content: route)
      #(model, effect.none())
    }
    HamburgerClicked(content) -> {
      let model = case content {
        1 -> Model(..model, mobile_menu: Some(content)) // Clicked
        _ -> Model(..model, mobile_menu: None) // Un-clicked
      }
      #(model, effect.none())
    }
    ToggleTheme(theme) -> {
      let model = Model(..model, theme: theme)
      #(model, effect.none())
    }
  }
}

pub fn toggle_theme(theme: Theme) -> Msg {
  case theme {
    Dark -> ToggleTheme(Light)
    Light -> ToggleTheme(Dark)
  }
}

// Function to toggle the hamburger menu
pub fn hamburger_clicked(current_state: Int) -> Msg {
  case current_state {
    1 -> HamburgerClicked(0) // Un-click the hamburger menu
    _ -> HamburgerClicked(1) // Click the hamburger menu
  }
}

pub fn view(model: Model) -> Element(Msg) {
  let content = case model.page_content {
    Home -> home(model)
    Projects -> projects_view(model)
    // Blog -> text("Blog")
    NotFound -> text("404")
  }

  let theme_class = case model.theme {
    Dark -> "dark"
    Light -> "light"
  }

  let blur = case model.mobile_menu {
    Some(1) -> "blur-sm overflow-hidden h-screen transition-all duration-300 ease-in-out"
    _ -> ""
  }

  // PAGE VIEW
  ui.stack([class("w-full h-screen antialiased bg-gray-50 dark:bg-gray-900 " <> theme_class)], [
    // NAVBAR
    navbar(model),
    // PAGE CONTENT
    html.section([class("mt-0 " <> blur)], [content]),
  ])

}

fn navbar(model: Model) -> element.Element(Msg) {
  html.header([class("bg-gray-100 dark:bg-gray-800 flex flex-wrap items-center p-4 sticky top-0 z-50")], [
    html.nav([class("flex flex-row md:px-8 sm:px-8 justify-between container mx-auto")], [
      // Logo
      html.a(
        [
          class("
            text-gray-600 dark:text-stone-100 font-serif
            text-2xl hover:text-cyan-600 dark:hover:text-stone-50
            transition-colors duration-200 ease-in-out
          "),
          href("/awtWeb/home")
        ],
        [
          div([class("w-16 h-16 rounded-full overflow-hidden")],
          [
            html.img([
              class("w-full h-full object-cover"),
              attribute.src("assets/pedri.jpg")
            ])
          ]),
        ]
      ),
      div([class("flex items-center lg:order-2 space-x-1 lg:space-x-0 rtl:space-x-reverse")], [
        theme_view(model.theme),
        hamburger_menu(model.mobile_menu),
        desktop_menu(),
      ]),
    ]),
  ])
}

pub fn hamburger_menu(state: Option(Int)) -> element.Element(Msg) {
  let hamburger_icon = case state {
    Some(1) -> { // Clicked (icon is an x)
      html.svg(
        [ class("w-6 h-6 fill-current"), attribute("aria-hidden", "true"), attribute("xmlns", "http://www.w3.org/2000/svg"), attribute("fill", "none"), attribute("viewBox", icons.xicon.view_box), ],
        [ svg.path([attribute("fill", "currentColor"), attribute("stroke", "currentColor"), attribute("stroke-linecap", "round"), attribute("stroke-linejoin", "round"), attribute("stroke-width", "2"), attribute("d", icons.xicon.path), ]), ]
      )
    }
    _ -> { // Unclicked (icon is a hamburger)
      html.svg(
        [ class("block h-6 w-6 fill-current"), attribute("viewBox", "0 0 20 20"), attribute("xmlns", "http://www.w3.org/2000/svg"), ],
        [ html.title([], "Mobile menu"), svg.path([ attribute("d", "M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"), ]), ]
      )
    }
  }

  let show_menu = case state {
    Some(1) -> {
      // Show the mobile menu
      div(
      [
        class("
          lg:hidden absolute top-0 left-0 mt-24 w-full bg-gray-100 dark:bg-gray-800
          shadow-lg py-4 px-6 transition-transform transform ease-in-out duration-300
        ")
      ],
      [
        div([class("flex flex-col items-center justify-center space-y-6")], [
          html.a(
            [
              class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out py-2 w-full text-center"),
              href("awtWeb/home"),
              on_click(hamburger_clicked(1))
            ],
            [text("Home")],
          ),
          html.a(
            [
              class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out py-2 w-full text-center"),
              href("/awtWeb/projects"),
              on_click(hamburger_clicked(1))
            ],
            [text("Projects")],
          ),
          // html.a(
          //   [
          //     class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out py-2 w-full text-center"),
          //     href("/blog"),
          //     on_click(hamburger_clicked(1))
          //   ],
          //   [text("Blog")],
          // ),
        ])
      ])
    }
    _ -> {
      // Button isn't clicked
      div([class("hidden lg:hidden")], [])
    }
  }

  let state = case state {
    Some(1) -> 1
    _ -> 0
  }

  div([class("text-gray-800 dark:text-stone-100")], [
    button(
      [
        class("inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg lg:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"),
        attribute("aria-controls", "navbar-language"),
        attribute("aria-expanded", "false"),
        on_click(hamburger_clicked(state))
      ],
      [
      hamburger_icon
      ]
    ),
    show_menu
  ])
}


fn theme_view(theme: Theme) -> element.Element(Msg) {
  let theme_icon = case theme {
    Dark -> {
      html.svg(
        [ class("w-6 h-6 fill-current"), attribute("aria-hidden", "true"), attribute("xmlns", "http://www.w3.org/2000/svg"), attribute("fill", "none"), attribute("viewBox", "0 0 384 512"), ],
        [ svg.path([attribute("fill", "currentColor"), attribute("stroke", "currentColor"), attribute("stroke-linecap", "round"), attribute("stroke-linejoin", "round"), attribute("stroke-width", "2"), attribute("d", "M223.5 32C100 32 0 132.3 0 256S100 480 223.5 480c60.6 0 115.5-24.2 155.8-63.4c5-4.9 6.3-12.5 3.1-18.7s-10.1-9.7-17-8.5c-9.8 1.7-19.8 2.6-30.1 2.6c-96.9 0-175.5-78.8-175.5-176c0-65.8 36-123.1 89.3-153.3c6.1-3.5 9.2-10.5 7.7-17.3s-7.3-11.9-14.3-12.5c-6.3-.5-12.6-.8-19-.8z"), ]), ]
      )
    }
    Light -> {
      html.svg(
        [ class("w-6 h-6 fill-current"), attribute("aria-hidden", "true"), attribute("xmlns", "http://www.w3.org/2000/svg"), attribute("fill", "none"), attribute("viewBox", "0 0 512 512"), ],
        [ svg.path([ attribute("fill", "currentColor"), attribute("stroke", "currentColor"), attribute("stroke-linecap", "round"), attribute("stroke-linejoin", "round"), attribute("stroke-width", "2"), attribute("d", "M361.5 1.2c5 2.1 8.6 6.6 9.6 11.9L391 121l107.9 19.8c5.3 1 9.8 4.6 11.9 9.6s1.5 10.7-1.6 15.2L446.9 256l62.3 90.3c3.1 4.5 3.7 10.2 1.6 15.2s-6.6 8.6-11.9 9.6L391 391 371.1 498.9c-1 5.3-4.6 9.8-9.6 11.9s-10.7 1.5-15.2-1.6L256 446.9l-90.3 62.3c-4.5 3.1-10.2 3.7-15.2 1.6s-8.6-6.6-9.6-11.9L121 391 13.1 371.1c-5.3-1-9.8-4.6-11.9-9.6s-1.5-10.7 1.6-15.2L65.1 256 2.8 165.7c-3.1-4.5-3.7-10.2-1.6-15.2s6.6-8.6 11.9-9.6L121 121 140.9 13.1c1-5.3 4.6-9.8 9.6-11.9s10.7-1.5 15.2 1.6L256 65.1 346.3 2.8c4.5-3.1 10.2-3.7 15.2-1.6zM160 256a96 96 0 1 1 192 0 96 96 0 1 1 -192 0zm224 0a128 128 0 1 0 -256 0 128 128 0 1 0 256 0z") ]), ]
      )
    }
  }

  div([class("text-gray-800 dark:text-stone-100 hover:text-emerald-500 dark:hover:text-emerald-500")], [
    button(
      [
        class("
          inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 dark:text-gray-400
          hover:text-emerald-400 dark:hover:text-emerald-300
          rounded-lg focus:outline-none
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
