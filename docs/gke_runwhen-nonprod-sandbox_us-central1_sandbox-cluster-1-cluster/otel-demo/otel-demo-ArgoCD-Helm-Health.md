---
title: "otel-demo ArgoCD Helm Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: otel-demo'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/argo-icon-color.svg" alt="Icon" />
    </td>
  </tr>
</table>
# otel-demo ArgoCD Helm Health    
<div class="author-block">
  <img src="/github_profile_cache/nmadhok_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/nmadhok" target="_blank">
    <h3 class="author-name">nmadhok</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    2 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 7 weeks ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-argocd-helm-health/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-argocd-helm-health" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Fetch all available ArgoCD Helm releases  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command uses the kubectl command, which is used to manage resources in Kubernetes. It gets a specific resource from the Kubernetes cluster, located in the namespace specified. The specific resource type is provided by the variable RESOURCE_NAME. Then, it specifies the context of the Kubernetes cluster, using the CONTEXT parameter.

    It then outputs the data in JSON format and passes it to the jq tool, which is used to extract specific information from a json file. In this case, it filters the results to only show the names and sync/health status of Helm charts, and outputs the result into a readable format.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl get applications.argoproj.io -n otel-demo --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o=json | jq -r '.items[] | select(.spec.source.helm != null) | "\nName:\t\t\t" + .metadata.name + "\nSync Status:\t\t" + .status.sync.status + "\nHealth Status:\t\t" + .status.health.status'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command is used to get information about a particular Kubernetes resource in a given Namespace and Context. 
            kubectl # Command used to interact with the Kubernetes API (Application Programming Interface)
            get ${RESOURCE_NAME} # The 'get' command will retrieve information about the specified Kubernetes RESOURCE_NAME. 
            -n ${NAMESPACE} # This flag specifies which Namespace to use when querying the Kubernetes Cluster.
            --context ${CONTEXT} # The 'context' flag retrieves the Kubernetes cluster information associated with the specified CONTEXT.

            # The output format (-o) of the response from the Kubernetes cluster will be changed to JSON using the '-o=json' flag.
            |  # This symbol passes the output from the command on the left into the command on the right
            jq -r '.items[] | select(.spec.source.helm != null) | "\nName:\t\t\t" + .metadata.name + "\nSync Status:\t\t" + .status.sync.status + "\nHealth Status:\t\t" + .status.health.status' # jq (short for "JSON Query") is a command line utility that can filter, transform, and reshape JSON data. Flags are used to define how jq should further refine the output returned from the Kubernetes cluster by filtering out only objects (.items[]) that have a 'spec.source.helm' property that does not equal null, and then transforming and formatting the remaining data into a readable string.

    ???- abstract "Helpful Links"

            
        - [Kubectl Documentation](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [JQ Documentation](https://stedolan.github.io/jq/){:target="_blank"}
        - [Helm Documentation](https://v2.helm.sh/docs/){:target="_blank"}

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
    #### Fetch Installed ArgoCD Helm release versions  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will retrieve information about the Helm-managed resource with name ${RESOURCE_NAME} in namespace ${NAMESPACE}, using the context ${CONTEXT}. It will return the Name, Target Revision (the revision which is desired to be achieved), Attempted Revision (the revision that was attempted at last sync operation) and the Sync Status of the resource (if the resource is considered to be out of sync). This information will be provided in json format. Additionally, any appropriate error messages will be returned if the operational state of the resource is not valid.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get applications.argoproj.io -n otel-demo --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o=json | jq -r '.items[] | select(.spec.source.helm != null) | "\nName:\t\t\t" + .metadata.name + "\nTarget Revision:\t" + .spec.source.targetRevision + "\nAttempted Revision:\t" + .status.sync.revision + "\nSync Status:\t\t" + .status.sync.status + "\nOperational State:\t" + .status.operationState.message'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Command to get Helm releases in a particular namespace, context, and output them as custom JSON format
            kubectl get ${RESOURCE_NAME} -n ${NAMESPACE} --context ${CONTEXT} -o=json  # Run 'kubectl get' to get Helm-managed resources in the given namespace and context in a JSON format
            | jq -r '.items[] | select(.spec.source.helm != null) | "\nName:\t\t\t" + .metadata.name + "\nTarget Revision:\t" + .spec.source.targetRevision + "\nAttempted Revision:\t" + .status.sync.revision + "\nSync Status:\t\t" + .status.sync.status + "\nOperational State:\t" + .status.operationState.message'  # Pipe the command into 'jq', to filter out items with a Helm spec, and print out the information for each item in the format specified

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation - kubectl overview](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Kubernetes Reference - Resource Kinds](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/#resource){:target="_blank"}
        - [Kubernetes Concepts - Namespaces](https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/){:target="_blank"}
        - [Kubernetes Docs - Working with Contexts](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-kubeconfig-context){:target="_blank"}
        - [Kubernetes Docs - jq Installation](https://stedolan.github.io/jq/download/){:target="_blank"}
        - [jq Manual - select()](https://stedolan.github.io/jq/manual/#selectselect){:target="_blank"}

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




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/od-od-grnwhnnpr-argocd-helm/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'otel-demo ArgoCD Helm Health  ';
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