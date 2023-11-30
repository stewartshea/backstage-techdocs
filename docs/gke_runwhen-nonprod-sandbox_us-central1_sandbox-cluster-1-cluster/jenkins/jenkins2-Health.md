---
title: "jenkins2 Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: jenkins'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/Jenkins_logo.svg" alt="Icon" />
    </td>
  </tr>
</table>
# jenkins2 Health    
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
    Last updated 4 weeks ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-jenkins-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-jenkins-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Query The Jenkins Kubernetes Workload HTTP Endpoint  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to run a curl command on a container that is part of a stateful set in a specified Kubernetes context and namespace. The command will send a request to the container's localhost at port 8080, sending it to the /login resource. The output of the command will be the HTTP status code from the response. This can be useful for verifying that the application is running correctly within the Kubernetes cluster.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl exec statefulset/jenkins2 --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n jenkins -- curl -s -o /dev/null -w "%{http_code}" localhost:8080/login```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Execute a command in a container in a pod of the specified statefulset 
            # Context and namespace are arguments necessary in utilizing the Kubernetes cluster
            kubectl exec statefulset/${STATEFULSET_NAME} \
            --context=${CONTEXT} \
            -n ${NAMESPACE} \
            -- \            # Runs the command after this on the pod/container
            curl -s -o /dev/null \      # This sends an http request (-s silent, -o output)
            -w "%{http_code}" \          # This reads the http response.
            localhost:8080/login         # This is the target endpoint.

    ???- abstract "Helpful Links"

            
        - [kubectl Reference - Executing a Command in a Container](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec){:target="_blank"}
        - [StatefulSet Concepts - Kubernetes](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#definition-of-a-statefulset){:target="_blank"}
        - [Using Contexts](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/){:target="_blank"}
        - [Fundamentals of HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status){:target="_blank"}

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
    #### Query The Jenkins Kubernetes Workload HTTP Endpoint  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to run a curl command on a container that is part of a stateful set in a specified Kubernetes context and namespace. The command will send a request to the container's localhost at port 8080, sending it to the /login resource. The output of the command will be the HTTP status code from the response. This can be useful for verifying that the application is running correctly within the Kubernetes cluster.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl exec statefulset/jenkins2 --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n jenkins -- curl -s localhost:8080/api/json?pretty=true --user ${JENKINS_SA_USERNAME}:${JENKINS_SA_TOKEN}```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Execute a command in a container in a pod of the specified statefulset 
            # Context and namespace are arguments necessary in utilizing the Kubernetes cluster
            kubectl exec statefulset/${STATEFULSET_NAME} \
            --context=${CONTEXT} \
            -n ${NAMESPACE} \
            -- \            # Runs the command after this on the pod/container
            curl -s -o /dev/null \      # This sends an http request (-s silent, -o output)
            -w "%{http_code}" \          # This reads the http response.
            localhost:8080/login         # This is the target endpoint.

    ???- abstract "Helpful Links"

            
        - [kubectl Reference - Executing a Command in a Container](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec){:target="_blank"}
        - [StatefulSet Concepts - Kubernetes](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#definition-of-a-statefulset){:target="_blank"}
        - [Using Contexts](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/){:target="_blank"}
        - [Fundamentals of HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status){:target="_blank"}

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
    #### Query For Stuck Jenkins Jobs  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to identify the cause of stuck or blocked jobs in a Jenkins instance. The command calls the Jenkins API and filters out stuck and/or blocked jobs, displaying the related "why" value as well as their respective statuses - blocked and/or stuck. 

    The command consists of several parts. The kubectl exec component enables the execution of a command within the StatefulSet, identified by its name (${STATEFULSET_NAME}). The --context flag specifies the Kubernetes context for the command's execution and the -n ${NAMESPACE} flag defines the namespace. After that, the command itself comes into play. It uses the curl utility, which connects to the Jenkins API at port 8080 on localhost and uses the ${JENKINS_SA_USERNAME.key} and ${JENKINS_SA_TOKEN.key} environment variables as credentials. Next, the output (in JSON format) is piped through jq - a command-line tool used to filter and parse JSON data - to select only what we need - stuck or blocked jobs and their why values.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```kubectl exec statefulset/jenkins2 --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n jenkins -- curl -s localhost:8080/queue/api/json --user ${JENKINS_SA_USERNAME}:${JENKINS_SA_TOKEN} | jq -r '.items[] | select((.stuck == true) or (.blocked == true)) | "Why: " + .why + "\nBlocked: " + (.blocked|tostring) + "\nStuck: " + (.stuck|tostring)'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Execute a curl command against the api of the specified statefulset to retrieve stuck and blocked tasks
            kubectl exec \
              statefulset/${STATEFULSET_NAME} \
              --context=${CONTEXT} \
              -n ${NAMESPACE} \
              -- curl -s localhost:8080/queue/api/json \
              --user $${JENKINS_SA_USERNAME.key}:$${JENKINS_SA_TOKEN.key} \
            | jq -r '.items[] | select((.stuck == true) or (.blocked == true)) | "Why: " + .why + "\nBlocked: " + (.blocked|tostring) + "\nStuck: " + (.stuck|tostring)'

    ???- abstract "Helpful Links"

            
        - [Learn how to use the kubectl exec command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec){:target="_blank"}
        - [Understand more about statefulsets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){:target="_blank"}
        - [Gain an understanding of contexts in Kubernetes](https://kubernetes.io/docs/tasks/access-application-cluster/authenticate-across-clusters-kubeconfig/){:target="_blank"}
        - [Check out the curl documentation](https://curl.haxx.se/docs/){:target="_blank"}
        - [Get friendly with jq](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/j-j-g-jenkins-health2/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'jenkins2 Health  ';
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