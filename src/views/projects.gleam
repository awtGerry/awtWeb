import lustre/attribute.{class}
import lustre/element.{text}
import lustre/element/html.{div}

pub fn projects(_model) -> element.Element(a) {
  div([class("w-full h-full text-lg")], [
    div([class("p-6 bg-gray-50 dark:bg-gray-900")],
    [
      viewer(),
    ]),
  ])
}

fn viewer() -> element.Element(a) {
  // TODO: Make a markdown viewer for projects
  div([class("flex items-center justify-center align-center")],
  [
    text("HELLO FROM PROJECTS")
  ])
}
