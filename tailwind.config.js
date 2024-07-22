module.exports = {
  content: ["./index.html", "./src/**/*.{gleam,mjs}"],
  darkMode: 'selector',
  theme: {
    extend: {
      fontFamily: {
        serif: ['"Merriweather"', 'serif'],
        code: ['"Fira Code"', 'monospace'],
      },
    },
  },
  plugins: [],
};
