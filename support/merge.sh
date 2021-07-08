rootFolder="/Users/Luke/Desktop/Project2021" # !change this to your own path!

rm input/videos.txt
touch input/videos.txt
mkdir -p out

while IFS= read -r line || [ -n "$line" ]; do
    echo "file ${rootFolder}/${line}.mp4" >> input/videos.txt
done < input/input.txt

ffmpeg -f concat -safe 0 -i input/videos.txt -vcodec copy -acodec copy out/result.mp4

ffmpeg -i "out/result.mp4" -i "${rootFolder}/test.wav" \
-filter_complex "[0:a][1:a]amerge=inputs=2[a]" \
-map 0:v -map "[a]" -c:v copy -ac 2 -shortest out/result_bgm.mp4