---
title: "argo-cd-argocd-redis Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: argo'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/redis-logo.svg" alt="Icon" />
    </td>
  </tr>
</table>
# argo-cd-argocd-redis Health    
<div class="author-block">
  <img src="/github_profile_cache/jon-funk_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/jon-funk" target="_blank">
    <h3 class="author-name">jon-funk</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    4 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 9 days ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-redis-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-redis-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Ping `argo-cd-argocd-redis` Redis Workload  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to run a redis-cli PING command on a Kubernetes Deployment. The deployment name and namespace are passed in as variables, while the context refers to the cluster from which this particular Kubernetes object is running. This command is useful for verifying that the Redis installation on the Deployment is up and running, which helps ensure that the application running on it is also working properly.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl exec deployment/argo-cd-argocd-redis --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n argo -- redis-cli PING```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Make sure the Kubernetes context and namespace are set correctly for the deployment
            export CONTEXT=${CONTEXT}
            export NAMESPACE=${NAMESPACE}

            # Execute a redis-cli command (ping in this case) against the Kubernetes deployment
            kubectl exec \ 
                deployment/${DEPLOYMENT_NAME} \
                --context=${CONTEXT} \
                -n ${NAMESPACE} \
                -- \
                redis-cli PING

    ???- abstract "Helpful Links"

            
        - [Kubectl Documentation](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands/){:target="_blank"}
        - [Kubectl Exec Documentation](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands/#exec){:target="_blank"}
        - [Official Redis Command Reference](https://redis.io/commands#generic){:target="_blank"}

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
    #### Verify `argo-cd-argocd-redis` Redis Read Write Operation  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows you to execute a command in a Kubernetes deployment. The deployment name is identified by the ${DEPLOYMENT_NAME} variable. This tells Kubernetes which deployment the command should be executed on. You also need to tell Kubernetes which context the command should run in, this is identified with the ${CONTEXT} variable. You can think of a context as a workspace where your commands will be executed. Finally, the last argument, the ${NAMESPACE}, tells Kubernetes in which namespace the command needs to be executed. The Redis healthcheck key will be set to 0 with this command.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl exec deployment/argo-cd-argocd-redis --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n argo -- redis-cli SET runwhen_task_rw_healthcheck 0```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command will run the redis-cli command on a Kubernetes deployment
            KUBECTL_EXEC_COMMAND="kubectl exec"

            # Declare the name of the deployment
            DEPLOYMENT_NAME="deployment/<deploymentName>"

            # Declare the context to use
            CONTEXT="--context=<contextName>"

            # Declare the namespace to deploy into
            NAMESPACE="-n <namespaceName>"

            # The Redis key for the healthcheck
            REDIS_HEALTHCHECK_KEY="<redisKey>"

            # Run the command with all of the input variables
            ${KUBECTL_EXEC_COMMAND} ${DEPLOYMENT_NAME} ${CONTEXT} ${NAMESPACE} -- redis-cli SET ${REDIS_HEALTHCHECK_KEY} 0

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation for the exec command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec){:target="_blank"}
        - [Kubernetes Documentation for contexts](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}
        - [Kubernetes Documentation for namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Redis documentation for the SET command](https://redis.io/commands/set){:target="_blank"}

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
    #### Verify `argo-cd-argocd-redis` Redis Read Write Operation  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows you to execute a command in a Kubernetes deployment. The deployment name is identified by the ${DEPLOYMENT_NAME} variable. This tells Kubernetes which deployment the command should be executed on. You also need to tell Kubernetes which context the command should run in, this is identified with the ${CONTEXT} variable. You can think of a context as a workspace where your commands will be executed. Finally, the last argument, the ${NAMESPACE}, tells Kubernetes in which namespace the command needs to be executed. The Redis healthcheck key will be set to 0 with this command.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```kubectl exec deployment/argo-cd-argocd-redis --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n argo -- redis-cli INCR runwhen_task_rw_healthcheck```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command will run the redis-cli command on a Kubernetes deployment
            KUBECTL_EXEC_COMMAND="kubectl exec"

            # Declare the name of the deployment
            DEPLOYMENT_NAME="deployment/<deploymentName>"

            # Declare the context to use
            CONTEXT="--context=<contextName>"

            # Declare the namespace to deploy into
            NAMESPACE="-n <namespaceName>"

            # The Redis key for the healthcheck
            REDIS_HEALTHCHECK_KEY="<redisKey>"

            # Run the command with all of the input variables
            ${KUBECTL_EXEC_COMMAND} ${DEPLOYMENT_NAME} ${CONTEXT} ${NAMESPACE} -- redis-cli SET ${REDIS_HEALTHCHECK_KEY} 0

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation for the exec command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec){:target="_blank"}
        - [Kubernetes Documentation for contexts](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}
        - [Kubernetes Documentation for namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Redis documentation for the SET command](https://redis.io/commands/set){:target="_blank"}

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




!!! note ""
    <div class="command-title">
    #### Verify `argo-cd-argocd-redis` Redis Read Write Operation  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows you to execute a command in a Kubernetes deployment. The deployment name is identified by the ${DEPLOYMENT_NAME} variable. This tells Kubernetes which deployment the command should be executed on. You also need to tell Kubernetes which context the command should run in, this is identified with the ${CONTEXT} variable. You can think of a context as a workspace where your commands will be executed. Finally, the last argument, the ${NAMESPACE}, tells Kubernetes in which namespace the command needs to be executed. The Redis healthcheck key will be set to 0 with this command.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```kubectl exec deployment/argo-cd-argocd-redis --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n argo -- redis-cli GET runwhen_task_rw_healthcheck```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command will run the redis-cli command on a Kubernetes deployment
            KUBECTL_EXEC_COMMAND="kubectl exec"

            # Declare the name of the deployment
            DEPLOYMENT_NAME="deployment/<deploymentName>"

            # Declare the context to use
            CONTEXT="--context=<contextName>"

            # Declare the namespace to deploy into
            NAMESPACE="-n <namespaceName>"

            # The Redis key for the healthcheck
            REDIS_HEALTHCHECK_KEY="<redisKey>"

            # Run the command with all of the input variables
            ${KUBECTL_EXEC_COMMAND} ${DEPLOYMENT_NAME} ${CONTEXT} ${NAMESPACE} -- redis-cli SET ${REDIS_HEALTHCHECK_KEY} 0

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation for the exec command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec){:target="_blank"}
        - [Kubernetes Documentation for contexts](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}
        - [Kubernetes Documentation for namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Redis documentation for the SET command](https://redis.io/commands/set){:target="_blank"}

<script>

document.getElementById('copyCodeBlock4').addEventListener('click', function() {
    copyCodeBlock4();
});

function copyCodeBlock4() {
  var codeBlock = document.getElementById('codeBlock4');
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
  var copiedMessage = document.getElementById('copiedMessage4');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/arc-ar-grnwh-redis-health/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'argo-cd-argocd-redis Health  ';
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