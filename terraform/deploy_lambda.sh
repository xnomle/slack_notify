rm -rf build
mkdir -p build
cp -r ../app/* build/
pip install -r ../app/requirements.txt -t build/ --upgrade

echo "sleeping zzzz"

sleep 3 

terraform apply --auto-approve