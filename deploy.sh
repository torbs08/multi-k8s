docker build -t torbs08/multi-client:latest -t torbs08/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t torbs08/multi-server:latest -t torbs08/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t torbs08/multi-worker:latest -t torbs08/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push torbs08/multi-client:latest
docker push tobrs08/multi-server:latest
docker push torbs08/multi-worker:latest

docker push torbs08/multi-client:$SHA
docker push tobrs08/multi-server:$SHA
docker push torbs08/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=torbs08/multi-server:$SHA
kubectl set image deployments/client-deployment client=torbs08/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=torbs08/multi-worker:$SHA