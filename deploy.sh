set -xv
docker build -t thesleepingbarber/multi-client:latest -t thesleepingbarber/multi-client:${GIT_SHA} -f ./client/Dockerfile ./client
docker build -t thesleepingbarber/multi-server:latest -t thesleepingbarber/multi-server:${GIT_SHA} -f ./server/Dockerfile ./server
docker build -t thesleepingbarber/multi-worker:latest -t thesleepingbarber/multi-worker:${GIT_SHA} -f ./worker/DOckerfile ./worker

docker push thesleepingbarber/multi-client:latest
docker push thesleepingbarber/multi-server:latest
docker push thesleepingbarber/multi-worker:latest
docker push thesleepingbarber/multi-client:${GIT_SHA}
docker push thesleepingbarber/multi-server:${GIT_SHA}
docker push thesleepingbarber/multi-worker:${GIT_SHA}

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=thesleepingbarber/multi-client:${GIT_SHA}
kubectl set image deployments/server-deployment server=thesleepingbarber/multi-server:${GIT_SHA}
kubectl set image deployments/worker-deployment worker=thesleepingbarber/multi-worker:${GIT_SHA}