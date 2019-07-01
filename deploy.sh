docker build -t pierrelalanne/multi-client:latest -t pierrelalanne/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pierrelalanne/multi-server:latest -t pierrelalanne/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pierrelalanne/multi-worker:latest -t pierrelalanne/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pierrelalanne/multi-client:latest
docker push pierrelalanne/multi-server:latest
docker push pierrelalanne/multi-worker:latest

docker push pierrelalanne/multi-client:$SHA
docker push pierrelalanne/multi-server:$SHA
docker push pierrelalanne/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pierrelalanne/multi-server:$SHA
kubectl set image deployments/client-deployment client=pierrelalanne/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pierrelalanne/multi-worker:$SHA
