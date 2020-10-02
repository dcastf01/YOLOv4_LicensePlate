git clone https://github.com/dcastf01/OIDv4_ToolKit.git

cd OIDv4_ToolKit/

pip install -r requirements.txt

python main.py downloader --classes 'Vehicle registration plate' --type_csv train --limit 10 -y
python main.py downloader --classes 'Vehicle registration plate' --type_csv validation --limit 3 -y

python convert_annotations.py

rm -r OID/Dataset/train/Vehicle registration plate/Label/
rm -r OID/Dataset/validation/Vehicle registration plate/Label/

cd ..

# clone darknet repo
git clone https://github.com/AlexeyAB/darknet
# change makefile to have GPU and OPENCV enabled
cd darknet
sed -i 's/OPENCV=0/OPENCV=1/' Makefile
sed -i 's/GPU=0/GPU=1/' Makefile
sed -i 's/CUDNN=0/CUDNN=1/' Makefile
sed -i 's/CUDNN_HALF=0/CUDNN_HALF=1/' Makefile
# verify CUDA
/usr/local/cuda/bin/nvcc --version
make

cd ..
