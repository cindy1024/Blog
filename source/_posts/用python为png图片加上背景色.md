---
title: 用python为png图片加上背景色
date: 2018-07-28 16:43:19
tags: ['python', 'png']
categories: 工具
---



# 安装Pillow库

ImportError: No module named PIL 错误 的解决方法：

```
pip install Pillow
```



# 代码

```python
from PIL import Image as Image
im = Image.open('cropped-1920-1080-744835.png') 
x,y = im.size 
try: 
    p = Image.new('RGB', im.size, (178, 235, 242)) #创建背景色图像
    p.paste(im, (0, 0, x, y), im) #将原图粘贴到背景图像上
    p.save('out-cropped-1920-1080-744835.png') 
except: 
    pass 
```

## **PIL.Image.new(*mode*, *size*, *color=0*)**

Creates a new image with the given mode and size.

**mode**

- `1` (1-bit pixels, black and white, stored with one pixel per byte)
- `L` (8-bit pixels, black and white)
- `P` (8-bit pixels, mapped to any other mode using a color palette)
- `RGB` (3x8-bit pixels, true color)
- `RGBA` (4x8-bit pixels, true color with transparency mask)
- `CMYK` (4x8-bit pixels, color separation)
- `YCbCr` (3x8-bit pixels, color video format)

  - Note that this refers to the JPEG, and not the ITU-R BT.2020, standard
- `LAB` (3x8-bit pixels, the L*a*b color space)
- `HSV` (3x8-bit pixels, Hue, Saturation, Value color space)
- `I` (32-bit signed integer pixels)
- `F` (32-bit floating point pixels)


## Image.paste(*im*, *box=None*, *mask=None*)**

**Parameters:**

- **im** – Source image or pixel value (integer or tuple).

- **box** – An optional 4-tuple giving the region to paste into. If a 2-tuple is used instead, it’s treated as the upper left corner. If omitted or None, the source is pasted into the upper left corner.

  If an image is given as the second argument and there is no third, the box defaults to (0, 0), and the second argument is interpreted as a mask image.

  四元组：左上右下

- **mask** – An optional mask image.

# 引用

[python通过pil为png图片填充上背景颜色](http://outofmemory.cn/code-snippet/7453/python-through-pil-png-tupian-fill-background-color)

[Image Module | Pillow](https://pillow.readthedocs.io/en/latest/reference/Image.html)