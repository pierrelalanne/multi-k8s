docker build -t plalanneaf/multi-client:latest -t plalanneaf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t plalanneaf/multi-server:latest -t plalanneaf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t plalanneaf/multi-worker:latest -t plalanneaf/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push plalanneaf/multi-client:latest
docker push plalanneaf/multi-server:latest
docker push plalanneaf/multi-worker:latest

docker push plalanneaf/multi-client:$SHA
docker push plalanneaf/multi-server:$SHA
docker push plalanneaf/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=plalanneaf/multi-server:$SHA
kubectl set image deployments/client-deployment client=plalanneaf/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=plalanneaf/multi-worker:$SHA
