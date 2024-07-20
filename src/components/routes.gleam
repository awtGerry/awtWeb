import gleam/uri.{type Uri}
import lustre/ui
import modem
import lustre/effect.{type Effect}
import lustre/element.{type Element}

import views/home.{home}
import views/projects.{projects}
import views/myuse.{myuse}
import components/navbar.{navbar}

pub type Model {
  Model(content: Route)
}

pub type Route {
  Home
  Projects
  Blog
  MyUse
}

pub type Msg {
  RouteChanged(Route)
}

pub fn init(_flags) -> #(Model, Effect(Msg)) {
  #(
    Model(content: Home),
    modem.init(change_route),
  )
}

pub fn change_route(uri: Uri) -> Msg {
  case uri.path_segments(uri.path) {
    ["projects"] -> RouteChanged(Projects)
    ["blog"] -> RouteChanged(Blog)
    ["myuse"] -> RouteChanged(MyUse)
    _ -> RouteChanged(Home)
  }
}

pub fn update(_model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    RouteChanged(route) -> #(
      Model(content: route),
      effect.none()
    )
  }
}

pub fn view(model: Model) -> Element(Msg) {
  let page_content = case model.content {
    Home -> home(model)
    Projects -> projects(model)
    MyUse -> myuse(model)
    _ -> todo as "rest of views"
  }

  ui.stack([], [navbar(), page_content])
}
