import lustre
import views/home.{home}

pub fn main() {
  let home_view = home()
  let app = lustre.element(home_view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
