# Docker for Deep Learning

## Installation

### 1. Docker install

```
sudo apt install docker.io
```

### 2. NVIDIA Container Toolkit install

#### Configure the production repository:
```
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```
#### Update the packages list from the repository:
```
sudo apt-get update
```
#### Install the NVIDIA Container Toolkit packages:
```
sudo apt-get install -y nvidia-container-toolkit
```
#### Change permissions for Docker socket:
```
sudo chmod 666 /var/run/docker.sock
```
### Restart Docker
```
sudo systemctl restart docker
```

## 도커 이미지 다운받기
```
docker pull $YOUR_DOCKER_IMAGE
```

* 통합된 파이토치 딥러닝 환경: https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch
* 위의 링크의 tag 페이지에서 image 다운

## 도커 이미지 리스트 확인
```
docker images
```
## 도커 이미지 삭제
```
docker rmi $YOUR_DOCKER_IMAGE
```

## 도커 컨테이너 생성

```
docker run \
    -itd \
    --gpus all \
    --name $YOUR_CONTAINER_NAME \
    -v /path/data:/app/data \
    -p 44746:22 \
    -p 8501:8051 \
    $YOUR_DOCKER_IMAGE \
    /bin/bash \
```

-p 옵션은 포트로, 서로 겹치지 않게 설정

-v 옵션은 :을 기준으로 왼쪽은 호스트의 파일경로, 오른쪽은 컨테이너안에서 마운트될 경로를 의미함  
예를들어 다음과 같이 작성될 수 있음

```
-v /home/milab/workspace/NeRF:/workspace/NeRF
```
컨테이너 안의 /workspace/NeRF 경로로 마운트됨

성공적으로 컨테이너가 생성될 경우, 다음과 같이 컨테이너의 고유ID가 출력됨
```
6a23b1e513402af7aa54efd9bf11f3f41c01f052b05b058dbd84fa2783eb8b77
```
## 도커 컨테이너 들어가기
```
docker exec -it $YOUR_CONTAINER_NAME bash
```

## 도커 컨테이너 나가기
순차적으로 Ctrl+p Ctrl+q 수행

## 실행 중인 컨테이너 확인

```
docker ps 
```

## 컨테이너 삭제

```
docker kill $YOUR_CONTAINER_NAME
docker rm $YOUR_CONTAINER_NAME
```

## Dockerfile 빌드

필수적인 패키지 설치를 위해 제공된 Dockerfile을 사용할 수 있음

```
docker build -t $YOUR-REPOSITORY-NAME:$YOUR-IMAGE-NAME .
```
제공된 Dockerfile은 cuda11.8 이미지, python3.10을 기준으로 작성되었음, 따라서 필요에 따라 변형에서 사용가능함

