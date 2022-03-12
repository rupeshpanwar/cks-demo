k create ns red
k create ns blue

k -n red create role secret-manager --verb=get --resource=secrets
k -n red create rolebinding secret-manager --role=secret-manager --user=jane
k -n blue create role secret-manager --verb=get --verb=list --resource=secrets
k -n blue create rolebinding secret-manager --role=secret-manager --user=jane


# check permissions
k -n red auth can-i -h
k -n red auth can-i create pods --as jane # no
k -n red auth can-i get secrets --as jane # yes
k -n red auth can-i list secrets --as jane # no

k -n blue auth can-i list secrets --as jane # yes
k -n blue auth can-i get secrets --as jane # yes

k -n default auth can-i get secrets --as jane #no


# Cluster role n binding
k create clusterrole deploy-deleter --verb=delete --resource=deployment

k create clusterrolebinding deploy-deleter --clusterrole=deploy-deleter --user=jane

k -n red create rolebinding deploy-deleter --clusterrole=deploy-deleter --user=jim


# test jane
k auth can-i delete deploy --as jane # yes
k auth can-i delete deploy --as jane -n red # yes
k auth can-i delete deploy --as jane -n blue # yes
k auth can-i delete deploy --as jane -A # yes
k auth can-i create deploy --as jane --all-namespaces # no



# test jim
k auth can-i delete deploy --as jim # no
k auth can-i delete deploy --as jim -A # no
k auth can-i delete deploy --as jim -n red # yes
k auth can-i delete deploy --as jim -n blue # no

