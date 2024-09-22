import lustre/attribute.{class, href}
import lustre/element.{text}
import lustre/element/html.{div}
import gleam/list

import assets/icons

// TODO: Add github badges
// Example for license:
// html.a([href("https://github.com/awtGerry/" <> project.name <> "/blob/main/LICENSE")],
// [
//   html.img([
//     class("w-6 h-6 ml-2"),
//     attribute.src("https://img.shields.io/crates/l/rseip.svg")
//   ])
// ]),

pub type Project {
  Project(name: String, description: String, icon: String, link: String, tech: List(Tech))
}

pub type Tech {
  Tech(name: String, icon: String, bg: String)
}

pub fn projects_view(_model) -> element.Element(a) {
  let projects = [
    Project(
      name: "home-cfg",
      description: "
        Reproducible and immutable home configuration,
        making it easy to set up my environment in any machine.
      ",
      icon: "src/assets/png/dotfiles.png",
      link: "https://github.com/awtGerry/home-cfg",
      tech: [
        Tech(name: "Nix", icon: icons.nixos, bg: "bg-[#7e7eff]"),
      ]
    ),
    Project(
      name: "awtWeb",
      description: "My personal webpage and blog, you are currently on it!",
      icon: "https://avatars.githubusercontent.com/u/84054959?v=4",
      link: "https://github.com/awtGerry/awtWeb",
      tech: [
        Tech(name: "Gleam", icon: icons.gleam, bg: "bg-[#ffaff3]"),
        Tech(name: "Tailwind", icon: icons.tailwindcss, bg: "bg-[#00b4b6]"),
      ]
    ),
    Project(
      name: "School Schedule",
      description: "
        Desktop application to manage school schedules, made with Rust and Tauri.
      ",
      icon: "src/assets/png/school_schedule.png",
      link: "https://github.com/awtGerry/school_schedule",
      tech: [
        Tech(name: "Rust", icon: icons.rustpng, bg: "bg-[#f46623]"),
        Tech(name: "Tauri", icon: icons.tauri, bg: "bg-[#ffc131]"),
        Tech(name: "Svelte", icon: icons.svelte, bg: "bg-[#ff3e00]"),
        Tech(name: "TypeScript", icon: icons.typescript, bg: "bg-[#007acc]"),
        Tech(name: "Sass", icon: icons.sass, bg: "bg-[#cc6699]"),
        Tech(name: "SQLite", icon: icons.sqlite, bg: "bg-[#003b57]"),
      ]
    ),
    Project(
      name: "furry-nvim",
      description: "
        Neovim configuration with a focus on speed and simplicity,
        using Lua and native LSP.
      ",
      icon: "src/assets/png/psyduck.png",
      link: "https://github.com/awtGerry/furry-nvim",
      tech: [
        Tech(name: "Lua", icon: icons.lua, bg: "bg-[#010180]"),
      ]
    ),
    Project(
      name: "engine",
      description: "
        OpenGL engine for 2D graphics.
      ",
      icon: "src/assets/png/pacman.png",
      link: "https://github.com/awtGerry/engine",
      tech: [
        Tech(name: "Rust", icon: icons.rustpng, bg: "bg-[#f46623]"),
      ]
    ),
    Project(
      name: "La Tropicana",
      description: "
        A mobile application for a fictional restaurant, made with Android Studio.
      ",
      icon: "https://raw.githubusercontent.com/ocurrentduke1/LaTropicana/refs/heads/master/app/src/main/res/mipmap-mdpi/ic_launcher_foreground.png",
      link: "https://github.com/ocurrentduke1/LaTropicana",
      tech: [
        Tech(name: "Java", icon: icons.javapng, bg: "bg-[#de0a17]"),
        Tech(name: "Android", icon: icons.android, bg: "bg-[#3ddc84]"),
        Tech(name: "SQLite", icon: icons.sqlite, bg: "bg-[#003b57]"),
      ]
    ),
    Project(
      name: "tudus",
      description: "
        Simple desktop todo list application, made with Rust and Iced.
      ",
      icon: "src/assets/png/checkmark.png",
      link: "https://github.com/awtgerry/tudus",
      tech: [
        Tech(name: "Rust", icon: icons.rustpng, bg: "bg-[#f46623]")
      ]
    ),
    Project(
      name: "crud",
      description: "
        Simple CRUD web application with a REST API and security features.
      ",
      icon: "src/assets/png/padlock.png",
      link: "https://github.com/awtgerry/svelte_crud",
      tech: [
        Tech(name: "Svelte", icon: icons.svelte, bg: "bg-[#ff3e00]"),
        Tech(name: "TypeScript", icon: icons.typescript, bg: "bg-[#007acc]"),
        Tech(name: "CSS", icon: icons.css, bg: "bg-[#00b4b6]"),
        Tech(name: "Node.js", icon: icons.nodejs, bg: "bg-[#8cc84b]"),
        Tech(name: "Express", icon: icons.express, bg: "bg-[#353535]"),
        Tech(name: "SQLite", icon: icons.sqlite, bg: "bg-[#003b57]"),
      ]
    ),
    Project(
      name: "awords",
      description: "
        A web page typing game implementing devops practices, made with Rust and Leptos.
      ",
      icon: "src/assets/png/keyboard.png",
      link: "https://github.com/awtgerry/awords",
      tech: [
        Tech(name: "Rust", icon: icons.rustpng, bg: "bg-[#f46623]"),
        Tech(name: "Docker", icon: icons.dockerpng, bg: "bg-[#00084D]"),
        Tech(name: "Tailwind", icon: icons.tailwindcss, bg: "bg-[#00b4b6]"),
        Tech(name: "Github Actions", icon: icons.github, bg: "bg-[#181717]"),
        Tech(name: "Google Cloud", icon: icons.gcloud, bg: "bg-[#4285F4]"),
        Tech(name: "MySQL", icon: icons.mysql, bg: "bg-[#005E86]"),
      ]
    ),
  ]

  div([class("w-full h-full text-lg")], [
    div([class("p-6 bg-gray-50 dark:bg-gray-900")],
    [
      div([class("p-6 bg-gray-50 dark:bg-gray-900")], project_view(projects)),
    ]),
  ])
}

