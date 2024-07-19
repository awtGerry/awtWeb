import lustre/attribute.{class}
import lustre/element.{text}
import lustre/element/html.{div}

pub fn home(_model) -> element.Element(a) {
  div([], [
    div([class("p-6 mt-2")],
    [
      hero(),
    ]),
  ])
}

fn hero() -> element.Element(a) {
  div([class("flex items-center justify-center align-center")],
  [
    div([class("container mx-auto px-6 flex flex-col lg:flex-row relative py-16")],
    [
      // MOBILE IMAGE (TOP OF TEXT)
      div([class("flex flex-col justify-center items-center mb-8 lg:mb-0 lg:hidden")],
      [
        // Image for mobile:
        div([class("w-40 h-40 overflow-hidden rounded-full")],
        [
          html.img([
            class("w-full h-full object-cover"),
            attribute.src("https://pbs.twimg.com/profile_images/1752515582665068544/3UsnVSp5_400x400.jpg")
          ])
        ]),
      ]),
      // TEXT
      div([class("font-code lg:w-1/2 flex flex-col justify-center items-center lg:items-start")],
      [
        html.h3([class("text-xl font-light text-gray-700 dark:text-stone-300 text-center lg:text-left")], [text("Hi, I am")]),
        html.h1([class("text-4xl font-bold text-gray-700 dark:text-stone-100 pt-4 text-center lg:text-left")], [text("Victor")]),
        html.p([class("text-base text-gray-700 dark:text-stone-200 pt-2 text-center lg:text-left")],
        [
          text("
            I am a 24 year old software engineer based in Jalisco, Mexico.
            I am passionate about technology and I love learning new things.
          "),
        ]),
      ]),
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
      ]),
    ]),
  ])
}
