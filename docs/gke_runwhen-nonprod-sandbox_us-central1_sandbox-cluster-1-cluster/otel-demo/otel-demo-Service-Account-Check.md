---
title: "otel-demo Service Account Check  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: otel-demo'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/kubernetes/resources/labeled/sa.svg" alt="Icon" />
    </td>
  </tr>
</table>
# otel-demo Service Account Check    
<div class="author-block">
  <img src="/github_profile_cache/stewartshea_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/stewartshea" target="_blank">
    <h3 class="author-name">stewartshea</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    1 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 8 days ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-serviceaccount-check/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-serviceaccount-check" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Test Service Account Access to Kubernetes API Server in Namespace `otel-demo`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to run a "curl-pod" in Kubernetes using the kubectl run command. It creates a pod with an image called "curlimages/curl:latest", which contains the curl tool, and sets the ServiceAccountName to "$serviceaccount". A Kubernetes API call is then made by getting a token and executing the curl command. Finally, the curl-pod is deleted. This command enables engineers to quickly make an API call to the Kubernetes API from within the cluster, using the curl tool.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```apiserver=https://kubernetes.default.svc; namespace=otel-demo; context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster; resource=""; serviceaccount=default; kubectl run curl-pod --image=curlimages/curl:latest --restart=Never --overrides="{ \"spec\": { \"serviceAccountName\": \"$serviceaccount\" } }" -n $namespace --context=$context --command -- sleep infinity && echo "Waiting for the curl-pod to be running..." && kubectl wait --for=condition=Ready pod/curl-pod --timeout=20s -n $namespace --context=$context && TOKEN=$(kubectl exec curl-pod -n $namespace --context=$context -- cat /var/run/secrets/kubernetes.io/serviceaccount/token) && echo "Performing a curl request to the Kubernetes API..." && kubectl exec curl-pod -n $namespace --context=$context -- curl -s -k -H "Authorization: Bearer $TOKEN" $apiserver$resource && echo "Cleaning up..." && kubectl delete pod curl-pod -n $namespace --context=$context && echo "Done"```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Construct a Kubernetes command to run a single curl-pod in the specified namespace and context
            NAMESPACE=${NAMESPACE}
            CONTEXT=${CONTEXT}
            SERVICE_ACCOUNT=${SERVICE_ACCOUNT}
            APISERVER=https://kubernetes.default.svc

            # First, create the pod with the given parameters and set it to never restart.
            kubectl run curl-pod \
              --image=curlimages/curl:latest \
              --restart=Never \
              --overrides="{ \"spec\": { \"serviceAccountName\": \"$SERVICE_ACCOUNT\" } }" \
              -n $NAMESPACE \
              --context=$CONTEXT

            echo "Waiting for the curl-pod to be running..."

            # Wait until the pod is running
            kubectl wait --for=condition=Ready pod/curl-pod --timeout=20s -n $NAMESPACE --context=$CONTEXT

            # Get the token from the service account associated with the pod
            TOKEN=$(kubectl exec curl-pod -n $NAMESPACE --context=$CONTEXT -- cat /var/run/secrets/kubernetes.io/serviceaccount/token)

            echo "Performing a curl request to the Kubernetes API..."

            # Perform a curl request to the Kubernetes API.
            kubectl exec curl-pod -n $NAMESPACE --context=$CONTEXT -- curl -s -k -H "Authorization: Bearer $TOKEN" $APISERVER$RESOURCE

            echo "Cleaning up..."

            # Clean up by deleting the pod.
            kubectl delete pod curl-pod -n $NAMESPACE --context=$CONTEXT

            echo "Done"

    ???- abstract "Helpful Links"

            
        - [Kubernetes Official Documentation Online: Concepts](https://kubernetes.io/docs/concepts/){:target="_blank"}
        - [Kubernetes Official Documentation Online: api-resources](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/){:target="_blank"}
        - [Kubernetes Official Documentation Online: Service Accounts](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/){:target="_blank"}
        - [Kubernetes Official Documentation Online: kubectl run](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run){:target="_blank"}
        - [Kubernetes Official Documentation Online: kubectl wait](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#wait){:target="_blank"}
        - [Kubernetes Official Documentation Online: kubectl exec](https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/){:target="_blank"}
        - [Kubernetes Official Documentation Online: kubectl delete pod](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#delete_pod){:target="_blank"}

<script>

document.getElementById('copyCodeBlock1').addEventListener('click', function() {
    copyCodeBlock1();
});

function copyCodeBlock1() {
  var codeBlock = document.getElementById('codeBlock1');
  var text = codeBlock.textContent;

  navigator.clipboard.writeText(text)
    .then(() => {
      console.log('Code block copied to clipboard:', text);
      showCopiedMessage();
    })
    .catch((error) => {
      console.error('Error copying code block to clipboard:', error);
    });
}

function showCopiedMessage() {
  var copiedMessage = document.getElementById('copiedMessage1');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/otl-dm-grnwhnnprsndbucntrl-sa-check/runbook.yaml');
});

function showConfig(runbook) {
    const popupContainer = document.createElement("div"); // Container for the popup
    const popup = document.createElement("div");
    popup.classList.add("popup");

    const loadingMessage = document.createElement("h1");
    loadingMessage.innerText = "Please wait...";

    popup.appendChild(loadingMessage);
    popupContainer.appendChild(popup); // Append the popup to the container
    document.body.appendChild(popupContainer); // Append the container to the document body

    fetch('/get-runbook-config', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            runbook: runbook,
        }) 
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            popup.removeChild(loadingMessage);

            const closeButton = document.createElement("span");
            closeButton.classList.add("close");
            closeButton.innerHTML = "&times;";
            closeButton.style.fontSize = "24px"; // Increase the font size for better visibility
            closeButton.style.position = "absolute";
            closeButton.style.top = "10px";
            closeButton.style.right = "10px";

            const title = document.createElement("p");
            title.innerText = "Private configuration for: " + 'otel-demo Service Account Check  ';
            const configPath = document.createElement("p");
            configPath.innerText = "Local filesystem path: /shared/output/" + runbook;

            const image = document.createElement("img");
            image.src = "https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg";
            image.alt = "Icon";

            const codeBlock = document.createElement("pre");
            codeBlock.classList.add("code-block");
            codeBlock.innerText = data;

            popup.appendChild(closeButton);
            popup.appendChild(image); // Append the image to the popup
            popup.appendChild(title);
            popup.appendChild(configPath);
            popup.appendChild(codeBlock);
        })
        .catch(error => {
            console.error('Error:', error);
            alert(error);
        });

    // Event delegation for close button click
    popupContainer.addEventListener("click", (event) => {
        const target = event.target;
        if (target.classList.contains("close")) {
            event.stopPropagation(); // Stop event propagation
            document.body.removeChild(popupContainer); // Remove the container instead of the popup
        }
    });
}

</script>
<style>
  .multiline {
    white-space: pre-wrap;
    word-wrap: break-word;
  }
.popup .code-block {
    background-color: #333;
    color: #f8f8f8;
    padding: 10px;
    font-family: Consolas, Monaco, 'Andale Mono', monospace;
    font-size: 14px;
    line-height: 1.4;
    overflow: auto;
}


</style>



---