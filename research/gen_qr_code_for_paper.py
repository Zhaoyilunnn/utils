"""
pip install qrcode
"""
import qrcode
import sys


url = sys.argv[1]
img = qrcode.make(url)
with open("qrcode.png", "wb") as f:
    img.save(f)
