import lustre/attribute.{class}
import lustre/element.{text}
import lustre/element/html.{div, button}

pub fn home() -> element.Element(a) {
    div([], [
        html.h1([class("text-4xl mb-12 text-red-500")], [text("Hello, World!")]), 
        button(
            [
                class(
                    "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                ),
            ],
            [
                text("Button")
            ]
        )
    ])
}
