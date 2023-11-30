---
title: "trouble-town SSL Certificate Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: trouble-town'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/cert-manager.svg" alt="Icon" />
    </td>
  </tr>
</table>
# trouble-town SSL Certificate Health    
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
    Last updated 34 hours ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-certmanager-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-certmanager-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Get Namespace Certificate Summary for Namespace `trouble-town`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command uses the kubectl command line tool to list all of the certificates in the given context and namespace. It then filters these certificates to only include those with a status of "Ready" and that will expire before a given date. Once it has filtered the certificates, it will print out their details including the namespace they reside in, the domain name(s), when they will need to be renewed, and when they will expire.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl get certificates.cert-manager.io --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n trouble-town -ojson | jq -r --arg now "$(date +%Y-%m-%dT%H:%M:%SZ)" '.items[] | select(.status.conditions[] | select(.type == "Ready" and .status == "True")) | select(.status.renewalTime) | select((.status.notAfter | strptime("%Y-%m-%dT%H:%M:%SZ") | mktime) <= ($now | strptime("%Y-%m-%dT%H:%M:%SZ") | mktime)) | "Namespace:" + .metadata.namespace + " URL:" + .spec.dnsNames[0] + " Renews:" + .status.renewalTime + " Expires:" + .status.notAfter'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command is used to list cert-manager certificates (i.e., certificates requested and managed using cert-manager) in a Kubernetes cluster.
            # The --context option sets the specific cluster context that will be used to list the certificates
            CONTEXT="${CONTEXT}"

            # The -n option sets the namespace in which the certificate are being requested
            NAMESPACE="${NAMESPACE}"

            # Get all the Certificates in JSON format from the specified namespace
            CERTIFICATES_JSON=$(kubectl get certificates.cert-manager.io --context=${CONTEXT} -n ${NAMESPACE} -ojson)

            # Use jq to filter the output and select the right values for our needs
            RESULT=$(echo "${CERTIFICATES_JSON}" | jq -r --arg now "$(date +%Y-%m-%dT%H:%M:%SZ)" '.items[] | select(.status.conditions[] | select(.type == "Ready" and .status == "True")) | select(.status.renewalTime) | select((.status.notAfter | strptime("%Y-%m-%dT%H:%M:%SZ") | mktime) <= ($now | strptime("%Y-%m-%dT%H:%M:%SZ") | mktime)) | "Namespace:" + .metadata.namespace + " URL:" + .spec.dnsNames[0] + " Renews:" + .status.renewalTime + " Expires:" + .status.notAfter')

            # Echo the final result
            echo "${RESULT}"

    ???- abstract "Helpful Links"

            
        - [Kubectl reference page](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Cert-manager reference page](https://docs.cert-manager.io/en/latest/){:target="_blank"}
        - [date command reference page](https://linux.die.net/man/1/date){:target="_blank"}
        - [jq reference page](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    #### Find Failed Certificate Requests and Identify Issues for Namespace `trouble-town`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to display all certificate requests associated with a specific issuer in Kubernetes. It uses the kubectl command to get certificaterequests associated with the context, namespace, and .json file, and then uses the jq tool to filter those results according to precise criteria, such as type, status, and message content. The output of the command will return detailed information about each certificate request, including the name, associated certificate, issuer reference, readiness and approval statuses, and any additional messages related to that status.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get certificaterequests.cert-manager.io --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n trouble-town -o json | jq -r '.items[] | select(.status.conditions[] | select(.type == "Ready" and .status != "True")) | {certRequest: .metadata.name, certificate: (.metadata.ownerReferences[].name), issuer: .spec.issuerRef.name, readyStatus: (.status.conditions[] | select(.type == "Ready")).status, readyMessage: (.status.conditions[] | select(.type == "Ready")).message, approvedStatus: (.status.conditions[] | select(.type == "Approved")).status, approvedMessage: (.status.conditions[] | select(.type == "Approved")).message} | "\nCertificateRequest: \(.certRequest)", "Certificate: \(.certificate)", "Issuer: \(.issuer)", "Ready Status: \(.readyStatus)", "Ready Message: \(.readyMessage)", "Approved Status: \(.approvedStatus)", "Approved Message: \(.approvedMessage)\n------------"'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command will print out a list of all CertificateRequests related to
            # Cert-Manager in the given context and namespace, as well as their associated
            # owners, issuers, and any statuses. 
            kubectl get certificaterequests.cert-manager.io \
                --context=${CONTEXT} \                 # The kubernetes context where this operation will happen
                -n ${NAMESPACE} \                      # The namespace within that context 
                -o json | jq -r '.items[] |            # Use the output from kubectl, pass it through jq 
                                   select(.status.conditions[] | 
                                          select(.type == "Ready" and .status != "True")) | 
                                   {certRequest: .metadata.name, 
                                    certificate: (.metadata.ownerReferences[].name), 
                                    issuer: .spec.issuerRef.name, 
                                    readyStatus: (.status.conditions[] | select(.type == "Ready")).status, 
                                    readyMessage: (.status.conditions[] | select(.type == "Ready")).message, 
                                    approvedStatus: (.status.conditions[] | select(.type == "Approved")).status, 
                                    approvedMessage: (.status.conditions[] | select(.type == "Approved")).message} |        # Extract relevant pieces of data
                                    "\nCertificateRequest: \(.certRequest)", 
                                    "Certificate: \(.certificate)", 
                                    "Issuer: \(.issuer)", 
                                    "Ready Status: \(.readyStatus)", 
                                    "Ready Message: \(.readyMessage)", 
                                    "Approved Status: \(.approvedStatus)", 
                                    "Approved Message: \(.approvedMessage)\n------------"' # Output the data 
                                    # in a human readable format

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation for kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Kubernetes Documentation for Certificate Request](https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/#create-a-certificate-signing-request-csr){:target="_blank"}
        - [JSON description](https://www.json.org/){:target="_blank"}
        - [jq website](https://stedolan.github.io/jq/){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/pt-tt-grnwh-cert-health1/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'trouble-town SSL Certificate Health  ';
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