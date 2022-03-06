    kubectl version
    # run on master
    docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=master --version 1.23
    ps -ef | grep etcd
    stat -c %U:%G /var/lib/etcd
    useradd etcd
    chown etcd:etcd /var/lib/etcd
    docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=master --version 1.23

    # run on worker
docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=node --version 1.23
