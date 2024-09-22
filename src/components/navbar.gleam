import lustre/attribute.{class, href}
import lustre/element.{text}
import lustre/element/html.{div}

pub fn desktop_menu() -> element.Element(a) {
  div([class("hidden lg:flex lg:items-center lg:w-auto lg:space-x-6 pl-8")], [
    html.a(
      [
        class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out"),
        href("/awtWeb/home"),
      ],
      [text("Home")],
    ),
    html.a(
      [
        class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out"),
        href("/awtWeb/projects"),
      ],
      [text("Projects")],
    ),
  ])
}
