import lustre/attribute.{class, href, attribute}
import lustre/element.{text}
import lustre/element/html.{div, button, nav}
import lustre/element/svg

pub fn hamburger_menu() -> element.Element(a) {
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

pub fn desktop_menu() -> element.Element(a) {
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
