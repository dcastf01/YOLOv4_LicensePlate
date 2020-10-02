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
mkdir backup

git clone https://github.com/dcastf01/OIDv4_ToolKit.git

cd OIDv4_ToolKit/

pip install -r requirements.txt

python main.py downloader --classes 'Vehicle registration plate' --type_csv train --limit 3000 -y
python main.py downloader --classes 'Vehicle registration plate' --type_csv validation --limit 1000 -y

python convert_annotations.py

rm -r OID/Dataset/train/Vehicle registration plate/Label/
rm -r OID/Dataset/validation/Vehicle registration plate/Label/

cd ..
cd darknet
#move dataset out
mkdir data
cp /content/OIDv4_ToolKit/OID/Dataset/train -r /content/darknet/data
cp /content/OIDv4_ToolKit/OID/Dataset/validation -r /content/darknet/data
rm -rf /content/OIDv4_ToolKit


mv /content/darknet/data/train /content/darknet/data/obj
mv /content/darknet/data/validation /content/darknet/data/test






#Set files of configurations
cp /content/YOLOv4_LicensePlate/yolov4/yolov4-obj.cfg ./cfg
cp /content/YOLOv4_LicensePlate/yolov4/obj.names ./data
cp /content/YOLOv4_LicensePlate/yolov4/obj.data  ./data

# upload the generate_train.py and generate_test.py script to cloud VM from Google Drive
cp /content/YOLOv4_LicensePlate/yolov4/generate_train.py ./
cp /content/YOLOv4_LicensePlate/yolov4/generate_test.py ./

#create txt file with path of files to use in  train and test
python generate_train.py
python generate_test.py

wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.conv.137

cd darknet
