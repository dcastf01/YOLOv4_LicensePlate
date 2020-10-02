import os

image_files = []
os.chdir(os.path.join("data", "test"))
for folder in os.listdir(os.getcwd()):
  os.chdir(os.path.join(str(folder)))
  for filename in os.listdir(os.getcwd()):
      if filename.endswith(".jpg"):
          image_files.append("data/test/" + filename)
  os.chdir("..")
os.chdir("..")
with open("train.txt", "w") as outfile:
    for image in image_files:
        outfile.write(image)
        outfile.write("\n")
    outfile.close()
os.chdir("..")
