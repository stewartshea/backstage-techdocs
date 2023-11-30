---
title: "Loki Stack Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: loki'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/grafana-loki.svg" alt="Icon" />
    </td>
  </tr>
</table>
# Loki Stack Health    
<div class="author-block">
  <img src="/github_profile_cache/jon-funk_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/jon-funk" target="_blank">
    <h3 class="author-name">jon-funk</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    2 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 3 weeks ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-loki-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-loki-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Check Loki Ring API  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to check the status of a single binary application on Kubernetes. Specifically, this command gets the name of the pod (which holds the single-binary application) within a given namespace and context, then executes an query against that pod to get its status and lastly, it will extracting information about any shards that are not in an active state. This helps you understand how the application is performing so you can troubleshoot any issues and take appropriate actions.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n loki exec $(kubectl --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n loki get pods -l app.kubernetes.io/component=single-binary -o=jsonpath='{.items[0].metadata.name}') -- wget -q --header="Accept: application/json" -O - http://localhost:3100/ring | jq -r '.shards[] | select(.state != "ACTIVE") | {name: .id, state: .state}'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command retrieves information about shards from an application running on Kubernetes.
            # We will break it down into two separate components: getting the information and then parsing it.

            # First, we need to get information about a pod in the cluster:
            POD_ID=$(kubectl --context=${CONTEXT} -n ${NAMESPACE} get pods \
                -l app.kubernetes.io/component=single-binary \
                -o=jsonpath='{.items[0].metadata.name}')

            # Next, using that Pod ID, we can get data from the application in that pod:
            DATA=$(kubectl --context=${CONTEXT} -n ${NAMESPACE} exec $POD_ID \
                -- wget -q --header="Accept: application/json" -O - http://localhost:3100/ring)

            # Finally, we will parse that data using jq to get the required information:
            RESULT=$(echo "$DATA" | jq -r '.shards[] | select(.state != "ACTIVE") | {name: .id, state: .state}')

            echo "$RESULT"

    ???- abstract "Helpful Links"

            
        - [Kubernetes: kubectl Overview](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [JSONPath in kubectl](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}
        - [jq Manual](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    #### Check Loki API Ready  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows you to access a Kubernetes pod running in a specific namespace with a certain label. It first identifies the pod's name based on the context and namespace using the “get” command, then it “executes” the command which performs a “wget” HTTP request to retrieve data from the pod’s localhost port 3100 address. This command is useful when checking the readiness of an application or debugging problems within your Kubernetes environment.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n loki exec $(kubectl --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n loki get pods -l app.kubernetes.io/component=single-binary -o=jsonpath='{.items[0].metadata.name}') -- wget -q --header="Accept: application/json" -O - http://localhost:3100/ready```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command connects to one of the pods in a specified Kubernetes namespace, which contains an application, and fetches readiness information by connecting to the app's "ready" endpoint. 

            # Setting up context and namespace variables
            CONTEXT="<specify context>"
            NAMESPACE="<specify namespace>"

            # Get the pod name of the instances with an app component label of single-binary
            POD_NAME=$(kubectl --context=${CONTEXT} -n ${NAMESPACE} get pods -l app.kubernetes.io/component=single-binary -o=jsonpath='{.items[0].metadata.name}')

            # Execute a command on the specified pod to fetch readiness information from the "ready" endpoint
            kubectl --context=${CONTEXT} -n ${NAMESPACE} exec ${POD_NAME} -- wget -q --header="Accept: application/json" -O - http://localhost:3100/ready

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation — kubectl command reference](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Create a Context — Kubernetes Clusters documentation](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}
        - [jsonpath Expression Reference Guide — Kubernetes official documentation](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}
        - [Annotations Pod — Kubernetes Components documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations#pod-annotations){:target="_blank"}
        - [How to Use Labels — Kubernetes official documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/lk-lk-grnwhnnpr-loki-hlthck/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'Loki Stack Health  ';
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