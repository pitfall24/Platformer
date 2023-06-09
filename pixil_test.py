from PIL import Image

img = Image.open('C:/Users/326517/Downloads/thorny-bush.png', 'r')

'''
for i in range(img.height):
    for j in range(img.width):
        print(f'({i}, {j}): {img.getpixel((i, j))}')
'''

with open('C:/Users/326517/Platformer/Platformer/resources/textures/sprites/thorny-bush.txt', 'w') as f:
    f.write(f'size:{img.width},{img.height};\n')

    for ind, texture in enumerate([]):
        pass

    f.write('redTexture:\n')
    for i in range(img.height):
        for j in range(img.width):
            f.write(f'{img.getpixel(i, j)[0]},')
        f.write('\n')
