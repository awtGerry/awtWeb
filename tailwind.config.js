module.exports = {
  content: ["./index.html", "./src/**/*.{gleam,mjs}"],
  darkMode: 'class',
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
