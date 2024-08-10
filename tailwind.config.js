module.exports = {
  content: ["./index.html", "./src/**/*.{gleam,mjs}"],
  darkMode: 'selector',
  theme: {
    extend: {
      fontFamily: {
        serif: ['"Libertinus"', 'serif'],
        // serif: ['"Merriweather"', 'serif'],
        code: ['"Libertinus"', 'sans'],
      },
    },
  },
  plugins: [],
};
