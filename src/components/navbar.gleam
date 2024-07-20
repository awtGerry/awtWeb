import lustre/attribute.{class, href, attribute}
import lustre/element.{text}
import lustre/element/html.{div, button, nav}
import lustre/element/svg

pub fn navbar() -> element.Element(a) {
  div([class("bg-slate-100 dark:bg-gray-800 flex flex-wrap items-center p-4 sticky top-0 z-50")], [
    nav([class("flex flex-row md:px-8 sm:px-8 justify-between mx-auto w-full")], [
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
        toggle_theme(),
        desktop_menu(),
        hamburger_menu(),
      ]),
    ]),
  ])
}

fn hamburger_menu() -> element.Element(a) {
  div([class("text-gray-800 dark:text-stone-100")], [
    button(
      [
        class("inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg lg:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"),
        attribute("aria-controls", "navbar-language"),
        attribute("aria-expanded", "false"),
      ],
      [
        html.svg(
          [
            class("block h-6 w-6 fill-current"),
            attribute("viewBox", "0 0 20 20"),
            attribute("xmlns", "http://www.w3.org/2000/svg"),
          ],
          [
            html.title([], "Mobile menu"),
            svg.path([
              attribute("d", "M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"),
            ]),
          ]
        ),
      ]
    ),
  ])
}

fn desktop_menu() -> element.Element(a) {
  div([class("hidden lg:flex lg:items-center lg:w-auto lg:space-x-6 pl-8")], [
    html.a(
      [
        class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out"),
        href("/"),
      ],
      [text("Home")],
    ),
    html.a(
      [
        class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out"),
        href("/projects"),
      ],
      [text("Projects")],
    ),
    html.a(
      [
        class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out"),
        href("/blog"),
      ],
      [text("Blog")],
    ),
    html.a(
      [
        class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out"),
        href("/myuse"),
      ],
      [text("My use")],
    ),
  ])
}

fn toggle_theme() -> element.Element(a) {
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
