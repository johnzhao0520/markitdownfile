from fastapi import FastAPI, UploadFile, File, Form
from markitdown import MarkItDown
from io import BytesIO

app = FastAPI()
md = MarkItDown()

@app.post("/convert_url")
async def convert_url(url: str = Form(...)):
    res = md.convert(url)
    return {"markdown": res.text_content}

@app.post("/convert_file")
async def convert_file(file: UploadFile = File(...)):
    data = await file.read()
    res = md.convert_stream(BytesIO(data), file_name=file.filename or "input.bin")
    return {"markdown": res.text_content}
