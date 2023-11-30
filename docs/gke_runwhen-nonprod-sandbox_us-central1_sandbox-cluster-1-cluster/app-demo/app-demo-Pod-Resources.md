---
title: "app-demo Pod Resources  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: None'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/kubernetes/resources/labeled/pod.svg" alt="Icon" />
    </td>
  </tr>
</table>
# app-demo Pod Resources    
<div class="author-block">
  <img src="/github_profile_cache/jon-funk_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/jon-funk" target="_blank">
    <h3 class="author-name">jon-funk</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    3 Troubleshooting Commands</p>
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
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-podresources-health/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-podresources-health" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Show Pods Without Resource Limit or Resource Requests Set in Namespace `app-demo`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will list the running pods in a specific namespace on a Kubernetes cluster and output the names of pods and associated containers that do not have resource limits set. Specifically, it uses the kubectl command to get information about the pods from the context and namespace provided. Then, it filters that information so only pods with running status are shown. After that, it looks for any containers within those pods that don't have resource limits set and then only lists the pod name and corresponding container without limits as the output.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl get pods --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n app-demo  --field-selector=status.phase=Running -ojson | jq -r '[.items[] as $pod | ($pod.spec.containers // [][])[] | select(.resources.limits == null) | {pod: $pod.metadata.name, container_without_limits: .name}]'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Get a list of Kubernetes Pods in the context specified
            kubectl get pods \
            --context=${CONTEXT} \
            # Within the namespace specified
            -n ${NAMESPACE} \
            # That include the labels provided
            ${LABELS} \
            # Filter only those that are Running
            --field-selector=status.phase=Running \
            # Format it as JSON output
            -ojson \
            # Use jq to create an array containing names of the selected Pods and the containers
            | jq -r '[.items[] as $pod | ($pod.spec.containers // [][])[] | select(.resources.limits == null) | {pod: $pod.metadata.name, container_without_limits: .name}]'

    ???- abstract "Helpful Links"

            
        - [`kubectl get pods` - get information about Pod objects](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-pods){:target="_blank"}
        - [`--context` parameter for kubectl](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-current-context){:target="_blank"}
        - [`-n/${NAMESPACE}` parameter for kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands/#namespace-1){:target="_blank"}
        - [`${LABELS}` parameter for kubectl](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){:target="_blank"}
        - [`--field-selector` parameter for kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands/#--field-selector=){:target="_blank"}
        - [`-o json` parameter for kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands/#output-short-options){:target="_blank"}
        - [jq - Command-line JSON processor](https://stedolan.github.io/jq/manual/){:target="_blank"}

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




!!! note ""
    <div class="command-title">
    #### Show Pods Without Resource Limit or Resource Requests Set in Namespace `app-demo`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will list the running pods in a specific namespace on a Kubernetes cluster and output the names of pods and associated containers that do not have resource limits set. Specifically, it uses the kubectl command to get information about the pods from the context and namespace provided. Then, it filters that information so only pods with running status are shown. After that, it looks for any containers within those pods that don't have resource limits set and then only lists the pod name and corresponding container without limits as the output.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get pods --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n app-demo  --field-selector=status.phase=Running -ojson | jq -r '[.items[] as $pod | ($pod.spec.containers // [][])[] | select(.resources.requests == null) | {pod: $pod.metadata.name, container_without_requests: .name}]'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Get a list of Kubernetes Pods in the context specified
            kubectl get pods \
            --context=${CONTEXT} \
            # Within the namespace specified
            -n ${NAMESPACE} \
            # That include the labels provided
            ${LABELS} \
            # Filter only those that are Running
            --field-selector=status.phase=Running \
            # Format it as JSON output
            -ojson \
            # Use jq to create an array containing names of the selected Pods and the containers
            | jq -r '[.items[] as $pod | ($pod.spec.containers // [][])[] | select(.resources.limits == null) | {pod: $pod.metadata.name, container_without_limits: .name}]'

    ???- abstract "Helpful Links"

            
        - [`kubectl get pods` - get information about Pod objects](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-pods){:target="_blank"}
        - [`--context` parameter for kubectl](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-current-context){:target="_blank"}
        - [`-n/${NAMESPACE}` parameter for kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands/#namespace-1){:target="_blank"}
        - [`${LABELS}` parameter for kubectl](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){:target="_blank"}
        - [`--field-selector` parameter for kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands/#--field-selector=){:target="_blank"}
        - [`-o json` parameter for kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands/#output-short-options){:target="_blank"}
        - [jq - Command-line JSON processor](https://stedolan.github.io/jq/manual/){:target="_blank"}

<script>

document.getElementById('copyCodeBlock2').addEventListener('click', function() {
    copyCodeBlock2();
});

function copyCodeBlock2() {
  var codeBlock = document.getElementById('codeBlock2');
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
  var copiedMessage = document.getElementById('copiedMessage2');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




!!! note ""
    <div class="command-title">
    #### Get Pod Resource Utilization with Top in Namespace `app-demo`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to check the resource usage of containers running in Kubernetes. It starts by getting a list of all pods with a specific set of LABELS and in a given NAMESPACE which are running on a given CONTEXT, then it iterates through that list and uses the kubectl top command to investigate each pod's resource utilization. The output will provide information about the memory and CPU usage of each container in the pod.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```for pod in $(kubectl get pods  -n app-demo --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o custom-columns=":metadata.name" --field-selector=status.phase=Running); do kubectl top pod $pod -n app-demo --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster --containers; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Get all pods in the specified namespace and context
            POD_LIST=$(kubectl get pods ${LABELS} -n ${NAMESPACE} --context ${CONTEXT} -o custom-columns=":metadata.name" --field-selector=status.phase=Running)

            # Iterate through the retrieved pod list
            for pod in $POD_LIST; do
                
                # For each pod, perform the top command for containers
                kubectl top pod $pod -n ${NAMESPACE} --context ${CONTEXT} --containers; 
            done

    ???- abstract "Helpful Links"

            
        - [Kubernetes official documentation page for kubectl get pods](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get_pods){:target="_blank"}
        - [Kubernetes official documentation page for kubectl top pod](https://kubernetes.io/docs/tasks/debug-application-cluster/resource-usage-monitoring/#determine-the-cpu-and-memory-usage-of-individual-containers){:target="_blank"}

<script>

document.getElementById('copyCodeBlock3').addEventListener('click', function() {
    copyCodeBlock3();
});

function copyCodeBlock3() {
  var codeBlock = document.getElementById('codeBlock3');
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
  var copiedMessage = document.getElementById('copiedMessage3');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/ad-grnwhnnprsndb-pod-resources/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'app-demo Pod Resources  ';
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