import os

import logging

from typing import List, Optional, Dict
from enum import Enum

from fastapi import FastAPI, Request, Depends, HTTPException
from fastapi import Body, Path, Query

from fastapi.responses import HTMLResponse
from fastapi.responses import RedirectResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

from app_main       import router as router_main
from app_playground import router as router_playground
from app_barcode    import router as router_barcode
from app_tutorial   import router as router_tutorial

#
app = FastAPI()
app.mount("/static", StaticFiles(directory="static"), name="static")


app.include_router(router_main, prefix="/main")
app.include_router(router_playground, prefix="/playground")
app.include_router(router_tutorial, prefix="/tutorial")
app.include_router(router_barcode, prefix="/barcode")

@app.get('/')
def index():
    print(f"main/index: redirect")
    return RedirectResponse("/main")

#
#
#
def main():
    print(f"Main")


if __name__ == "__main__":
    main()