fn project_view(projects: List(Project)) -> List(element.Element(a)) {
  list.map(projects, fn(project) {
    let img_css = case project.name {
      "School Schedule" -> "w-24 h-20"
      "tudus" -> "w-24 h-24"
      _ -> "w-24 h-24"
    }
    div([class("flex flex-col lg:flex-row items-center justify-center align-center mb-4 lg:mb-8")],
    [
      // Image (on top in mobile, left in desktop)
      div([class("border-2 p-2 rounded object-cover object-center border-emerald-700 dark:border-emerald-300")],
      [
        html.img([
          class("rounded " <> img_css),
          attribute.src(project.icon)
        ])
      ]),
      // Description view: clickable link to the project
      html.a(
      [
        class("
          flex flex-col justify-between lg:items-start
          shadow-2xl rounded p-8 w-full lg:w-1/2 mt-6 lg:mt-0 lg:ml-12
          bg-gray-50 dark:bg-gray-800 text-gray-800 dark:text-gray-200
          text-xs lg:text-lg
          group 
        "),
        href(project.link)
      ],
      [
        // Left section: Title and description
        div([class("flex flex-col justify-center items-center lg:items-start")], [
          // Project title
          html.h1(
            [class("text-2xl bold font-serif")],
            [
              div(
              [
                class("transition duration-300 text-emerald-600")
              ],
              [
                // Project name
                text(project.name),
                // Hover effect
                html.span(
                  [class("block max-w-0 group-hover:max-w-full transition-all duration-500 h-0.5 bg-emerald-600")],
                  []
                ),
              ]),
            ]
          ),
          // Project description
          html.span([class("mt-2 text-base lg:text-lg")], [text(project.description)]),
        ]),
        
        // Right section: Tech stack images
        div([class("flex flex-wrap mt-4 lg:mt-6 items-start gap-y-2 gap-x-2 w-full")],
          list.map(project.tech, fn(tech) {
            // TODO: Change this to a better and automated way
            // Improve looks in tailwind
            let css = case tech.name {
              "Tailwind" -> "w-4 h-2.5"
              "Rust" -> "w-6 h-4"
              "Docker" -> "w-5 h-4"
              _ -> "w-4 h-4"
            }
            div([class("relative flex flex-row px-2 py-1 gap-x-2 rounded-lg items-center " <> tech.bg <> " bg-opacity-60 dark:bg-opacity-50")],
            [
              // Pseudo-element for film grain
              div([class("absolute inset-0 bg-noise opacity-10 pointer-events-none rounded-lg")], []),

              // Tech icon
              html.img([
                class(css),
                attribute.src(tech.icon)
              ]),
              
              // Tech name
              html.span([class("z-10")], [text(tech.name)])
            ])
          }),
        )
      ])
    ])
  })
}
