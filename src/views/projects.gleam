import lustre/attribute.{class}
import lustre/element.{text}
import lustre/element/html.{div}

pub fn projects(_model) -> element.Element(a) {
  div([], [
    div([class("p-6 mt-2")],
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
