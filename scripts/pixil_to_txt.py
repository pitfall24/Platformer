import sys
import platform
from PIL import Image

def absoluteRepoPath():
    if 'macOS' in platform.platform():
        return '/Users/phineas/Documents/Java/Platformer/'
    else:
        return 'C:/Users/326517/Platformer/Platformer/'

img = Image.open(absoluteRepoPath() + f'resources/images/{sys.argv[1]}.png', 'r')

with open(absoluteRepoPath() + f'resources/textures/sprites/{sys.argv[1] if len(sys.argv) == 2 else sys.argv[2]}.txt', 'w') as f:
    f.write(f'size:{img.width},{img.height};\n')

    for ind, texture in enumerate(['redTexture', 'greenTexture', 'blueTexture', 'alphaTexture']):
        f.write(f'{texture}:\n')
        for i in range(img.height):
            for j in range(img.width):
                f.write(f'{img.getpixel((j, i))[ind]},')
            f.write('\n')
