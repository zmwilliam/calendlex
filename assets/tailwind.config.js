module.exports = {
  mode: 'jit',
  purge: [
    './js/**/*.js',
    './css/**/*.css',
    '../lib/*_web/**/*.*ex'
  ],
  darkmode: false,
  theme: { extend: {} },
  variants: { extend: {} },
  plugins: []
}
