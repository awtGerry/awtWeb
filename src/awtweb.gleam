import lustre/ui
import gleam/uri.{type Uri}
import modem
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}

import views/home.{home}
import views/projects.{projects}
import components/navbar.{navbar}

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
}

pub type Model {
  Model(content: Route)
}

pub type Route {
  Home
  Projects
  Blog
  Hardware
}

pub type Msg {
  RouteChanged(Route)
}

fn init(_flags) -> #(Model, Effect(Msg)) {
  #(
    Model(content: Home),
    modem.init(change_route),
  )
}

fn change_route(uri: Uri) -> Msg {
  case uri.path_segments(uri.path) {
    ["projects"] -> RouteChanged(Projects)
    ["blog"] -> RouteChanged(Blog)
    ["hardware"] -> RouteChanged(Hardware)
    _ -> RouteChanged(Home)
  }
}

fn update(_model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    RouteChanged(route) -> #(
      Model(content: route),
      effect.none()
    )
  }
}

fn view(model: Model) -> Element(Msg) {
  let page_content = case model.content {
    Home -> home(model)
    Projects -> projects(model)
    _ -> todo as "rest of views"
  }

  ui.stack([], [navbar(), page_content])
}
