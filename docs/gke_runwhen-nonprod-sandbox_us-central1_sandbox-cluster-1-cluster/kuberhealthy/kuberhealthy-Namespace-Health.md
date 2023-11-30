---
title: "kuberhealthy Namespace Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: kuberhealthy'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/kubernetes/resources/labeled/ns.svg" alt="Icon" />
    </td>
  </tr>
</table>
# kuberhealthy Namespace Health    
<div class="author-block">
  <img src="/github_profile_cache/stewartshea_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/stewartshea" target="_blank">
    <h3 class="author-name">stewartshea</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    9 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 7 days ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-namespace-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-namespace-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Troubleshoot Warning Events in Namespace `kuberhealthy`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command uses the Kubernetes command-line tool kubectl to get and output any warning-level events that are being generated in a particular context and namespace. It will return the events as a json file, which can then be piped through jq to filter and summarize the event information, such as the base object name and total count of warnings, as well as the oldest and most recent timestamps of these warnings. The command will also group the events by their namespace, kind, and object base name. Lastly, the results will only include events that have occurred within the last thirty minutes.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl get events --field-selector type=Warning --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n kuberhealthy -o json > $HOME/warning_events.json && cat $HOME/warning_events.json | jq -r '[.items[] | {namespace: .involvedObject.namespace, kind: .involvedObject.kind, baseName: ((if .involvedObject.kind == "Pod" then (.involvedObject.name | split("-")[:-1] | join("-")) else .involvedObject.name end) // ""), count: .count, firstTimestamp: .firstTimestamp, lastTimestamp: .lastTimestamp, reason: .reason, message: .message}] | group_by(.namespace, .kind, .baseName) | map({object: (.[0].namespace + "/" + .[0].kind + "/" + .[0].baseName), total_events: (reduce .[] as $event (0; . + $event.count)), summary_messages: (map(.message) | unique | join("; ")), oldest_timestamp: (map(.firstTimestamp) | sort | first), most_recent_timestamp: (map(.lastTimestamp) | sort | last)}) | map(select((now - ((.most_recent_timestamp | fromdateiso8601)))/60 <= 30))'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
             > $HOME/warning_events_summary.json

            # This command retrieves events of type Warning and saves it to a file in JSON format.
            # It then does additional processing to group overlapping events, give summary information and filter out events that are more than 30 minutes old.
            # The output is again stored in a JSON file in the user's home directory. 
            #
            # To understand the command better, we can break it down into multiple lines:

            # Retrieve all events of type Warning from requested context & namespace, 
            # save them in $HOME/warning_events.json as JSON
            kubectl get events \
                --field-selector type=Warning \
                --context ${CONTEXT} \
                -n ${NAMESPACE} \
                -o json \
                > $HOME/warning_events.json

            # Perform processing on warning_events.json, produce warning_events_summary.json
            cat $HOME/warning_events.json | \
             jq -r '[.items[] | {namespace: .involvedObject.namespace, kind: .involvedObject.kind, baseName: ((if .involvedObject.kind == "Pod" then (.involvedObject.name | split("-")[:-1] | join("-")) else .involvedObject.name end) // ""), count: .count, firstTimestamp: .firstTimestamp, lastTimestamp: .lastTimestamp, reason: .reason, message: .message}] | \
             group_by(.namespace, .kind, .baseName) | \
             map({object: (.[0].namespace + "/" + .[0].kind + "/" + .[0].baseName), total_events: (reduce .[] as $event (0; . + $event.count)), summary_messages: (map(.message) | unique | join("; ")), oldest_timestamp: (map(.firstTimestamp) | sort | first), most_recent_timestamp: (map(.lastTimestamp) | sort | last)}) | \
             map(select((now - ((.most_recent_timestamp | fromdateiso8601)))/60 <= 30))' \
             > $HOME/warning_events_summary.json

    ???- abstract "Helpful Links"

            
        - [Overview of Kubernetes Events](https://kubernetes.io/docs/reference/using-api/api-concepts/#events){:target="_blank"}
        - [Documentation on `kubectl get events` command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-events){:target="_blank"}
        - [Documentation on field selectors in `kubectl get` commands](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-list-field){:target="_blank"}
        - [Documentation on the jq, a lightweight and flexible command line JSON processor](https://stedolan.github.io/jq/){:target="_blank"}

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
    #### Troubleshoot Container Restarts In Namespace `kuberhealthy`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command uses kubectl to get information about the pods in the specified context and namespace. The -o json argument gets the output in JSON format which is then piped into jq, a program used to parse and manipulate JSON data. The -r argument makes sure that jq doesn't add quotes around strings and the --argjson argument sets up a variable called exit_code_explanations which contains a map of exit codes and their explanations. Finally, jq is used to select all pods that have containers with a restart count greater than 0 and returns the pod name, container name, restart count, message, terminated reason, terminated finished at, the explanation for the exit code, and an "---" so the results are easier to read.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get pods --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n kuberhealthy -o json | jq -r --argjson exit_code_explanations '{"0": "Success", "1": "Error", "2": "Misconfiguration", "130": "Pod terminated by SIGINT", "134": "Abnormal Termination SIGABRT", "137": "Pod terminated by SIGKILL - Possible OOM", "143":"Graceful Termination SIGTERM"}' '.items[] | select(.status.containerStatuses != null) | select(any(.status.containerStatuses[]; .restartCount > 0)) | "---\npod_name: \(.metadata.name)\n" + (.status.containerStatuses[] | "containers: \(.name)\nrestart_count: \(.restartCount)\nmessage: \(.state.waiting.message // "N/A")\nterminated_reason: \(.lastState.terminated.reason // "N/A")\nterminated_finishedAt: \(.lastState.terminated.finishedAt // "N/A")\nterminated_exitCode: \(.lastState.terminated.exitCode // "N/A")\nexit_code_explanation: \($exit_code_explanations[.lastState.terminated.exitCode | tostring] // "Unknown exit code")") + "\n---\n"'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Convert this one-line command into a multi-line command, adding verbose comments to educate new users of Kubernetes and related cli commands 
            # Get pods in a given CONTEXT and NAMESPACE with kubectl
            kubectl get pods \
                --context=${CONTEXT} \ 
                -n ${NAMESPACE} \ 
                -o json

            # Pipe output from kubectl to jq processor
            | jq -r \ 

            # Pass JSON argument containing dictonary key-value pairs mapping exit codes to their explanations
            --argjson exit_code_explanations '{"0": "Success", "1": "Error", "2": "Misconfiguration", "130": "Pod terminated by SIGINT", "134": "Abnormal Termination SIGABRT", "137": "Pod terminated by SIGKILL - Possible OOM", "143":"Graceful Termination SIGTERM"}' \

            # Select any Items from results which have containerStatuses and any of them had restartCount more than 0
            # Also provide information such as pod name, container names, restart count (if greater than 0), message, terminated reason, finished at date and time, 
            # and exit code eith explanations for each item found 
            .items[] | select(.status.containerStatuses != null) | select(any(.status.containerStatuses[]; .restartCount > 0)) | "---\npod_name: \(.metadata.name)\n" + (.status.containerStatuses[] | "containers: \(.name)\nrestart_count: \(.restartCount)\nmessage: \(.state.waiting.message // "N/A")\nterminated_reason: \(.lastState.terminated.reason // "N/A")\nterminated_finishedAt: \(.lastState.terminated.finishedAt // "N/A")\nterminated_exitCode: \(.lastState.terminated.exitCode // "N/A")\nexit_code_explanation: \($exit_code_explanations[.lastState.terminated.exitCode | tostring] // "Unknown exit code")") + "\n---\n"

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation on `kubectl get pods`](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-pods){:target="_blank"}
        - [Kubernetes Documentation on `kubectl get`](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Kubernetes Documentation on the -o parameter](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-o){:target="_blank"}
        - [Kubernetes Documentation on the --context parameter](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#--context){:target="_blank"}
        - [Kubernetes Documentation on the -n parameter](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-n){:target="_blank"}
        - [jq Manual](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    #### Troubleshoot Pending Pods In Namespace `kuberhealthy`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command retrieves a list of pods in Kubernetes, filtered by the context (i.e., which cluster the command is running on) and namespaces (i.e., the projects within the cluster). It also filters for pods with a status of “Pending” and prints out the pod name, status, message, reason, container status, container message, and container reason associated with each pod. The final result is displayed in an organized list format.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```kubectl get pods --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n kuberhealthy --field-selector=status.phase=Pending --no-headers -o json | jq -r '.items[] | "pod_name: \(.metadata.name)\nstatus: \(.status.phase // "N/A")\nmessage: \(.status.conditions[0].message // "N/A")\nreason: \(.status.conditions[0].reason // "N/A")\ncontainerStatus: \((.status.containerStatuses[0].state // "N/A"))\ncontainerMessage: \(.status.containerStatuses[0].state.waiting?.message // "N/A")\ncontainerReason: \(.status.containerStatuses[0].state.waiting?.reason // "N/A")\n------------"'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This is an example command to get the pending pods from a Kubernetes cluster. 
            # It uses two commands ("kubectl" and "jq" ) and prints the output in a nice format.

            # First, use 'kubectl' to get specific information about the pods
            CONTEXT="abc"
            NAMESPACE="xyz"
            kubectl get pods --context=${CONTEXT} -n ${NAMESPACE} --field-selector=status.phase=Pending --no-headers -o json 

            # To make it easier to read, we pipe that output into 'jq' 
            # jq will select only the fields we are interested in and print them in a readable format
            jq -r '.items[] | "pod_name: \(.metadata.name)\nstatus: \(.status.phase // "N/A")\nmessage: \(.status.conditions[0].message // "N/A")\nreason: \(.status.conditions[0].reason // "N/A")\ncontainerStatus: \((.status.containerStatuses[0].state // "N/A"))\ncontainerMessage: \(.status.containerStatuses[0].state.waiting?.message // "N/A")\ncontainerReason: \(.status.containerStatuses[0].state.waiting?.reason // "N/A")\n------------"'

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation for kubectl get pods](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-pods){:target="_blank"}
        - [Kubernetes Documentation for -n flag (namespace)](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Kubernetes Documentation for --field-selector flag](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-list-select){:target="_blank"}
        - [jq manual](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    #### Troubleshoot Failed Pods In Namespace `kuberhealthy`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to get the information about failed Kubernetes pods in a specific context and namespace. It uses kubectl, which is the command line tool for managing resources in Kubernetes clusters. The first part, "kubectl get pods," means to get a list of all the pods (containers) running in the cluster. The parts which come after define how that list will be filtered. The --context option specifies which context to use, so that this list will only include pods running in that context. The -n flag indicates which namespace should be used to filter the results. The --field-selector options filters the list based on the status phase, in this case only returning Failed pods. The --no-headers flag removes any headers from the results and the -o json flag formats the output as JSON. The jq utility then processes the JSON to extract the required information: the name of the pod, how many times it has been restarted, any messages associated with the failure, when the termination occurred, exit code and an explanation of what the exit code means.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```kubectl get pods --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n kuberhealthy --field-selector=status.phase=Failed --no-headers -o json | jq -r --argjson exit_code_explanations '{"0": "Success", "1": "Error", "2": "Misconfiguration", "130": "Pod terminated by SIGINT", "134": "Abnormal Termination SIGABRT", "137": "Pod terminated by SIGKILL - Possible OOM", "143":"Graceful Termination SIGTERM"}' '.items[] | "pod_name: \(.metadata.name)\nrestart_count: \(.status.containerStatuses[0].restartCount // "N/A")\nmessage: \(.status.message // "N/A")\nterminated_finishedAt: \(.status.containerStatuses[0].state.terminated.finishedAt // "N/A")\nexit_code: \(.status.containerStatuses[0].state.terminated.exitCode // "N/A")\nexit_code_explanation: \($exit_code_explanations[.status.containerStatuses[0].state.terminated.exitCode | tostring] // "Unknown exit code")\n------------"'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #This multi-line command will get any failed pods from a given Kubernetes cluster and namespace. It also uses the popular tool "jq" to format this information in a user-friendly way. 
            #In this command, CONTEXT and NAMESPACE should be replaced with the context and namespace of the Kubernetes cluster you'd like to interogate. 
            kubectl get pods \
                --context=${CONTEXT} \ #The context of the Kubernetes cluster you want to check 
                -n ${NAMESPACE} \ #The namespace of the Kubernetes cluster you want to check
                --field-selector=status.phase=Failed \ #Retrieve only pods that are in the Failed state  
                --no-headers \ #Do not print column headers 
                -o json \ #Output results in JSON format 
            | jq -r \ #Pipe JSON results into jq for formatting 
            --argjson exit_code_explanations '{"0": "Success", "1": "Error", "2": "Misconfiguration", "130": "Pod terminated by SIGINT", "134": "Abnormal Termination SIGABRT", "137": "Pod terminated by SIGKILL - Possible OOM", "143":"Graceful Termination SIGTERM"}' #Define an argument containing possible exit codes 
             '.items[] | "pod_name: \(.metadata.name)\nrestart_count: \(.status.containerStatuses[0].restartCount // "N/A")\nmessage: \(.status.message // "N/A")\nterminated_finishedAt: \(.status.containerStatuses[0].state.terminated.finishedAt // "N/A")\nexit_code: \(.status.containerStatuses[0].state.terminated.exitCode // "N/A")\nexit_code_explanation: \($exit_code_explanations[.status.containerStatuses[0].state.terminated.exitCode | tostring] // "Unknown exit code")\n------------"' # Output the fields we are interested in in a user friendly format

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation - kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Kubernetes Documentation - context](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-kubeconfig-environment-variable){:target="_blank"}
        - [Kuebernetes Documentation - namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [jq Manual Page](https://stedolan.github.io/jq/manual/){:target="_blank"}

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




!!! note ""
    <div class="command-title">
    #### Troubleshoot Workload Status Conditions In Namespace `kuberhealthy`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to get a list of pods in a Kubernetes cluster and check their readiness status. It uses the kubectl tool with the "get pods" command, followed by specifying the context and the namespace as arguments. The output is then piped to json using jq so that it can be filtered for specific conditions - notably those where the pod has not been marked as Ready and has completed. Finally, the second jq query transforms the output into a more readable format.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock5">```kubectl get pods --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n kuberhealthy -o json | jq -r '.items[] | select(.status.conditions[]? | select(.type == "Ready" and .status == "False" and .reason != "PodCompleted")) | {kind: .kind, name: .metadata.name, conditions: .status.conditions}' | jq -s '.'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock5" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage5" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Use the kubectl get command to list all pods on the cluster 
            kubectl get pods \
                # specify a specific context if needed
                --context ${CONTEXT} \
                # specify a namespace to restrict results directly
                -n ${NAMESPACE} \
                # convert the output to JSON format (this is necessary for further filtering)
                -o json \
                # "pipe" the output of kubectl as an input to jq command
                | \
                # use jq to filter results and select only those which are not in ready status
                jq -r '.items[] | select(.status.conditions[]? | select(.type == "Ready" and .status == "False" and .reason != "PodCompleted")) 
                # map the output to dictionary containing kind, name and conditions fields
                | {kind: .kind, name: .metadata.name, conditions: .status.conditions}' \
                # flatten results into an an array of objects
                | jq -s '.'

    ???- abstract "Helpful Links"

            
        - [Kubernetes.io - Overview Pods](https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/){:target="_blank"}
        - [Kubernetes.io - kubectl reference](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Stackoverflow - How to get values of sub-objects from JSON using jq](https://stackoverflow.com/questions/44540873/how-to-get-values-of-sub-objects-from-json-using-jq){:target="_blank"}

<script>

document.getElementById('copyCodeBlock5').addEventListener('click', function() {
    copyCodeBlock5();
});

function copyCodeBlock5() {
  var codeBlock = document.getElementById('codeBlock5');
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
  var copiedMessage = document.getElementById('copiedMessage5');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




!!! note ""
    <div class="command-title">
    #### Get Listing Of Resources In Namespace `kuberhealthy`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
     -o yaml

    This command uses the kubectl (Kubernetes Command Line) tool to list out all of the Kubernetes API resources in a given namespace, which is indicated by the --namespaced tag. We are specifying the context of the command with the --context flag and passing it an argument from the CONTEXT variable. Then we use xargs -n 1 to split the output into individual lines and pass each one as an argument to the kubectl get command. The --ignore-not-found flag will cause the command to ignore any resources that don't exist and the --show-kind flag will output the type of resource being listed. Finally, we are setting the output format to YAML with the -o yaml flag at the end.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock6">```kubectl api-resources --verbs=list --namespaced -o name --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster | xargs -n 1 kubectl get --show-kind --ignore-not-found -n kuberhealthy --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock6" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage6" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command retrieves a list of all kubernetes API resources currently available, 
            # filtered for those that use the list verb only in a namespaced manner.
            CONTEXT="mycontext" # Replace with the name of the specific Kubernetes context you need to access
            NAMESPACE="mynamespace" # Replace with the specific namespace you need access to

            # Retrieve a list of api-resources using "list" verb in a namespaced manner
            kubectl \
                api-resources \
                    --verbs=list \
                    --namespaced \
                    -o name \
                    --context=${CONTEXT}

            # Pipe the output into xargs to read the commands line-by-line
            xargs \
                -n 1 \
                kubectl \
                    get \
                        --show-kind \
                        --ignore-not-found \
                        -n ${NAMESPACE} \
                        --context=${CONTEXT}

    ???- abstract "Helpful Links"

            
        - [kubectl overview and examples](https://kubernetes.io/docs/reference/kubectl/overview/){:target="_blank"}
        - [Listing and Describing Resources](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Matching Resources Using Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){:target="_blank"}

<script>

document.getElementById('copyCodeBlock6').addEventListener('click', function() {
    copyCodeBlock6();
});

function copyCodeBlock6() {
  var codeBlock = document.getElementById('codeBlock6');
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
  var copiedMessage = document.getElementById('copiedMessage6');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




!!! note ""
    <div class="command-title">
    #### Check Event Anomalies in Namespace `kuberhealthy`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will query the Kubernetes event system and return a list of all non-Warning type events from the specified namespace and context. The command will take the results and save them in a json file ($HOME/events.json). Next, it uses jq to group the events according to namespace, kind, and object involved. Finally, it filters out only those events which occur more frequently than the anomaly threshold set by the user (ANOMALY_THRESHOLD). This will display any objects that have been generating an unusually high amount of events as anomalies.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock7">```kubectl get events --field-selector type!=Warning --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n kuberhealthy -o json > $HOME/events.json && cat $HOME/events.json | jq -r '[.items[] | {namespace: .involvedObject.namespace, kind: .involvedObject.kind, name: ((if .involvedObject and .involvedObject.kind == "Pod" then (.involvedObject.name | split("-")[:-1] | join("-")) else .involvedObject.name end) // ""), count: .count, firstTimestamp: .firstTimestamp, lastTimestamp: .lastTimestamp, reason: .reason, message: .message}] | group_by(.namespace, .kind, .name) | .[] | {(.[0].namespace + "/" + .[0].kind + "/" + .[0].name): {events: .}}' | jq -r --argjson threshold "5.0" 'to_entries[] | {object: .key, oldest_timestamp: ([.value.events[] | .firstTimestamp] | min), most_recent_timestamp: (reduce .value.events[] as $event (.value.firstTimestamp; if ($event.lastTimestamp > .) then $event.lastTimestamp else . end)), events_per_minute: (reduce .value.events[] as $event (0; . + ($event.count / (((($event.lastTimestamp | fromdateiso8601) - ($event.firstTimestamp | fromdateiso8601)) / 60) | if . == 0 then 1 else . end))) | floor), total_events: (reduce .value.events[] as $event (0; . + $event.count)), summary_messages: [.value.events[] | .message] | unique | join("; ")} | select(.events_per_minute > $threshold)' | jq -s '.'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock7" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage7" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
             | python3 ${AIRGAP}/airgap_scripts/summary.py -

            # Obtain all log and metrics data for the given namespace
            kubectl get events \
              --field-selector type!=Warning \
              --context ${CONTEXT} \
              -n ${NAMESPACE} \
              -o json > $HOME/events.json

            # Process the output using jq to obtain relevant information like namespace, kind, name, count, timestamps, reason, message etc.,
            cat $HOME/events.json | jq -r '[.items[] | {namespace: .involvedObject.namespace, kind: .involvedObject.kind, name: ((if .involvedObject and .involvedObject.kind == "Pod" then (.involvedObject.name | split("-")[:-1] | join("-")) else .involvedObject.name end) // ""), count: .count, firstTimestamp: .firstTimestamp, lastTimestamp: .lastTimestamp, reason: .reason, message: .message}] | group_by(.namespace, .kind, .name) | .[] | {(.[0].namespace + "/" + .[0].kind + "/" + .[0].name): {events: .}}' \

            # Filter the dataset by threshold level defined by user
            | jq -r --argjson threshold "${ANOMALY_THRESHOLD}" 'to_entries[] | {object: .key, oldest_timestamp: ([.value.events[] | .firstTimestamp] | min), most_recent_timestamp: (reduce .value.events[] as $event (.value.firstTimestamp; if ($event.lastTimestamp > .) then $event.lastTimestamp else . end)), events_per_minute: (reduce .value.events[] as $event (0; . + ($event.count / (((($event.lastTimestamp | fromdateiso8601) - ($event.firstTimestamp | fromdateiso8601)) / 60) | if . == 0 then 1 else . end))) | floor), total_events: (reduce .value.events[] as $event (0; . + $event.count)), summary_messages: [.value.events[] | .message] | unique | join("; ")} | select(.events_per_minute > $threshold)' \

            # Convert the dataset into valid JSON array
            | jq -s '.' \

            # Validate and summarize the dataset using python3 script
            | python3 ${AIRGAP}/airgap_scripts/summary.py -

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation - Getting Started with kubectl](https://kubernetes.io/docs/getting-started-guides/kubectl/){:target="_blank"}
        - [Kubernetes Documentation - kubectl Reference](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [jq Manual - Expression Selectors](https://stedolan.github.io/jq/manual/#Expressionselectors){:target="_blank"}
        - [jq Manual - Types and Values](https://stedolan.github.io/jq/manual/#Typesandvalues){:target="_blank"}
        - [jq Manual - Functions](https://stedolan.github.io/jq/manual/#Functions){:target="_blank"}

<script>

document.getElementById('copyCodeBlock7').addEventListener('click', function() {
    copyCodeBlock7();
});

function copyCodeBlock7() {
  var codeBlock = document.getElementById('codeBlock7');
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
  var copiedMessage = document.getElementById('copiedMessage7');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




!!! note ""
    <div class="command-title">
    #### Troubleshoot Services And Application Workloads in Namespace `kuberhealthy`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command gathers any errors in the logs of services running in Kubernetes clusters. The command uses the `kubectl` commands to get a list of services, and then look at their recent logs for errors, based on a pattern specified. If there are entries that match, they are outputted to a file `logs.json`, which is read and filtered, grouped by service name and ordered based on the number of times a log has appeared. Finally, the most common 3 messages are outputted to a file `$HOME/output`.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock8">```services=($(kubectl get svc -o=name --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n kuberhealthy)) && [ ${#services[@]} -eq 0 ] && echo "No services found." || { > "logs.json"; for service in "${services[@]}"; do kubectl logs $service --limit-bytes=256000 --since=2h --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n kuberhealthy 2>/dev/null | grep -Ei "(Error:)" | grep -Ev "(node_modules|opentelemetry)" | while read -r line; do service_name="${service#*/}"; message=$(echo "$line" | jq -aRs .); printf '{"service": "%s", "message": %s}\n' "${service_name}" "$message" >> "logs.json"; done; done; [ ! -s "logs.json" ] && echo "No log entries found." || cat "logs.json" | jq -s '[ (group_by(.service) | map({service: .[0].service, total_logs: length})), (group_by(.service) | map({service: .[0].service, top_logs: (group_by(.message[0:200]) | map({message_start: .[0].message[0:200], count: length}) | sort_by(.count) | reverse | .[0:3])})) ] | add'; } > $HOME/output; cat $HOME/output```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock8" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage8" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command uses the kubectl CLI to collect service logs in Kubernetes. It retrieves data from the specified namespace with context of ${CONTEXT}.
            services=($(kubectl get svc -o=name --context=${CONTEXT} -n ${NAMESPACE}))  # Retrieve services from the specified namespace and context

            if [ ${#services[@]} -eq 0 ]; then  # If no services are found, display a 'No services found.' log message
                echo "No services found."  
            else  # Otherwise, start processing the service logs
                # Create an empty log file to store results
                > "logs.json"

                # Iterate through each service to retrieve their logs
                for service in "${services[@]}"; do
                    kubectl logs $service --limit-bytes=256000 --since=2h --context=${CONTEXT} -n ${NAMESPACE} 2>/dev/null | grep -Ei "${SERVICE_ERROR_PATTERN}" | grep -Ev "${SERVICE_EXCLUDE_PATTERN}" \
                        | while read -r line; do              # In each log item, filter out the items that match the error pattern and exclude patterns
                        service_name="${service#*/}"           # Extract the service name from the full path
                        message=$(echo "$line" | jq -aRs .)    # Retrieve log content as JSON object
                        # Append each log item to the output file as a JSON object containing the service name and log message
                        printf '{"service": "%s", "message": %s}\n' "${service_name}" "$message" >> "logs.json"
                    done;
                done;

                if [ ! -s "logs.json" ]; then  # After retrieving logs, check whether any log items were saved
                    echo "No log entries found."  # If there are none, display a 'No log entries found.' log message
                else
                    # Otherwise process the saved log items into a formatted output
                    cat "logs.json" | jq -s '[ (group_by(.service) | map({service: .[0].service, total_logs: length})), (group_by(.service) | map({service: .[0].service, top_logs: (group_by(.message[0:200]) | map({message_start: .[0].message[0:200], count: length}) | sort_by(.count) | reverse | .[0:3])})) ] | add' > $HOME/output;

                    # Output the log entries in the formatted output
                    cat $HOME/output
                fi
            fi

    ???- abstract "Helpful Links"

            
        - [Learn about the service and object types in Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/){:target="_blank"}
        - [Review the options available for the kubectl get command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get_cluster-wide-resources){:target="_blank"}
        - [Review the flags that the kubectl logs command supports](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs){:target="_blank"}
        - [Reference manual for the jq command line tool](https://stedolan.github.io/jq/manual/){:target="_blank"}

<script>

document.getElementById('copyCodeBlock8').addEventListener('click', function() {
    copyCodeBlock8();
});

function copyCodeBlock8() {
  var codeBlock = document.getElementById('codeBlock8');
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
  var copiedMessage = document.getElementById('copiedMessage8');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




!!! note ""
    <div class="command-title">
    #### Check Missing or Risky PodDisruptionBudget Policies in Namepace `kuberhealthy`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This Kubernetes command checks the health of the deployments and statefulsets in a given context and namespace. It displays the status of each deployment/statefulset and the Pod Disruption Budgets (PDBs) associated with it. 

    The first set of lines calls the check_health () function to extract information about the pods within each deployment and compare the min available and max unavailable metrics with the replicas value. If there is a mismatch, it displays a 'Risky' or 'OK' message accordingly. 

    The final line runs a query which returns the name of the deployment or statefulset as well as their respective replication factors and selectors. This allows us to then loop through each deployment/statefulset and call the check_health function to get their status.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock9">```context="gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster"; namespace="kuberhealthy"; check_health() { local type=$1; local name=$2; local replicas=$3; local selector=$4; local pdbs=$(kubectl --context "$context" --namespace "$namespace" get pdb -o json | jq -c --arg selector "$selector" '.items[] | select(.spec.selector.matchLabels | to_entries[] | .key + "=" + .value == $selector)'); if [[ $replicas -gt 1 && -z "$pdbs" ]]; then printf "%-30s %-30s %-10s\n" "$type/$name" "" "Missing"; else echo "$pdbs" | jq -c . | while IFS= read -r pdb; do local pdbName=$(echo "$pdb" | jq -r '.metadata.name'); local minAvailable=$(echo "$pdb" | jq -r '.spec.minAvailable // ""'); local maxUnavailable=$(echo "$pdb" | jq -r '.spec.maxUnavailable // ""'); if [[ "$minAvailable" == "100%" || "$maxUnavailable" == "0" || "$maxUnavailable" == "0%" ]]; then printf "%-30s %-30s %-10s\n" "$type/$name" "$pdbName" "Risky"; elif [[ $replicas -gt 1 && ("$minAvailable" != "100%" || "$maxUnavailable" != "0" || "$maxUnavailable" != "0%") ]]; then printf "%-30s %-30s %-10s\n" "$type/$name" "$pdbName" "OK"; fi; done; fi; }; echo "Deployments:"; echo "-----------"; printf "%-30s %-30s %-10s\n" "NAME" "PDB" "STATUS"; kubectl --context "$context" --namespace "$namespace" get deployments -o json | jq -c '.items[] | "\(.metadata.name) \(.spec.replicas) \(.spec.selector.matchLabels | to_entries[] | .key + "=" + .value)"' | while read -r line; do check_health "Deployment" $(echo $line | tr -d '"'); done; echo ""; echo "Statefulsets:"; echo "-------------"; printf "%-30s %-30s %-10s\n" "NAME" "PDB" "STATUS"; kubectl --context "$context" --namespace "$namespace" get statefulsets -o json | jq -c '.items[] | "\(.metadata.name) \(.spec.replicas) \(.spec.selector.matchLabels | to_entries[] | .key + "=" + .value)"' | while read -r line; do check_health "StatefulSet" $(echo $line | tr -d '"'); done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock9" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage9" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command evaluates the Kubernetes PPeriodic Backup (PDB) status for given deployments and stateful sets in a namespace. It verifies that the deployment and/or statefulSet(s) meet the minimum required configurations for their respective workloads. 

            # Step 1: Setting up variables
            CONTEXT="${CONTEXT}";
            NAMESPACE="${NAMESPACE}";

            # Step 2: Defining the check_health function. This function tests if the PDBs of the given workload are correctly configured
            check_health() {

                # Step 2a: getting value of required parameters
                local type=$1;
                local name=$2;
                local replicas=$3;
                local selector=$4;

                # Step 2b: In order to test the correctness of the PDB configuration, we need to get the associated PDBs for the specified workload using jq. We use 'kubectl' to get the Pod Disruption Budgets (PDBs) related to the workload
                local pdbs=$(kubectl --context "$context" --namespace "$namespace" get pdb -o json | jq -c --arg selector "$selector" '.items[] | select(.spec.selector.matchLabels | to_entries[] | .key + "=" + .value == $selector)');

                # Step 2c: If the number of replicas for the given workload is greater than 1 and no pod disruption budget is found, then the workload does not have a minimum safe/correct configuration  
                if [[ $replicas -gt 1 && -z "$pdbs" ]]; then

                    # Print appropriate message
                    printf "%-30s %-30s %-10s\n" "$type/$name" "" "Missing";

                else
                    
                    # Step 2d: Iterate through each found POD disruption budget
                    echo "$pdbs" | jq -c . | while IFS= read -r pdb; do

                        # Step 2e: Get the name of the Pod Disruption Budget
                        local pdbName=$(echo "$pdb" | jq -r '.metadata.name');

                        # Step 2f: Get the minAvailable and maxUnavailable values from the PDB specification
                        local minAvailable=$(echo "$pdb" | jq -r '.spec.minAvailable // ""');
                        local maxUnavailable=$(echo "$pdb" | jq -r '.spec.maxUnavailable // ""');

                        # Step 2g: Check if the values for the PDB specifications meet the recommended criteria
                        if [[ "$minAvailable" == "100%" || "$maxUnavailable" == "0" || "$maxUnavailable" == "0%" ]]; then

                            # Step 2h: If the values dont meet the recommended criteria, print out an appropriate message
                            printf "%-30s %-30s %-10s\n" "$type/$name" "$pdbName" "Risky";

                        # Step 2i: If the number of replicas for the given  workload is greater than 1 and the values meet the recommended criteria
                        elif [[ $replicas -gt 1 && ("$minAvailable" != "100%" || "$maxUnavailable" != "0" || "$maxUnavailable" != "0%") ]]; then
                            
                            # Step 2j: Print out an appropriate message
                            printf "%-30s %-30s %-10s\n" "$type/$name" "$pdbName" "OK";
                        fi;
                    done;
                fi;
            };

            # Step 3: Evaluating health of deployments
            echo "Deployments:";
            echo "-----------";

            # Step 3a: Represeted the columns for output messages
            printf "%-30s %-30s %-10s\n" "NAME" "PDB" "STATUS";

            # Step 3b: Iterate through deployments present in the context and namespace using kubectl and jq
            kubectl --context "$context" --namespace "$namespace" get deployments -o json | jq -c '.items[] | "\(.metadata.name) \(.spec.replicas) \(.spec.selector.matchLabels | to_entries[] | .key + "=" + .value)"' | while read -r line; do

                # Step 3c: Invoke the check_health with relevant parameters
                check_health "Deployment" $(echo $line | tr -d '"');
            done;

            # Step 4: Leaving a blank line for better readability
            echo "";

            # Step 5: Evaluating health of StatefulSets
            echo "Statefulsets:";
            echo "-------------";

            # Step 5a: Represented the columns for output messages
            printf "%-30s %-30s %-10s\n" "NAME" "PDB" "STATUS";

            # Step 5b: Iterate through stateful sets present in the context and namespace using kubectl and jq
            kubectl --context "$context" --namespace "$namespace" get statefulsets -o json | jq -c '.items[] | "\(.metadata.name) \(.spec.replicas) \(.spec.selector.matchLabels | to_entries[] | .key + "=" + .value)"' | while read -r line; do

                # Step 5c: Invoke the check_health with relevant parameters
                check_health "StatefulSet" $(echo $line | tr -d '"');
            done

    ???- abstract "Helpful Links"

            
        - [Kubernetes Pod Disruption Budget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/){:target="_blank"}
        - [JQ Manual](https://stedolan.github.io/jq/manual/){:target="_blank"}
        - [Kubernetes Deployments Overview](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/){:target="_blank"}
        - [Kubernetes StatefulSets Overview](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){:target="_blank"}

<script>

document.getElementById('copyCodeBlock9').addEventListener('click', function() {
    copyCodeBlock9();
});

function copyCodeBlock9() {
  var codeBlock = document.getElementById('codeBlock9');
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
  var copiedMessage = document.getElementById('copiedMessage9');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/kbrhlt-grnwhnnprsndbucntrl-ns-health/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'kuberhealthy Namespace Health  ';
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