import gleam/option.{type Option}

import lustre/attribute.{class, href, attribute}
import lustre/element.{text}
import lustre/element/html.{div, button, nav}
import lustre/element/svg
import lustre/event.{on_click}

pub fn desktop_menu() -> element.Element(a) {
  div([class("hidden lg:flex lg:items-center lg:w-auto lg:space-x-6 pl-8")], [
    html.a(
      [
        class("font-serif text-gray-600 dark:text-stone-100 hover:text-emerald-400 dark:hover:text-emerald-300 transition-colors duration-200 ease-in-out"),
        href("/home"),
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
