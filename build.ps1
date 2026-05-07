$NAME = "kubebox"

uv sync
uv run python -m PyInstaller --onefile --clean `
    --name $NAME `
    --add-data "streamlit_app.py;." `
    --add-data "core;core" `
    --collect-all streamlit `
    --collect-all networkx `
    --collect-all pyvis `
    --copy-metadata streamlit `
    --copy-metadata pyarrow `
    --hidden-import streamlit.web.bootstrap `
    main.py
