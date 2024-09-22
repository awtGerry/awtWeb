gleam run -m lustre/dev -- build app --minify

# icons
mkdir -p ./priv/static/assets
cp -r ./assets/* ./priv/static/assets/

sed 's|priv/static/app.css|app.min.css|' ./index.html | sed 's|priv/static/app.mjs|app.min.mjs|' > priv/static/index.html
