gleam run -m lustre/dev build --minify

# icons
cp -r ./assets ./priv/static/assets/

# does not work with priv/static removing the priv/static prefix
sed 's|/priv/static/awtweb.css|awtweb.min.css|' ./index.html | sed 's|/priv/static/awtweb.mjs|awtweb.min.mjs|' > priv/static/index.html
