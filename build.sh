gleam run -m lustre/dev build app --minify

cp ./index.html ./priv/static/index.html

sed -i 's/awtweb\.css/awtweb\.min\.css/' ./priv/static/index.html
sed -i 's/awtweb\.mjs/awtweb\.min\.mjs/' ./priv/static/index.html
sed -i 's/\/priv\/static/\./' ./priv/static/index.html
