docker build -t new4303/multi-client:latest -t new4303/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t new4303/multi-server:latest -t new4303/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t new4303/multi-worker:latest -t new4303/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push new4303/multi-client:latest
docker push new4303/multi-server:latest
docker push new4303/multi-worker:latest

docker push new4303/multi-client:$SHA
docker push new4303/multi-server:$SHA
docker push new4303/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=new4303/multi-server:$SHA
kubectl set image deployments/client-deployment client=new4303/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=new4303/multi-worker:$SHA