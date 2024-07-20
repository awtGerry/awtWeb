import lustre/attribute.{class}
import lustre/element.{text}
import lustre/element/html.{div}

pub fn myuse(_model) -> element.Element(a) {
  div([], [
    div([class("p-6 mt-2")],
    [
      text("HELLO FROM MY USE")
    ]),
  ])
}
