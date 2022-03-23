set -xv
docker build -t krobson/multi-client:latest -t krobson/multi-client:${GIT_SHA} -f ./client/Dockerfile ./client
docker build -t krobson/multi-server:latest -t krobson/multi-server:${GIT_SHA} -f ./server/Dockerfile ./server
docker build -t krobson/multi-worker:latest -t krobson/multi-worker:${GIT_SHA} -f ./worker/DOckerfile ./worker

docker push krobson/multi-client:latest
docker push krobson/multi-server:latest
docker push krobson/multi-worker:latest
docker push krobson/multi-client:${GIT_SHA}
docker push krobson/multi-server:${GIT_SHA}
docker push krobson/multi-worker:${GIT_SHA}

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=krobson/multi-client:${GIT_SHA}
kubectl set image deployments/server-deployment client=krobson/multi-server:${GIT_SHA}
kubectl set image deployments/worker-deployment worker=krobson/multi-worker:${GIT_SHA}