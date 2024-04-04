helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update

kubectl create namespace falco

# changeme need to modify
helm install falco -n falco --set driver.kind=ebpf --set tty=true falcosecurity/falco \
--set falcosidekick.enabled=true \
--set falcosidekick.config.slack.webhookurl=$(base64 --decode <<< "aHR0cHM6Ly9ob29rcy5zbGFjay5jb20vc2VydmljZXMvVDA0QUhTRktMTTgvQjA1SzA3NkgyNlMvV2ZHRGQ5MFFDcENwNnFzNmFKNkV0dEg4") \
--set falcosidekick.config.slack.minimumpriority=notice \
--set falcosidekick.config.customfields="user:yoon"