gleam run -m lustre/dev build --minify

# icons
mkdir -p ./priv/static/assets
cp -r ./assets/* ./priv/static/assets/

sed 's|priv/static/awtweb.css|awtweb.min.css|' ./index.html | sed 's|priv/static/awtweb.mjs|awtweb.min.mjs|' > priv/static/index.html
