import gleam/list
import gleam/int
import lustre/element/svg
import lustre/attribute.{class, attribute}
import lustre/element.{text}
import lustre/element/html.{div, a}

pub type Skills {
  Skill(name: String, per: Int)
}

pub fn home(_model) -> element.Element(a) {
  div([class("w-full text-lg")], [
    div([class("p-6 bg-gray-50 dark:bg-gray-900")],
    [
      hero(),
      divider(),
      // ABOUT ME
      div([class("container mx-auto px-6 py-16")],
      [
        html.h2([class("text-3xl font-bold text-gray-700 dark:text-stone-100")], [text("About Me")]),
        html.p([class("text-gray-700 dark:text-stone-200 pt-4")],
        [
          text("
            First of all I love my father, mother and sisters and
            I thank god every day for having them in my life. They are my pillars and without them
            I wouldn't be the person I am today.
          "),
        ]),
        html.span([class("text-xl flex text-gray-700 dark:text-stone-200 pt-4")], [text("I enjoy:")]),
        html.ul([class("text-gray-700 dark:text-stone-200 pt-4 list-disc text-lg")],
        [
          html.li([], [text("🖥️ Technology")]),
          html.li([], [text("⚽ Sports")]),
          html.li([], [text("🐶 Animals")]),
          html.li([], [text("📚 Books")]),
          html.li([], [text("📺 TV Shows and Movies")]),
        ]),
      ]),
      // SKILLS
      div([class("container mx-auto px-6")],
      [
        html.h2([class("text-3xl font-bold text-gray-700 dark:text-stone-100 mb-6")], [text("Skills")]),
        div([class("relative")], [
          div([class("w-full top-0 left-0 z-10")], [
            div([class("mb-2.5")], [
              html.span([class("text-gray-700 dark:text-stone-300 block mb-2.5 ml-1 font-bold")], [text("Programming Languages")]),
              html.div([class("overflow-hidden")], chart([
                Skill("Rust", 70),
                Skill("Java", 65),
                Skill("C/C++", 60),
                Skill("JS/TS", 55),
                Skill("Python", 30),
              ])),
            ]),
            div([class("")], [
              html.span([class("text-gray-700 dark:text-stone-300 block mb-2.5 ml-1 font-bold")], [text("Backend and Productivity")]),
              html.div([class("overflow-hidden")], chart([
                Skill("Linux", 90),
                Skill("Git + Github", 70),
                Skill("MySQL", 65),
                Skill("Latex", 65),
                Skill("Markdown", 60),
                Skill("Docker", 45),
                Skill("AWS", 30),
              ])),
            ]),
          ]),
        ])
      ]),
    ]),
  ])
}

fn hero() -> element.Element(a) {
  div([class("flex items-center justify-center align-center")],
  [
    div([class("container mx-auto px-6 flex flex-col lg:flex-row relative py-16")],
    [
      mobile_view(),
      // TEXT
      div([class("font-code lg:w-1/2 flex flex-col justify-center items-center lg:items-start")],
      [
        html.h3([class("text-xl font-light text-gray-700 dark:text-stone-300 text-center lg:text-left")], [text("Hi, I am")]),
        html.h1([class("text-4xl font-bold text-gray-700 dark:text-stone-100 pt-2 text-center lg:text-left")], [text("Victor")]),
        html.p([class("text-base text-gray-700 dark:text-stone-200 pt-8 text-center lg:text-left")],
        [
          text("
            I am a 24 year old software engineer based in Jalisco, Mexico.
            I am passionate about technology and I love learning new things.
          "),
        ]),
      ]),
      desktop_view(),
    ]),
  ])
}

fn divider() -> element.Element(a) {
  div([class("container mx-auto px-2")],
  [
    div([class("border-t border-gray-300 dark:border-stone-300 mt-8")], []),
  ])
}

fn create_icon(ref: String, view_box: String, svg_path: String) -> element.Element(a) {
  let css: String = "text-emerald-500 dark:text-emerald-400 hover:text-emerald-600 dark:hover:text-emerald-600 cursor-pointer transform hover:scale-110 transition duration-300"
  a([class(css), attribute.href(ref)], [
    html.svg(
    [
      class("w-8 h-8"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
      attribute("viewBox", view_box),
    ],
    [
      svg.path([
        attribute("fill", "currentColor"),
        attribute("stroke", "currentColor"),
        attribute("d", svg_path)
      ])
    ])
  ])
}

fn mobile_view() -> element.Element(a) {
  // MOBILE IMAGE (TOP OF TEXT)
  div([class("flex flex-col justify-center items-center mb-8 lg:mb-0 lg:hidden")],
  [
    // Image for mobile:
    div([class("w-52 h-52 overflow-hidden rounded-full")],
    [
      html.img([
        class("w-full h-full object-cover"),
        attribute.src("https://pbs.twimg.com/profile_images/1752515582665068544/3UsnVSp5_400x400.jpg")
      ])
    ]),
    // Contact icons:
    div([class("flex justify-center items-center mt-6")],
    [
      div([class("flex space-x-6")],
      [
        // Github icon:
        create_icon("https://github.com/awtGerry", "0 0 496 512", "M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3 .3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5 .3-6.2 2.3zm44.2-1.7c-2.9 .7-4.9 2.6-4.6 4.9 .3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3 .7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3 .3 2.9 2.3 3.9 1.6 1 3.6 .7 4.3-.7 .7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3 .7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3 .7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z"),
        // Twitter icon:
        create_icon("https://x.com/awtGerry", "0 0 512 512", "M459.4 151.7c.3 4.5 .3 9.1 .3 13.6 0 138.7-105.6 298.6-298.6 298.6-59.5 0-114.7-17.2-161.1-47.1 8.4 1 16.6 1.3 25.3 1.3 49.1 0 94.2-16.6 130.3-44.8-46.1-1-84.8-31.2-98.1-72.8 6.5 1 13 1.6 19.8 1.6 9.4 0 18.8-1.3 27.6-3.6-48.1-9.7-84.1-52-84.1-103v-1.3c14 7.8 30.2 12.7 47.4 13.3-28.3-18.8-46.8-51-46.8-87.4 0-19.5 5.2-37.4 14.3-53 51.7 63.7 129.3 105.3 216.4 109.8-1.6-7.8-2.6-15.9-2.6-24 0-57.8 46.8-104.9 104.9-104.9 30.2 0 57.5 12.7 76.7 33.1 23.7-4.5 46.5-13.3 66.6-25.3-7.8 24.4-24.4 44.8-46.1 57.8 21.1-2.3 41.6-8.1 60.4-16.2-14.3 20.8-32.2 39.3-52.6 54.3z"),
        // LinkedIn icon:
        create_icon("https://www.linkedin.com/in/awtgerry/", "0 0 448 512", "M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z"),
        // Email icon:
        create_icon("mailto:awtGerry@gmail.com", "0 0 512 512", "M48 64C21.5 64 0 85.5 0 112c0 15.1 7.1 29.3 19.2 38.4L236.8 313.6c11.4 8.5 27 8.5 38.4 0L492.8 150.4c12.1-9.1 19.2-23.3 19.2-38.4c0-26.5-21.5-48-48-48L48 64zM0 176L0 384c0 35.3 28.7 64 64 64l384 0c35.3 0 64-28.7 64-64l0-208L294.4 339.2c-22.8 17.1-54 17.1-76.8 0L0 176z"),
      ]),
    ]),
  ])
}

fn desktop_view() -> element.Element(a) {
  // DESKTOP IMAGE (RIGHT OF TEXT)
  div([class("flex flex-col justify-center items-center lg:w-1/2 hidden lg:flex")],
  [
    // Image for desktop:
    div([class("w-80 h-80 overflow-hidden")],
    [
      html.img([
        class("w-full h-full object-cover lg:block hidden"),
        attribute.src("https://pbs.twimg.com/profile_images/1752515582665068544/3UsnVSp5_400x400.jpg")
      ])
    ]),
    // Contact icons:
    div([class("flex justify-center items-center mt-4")],
    [
      div([class("flex space-x-6")],
      [
        // Github icon:
        create_icon("https://github.com/awtGerry", "0 0 496 512", "M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3 .3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5 .3-6.2 2.3zm44.2-1.7c-2.9 .7-4.9 2.6-4.6 4.9 .3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3 .7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3 .3 2.9 2.3 3.9 1.6 1 3.6 .7 4.3-.7 .7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3 .7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3 .7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z"),
        // Twitter icon:
        create_icon("https://x.com/awtGerry", "0 0 512 512", "M459.4 151.7c.3 4.5 .3 9.1 .3 13.6 0 138.7-105.6 298.6-298.6 298.6-59.5 0-114.7-17.2-161.1-47.1 8.4 1 16.6 1.3 25.3 1.3 49.1 0 94.2-16.6 130.3-44.8-46.1-1-84.8-31.2-98.1-72.8 6.5 1 13 1.6 19.8 1.6 9.4 0 18.8-1.3 27.6-3.6-48.1-9.7-84.1-52-84.1-103v-1.3c14 7.8 30.2 12.7 47.4 13.3-28.3-18.8-46.8-51-46.8-87.4 0-19.5 5.2-37.4 14.3-53 51.7 63.7 129.3 105.3 216.4 109.8-1.6-7.8-2.6-15.9-2.6-24 0-57.8 46.8-104.9 104.9-104.9 30.2 0 57.5 12.7 76.7 33.1 23.7-4.5 46.5-13.3 66.6-25.3-7.8 24.4-24.4 44.8-46.1 57.8 21.1-2.3 41.6-8.1 60.4-16.2-14.3 20.8-32.2 39.3-52.6 54.3z"),
        // LinkedIn icon:
        create_icon("https://www.linkedin.com/in/awtgerry/", "0 0 448 512", "M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z"),
        // Email icon:
        create_icon("mailto:awtGerry@gmail.com", "0 0 512 512", "M48 64C21.5 64 0 85.5 0 112c0 15.1 7.1 29.3 19.2 38.4L236.8 313.6c11.4 8.5 27 8.5 38.4 0L492.8 150.4c12.1-9.1 19.2-23.3 19.2-38.4c0-26.5-21.5-48-48-48L48 64zM0 176L0 384c0 35.3 28.7 64 64 64l384 0c35.3 0 64-28.7 64-64l0-208L294.4 339.2c-22.8 17.1-54 17.1-76.8 0L0 176z"),
      ]),
    ]),
  ])
}

fn chart(skills: List(Skills)) -> List(element.Element(a)) {
  list.map(skills, fn(skill) {
    div([
      class("h-7 mb-2.5 bg-gradient-to-l from-emerald-400 to-green-500 rounded-r-lg"),
      attribute.style([#("width: " <> int.to_string(skill.per) <> "%;", "")])
    ],
    [
      html.div([class("flex justify-between")], [
        html.span([class("pl-2.5 text-white leading-7")], [text(skill.name)]),
        html.span([class("pr-2.5 text-white leading-7")], [text(int.to_string(skill.per) <> "%")])
      ])
    ])
  })
}
