---
title: "voteers-Kong Ingress HTTP Errors  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: trouble-town'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/kong-logomark-color.svg" alt="Icon" />
    </td>
  </tr>
</table>
# voteers-Kong Ingress HTTP Errors    
<div class="author-block">
  <img src="/github_profile_cache/stewartshea_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/stewartshea" target="_blank">
    <h3 class="author-name">stewartshea</a></h3>
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
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/curl-gmp-kong-ingress-inspection/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+curl-gmp-kong-ingress-inspection" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Check If Kong Ingress HTTP Error Rate Violates HTTP Error Threshold  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to check the rate of HTTP errors for a particular service in the Kubernetes platform. It uses credentials from the Google application credentials file ($GOOGLE_APPLICATION_CREDENTIALS) and makes an API call to the Google Monitoring API to get the rate of HTTP errors for a specified service over a given time period. It then checks if the rate exceeds a given threshold, and if it does, will output a message listing the route, service, Kong instance, and the HTTP error count that exceeded the threshold. If the rate does not exceed the threshold, it will output a message saying there were no HTTP error threshold violations found.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```response=$(curl -s -d "query=rate(kong_http_requests_total{service='trouble-town.voteers.voteservice.80',code=~'5.*'}[1m]) > 0.5" -H "Authorization: Bearer $(gcloud auth print-access-token)" 'https://monitoring.googleapis.com/v1/projects/runwhen-nonprod-sandbox/location/global/prometheus/api/v1/query') && echo "$response" | jq -e '.data.result | length > 0' && echo "$response" | jq -r '.data.result[] | "Route:" + .metric.route + " Service:" + .metric.service + " Kong Instance:" + .metric.instance + " HTTP Error Count:" + .value[1]' || echo "No HTTP Error threshold violations found for trouble-town.voteers.voteservice.80."```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Authenticate with the Google Cloud Service Account using the Application Credentials files from the $GOOGLE_APPLICATION_CREDENTIALS environment variable 
            gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS

            # Store the response from the Monitoring API Query
            response=$(curl -s -d "query=rate(kong_http_requests_total{service='${INGRESS_SERVICE}',code=~'${HTTP_ERROR_CODES}'}[${TIME_SLICE}]) > ${HTTP_ERROR_RATE_THRESHOLD}" \ 
                            -H "Authorization: Bearer $(gcloud auth print-access-token)" \ 
                            'https://monitoring.googleapis.com/v1/projects/runwhen-nonprod-sandbox/location/global/prometheus/api/v1/query')

            # Use jq to extract the query results and check that at least one result returned
            echo "$response" | jq -e '.data.result | length > 0'

            # If a result was found, use jq to print a summary detailing the route, service, kong instance and http error count
            echo "$response" | jq -r '.data.result[] | "Route:" + .metric.route + " Service:" + .metric.service + " Kong Instance:" + .metric.instance + " HTTP Error Count:" + .value[1]'

            # If no results were found, echo that no errors were found for the ingress service
            || echo "No HTTP Error threshold violations found for ${INGRESS_SERVICE}."

    ???- abstract "Helpful Links"

            
        - [gcloud auth activate-service-account command documentation](https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account){:target="_blank"}
        - [curl command documentation](https://curl.haxx.se/docs/){:target="_blank"}
        - [jq command documentation](https://stedolan.github.io/jq/){:target="_blank"}

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
    #### Check If Kong Ingress HTTP Request Latency Violates Threshold  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to monitor the performance of services running on Kubernetes. ItRetrieves Kubernetes metrics from a Prometheus monitoring service. This specific command is checking the latency of requests sent to a certain service, and alerting if the latency exceeds a given threshold. Specifically, it checks for the cumulative histogram rate of response latency for a given service over a certain time period. The exact value that must be exceeded is indicated in the $REQUEST_LATENCY_THRESHOLD variable, while the service being monitored is indicated by the $INGRESS_SERVICE variable and the length of time is indicated by the $TIME_SLICE variable. If any results come back from the query indicating a request latency beyond the threshold, they are printed out with the Service and Request Latency values. Otherwise, a message stating that there were no threshold violations is printed.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```response=$(curl -s -d "query=histogram_quantile(0.99, sum(rate(kong_request_latency_ms_bucket{service='trouble-town.voteers.voteservice.80'}[1m])) by (le)) > 100" -H "Authorization: Bearer $(gcloud auth print-access-token)" 'https://monitoring.googleapis.com/v1/projects/runwhen-nonprod-sandbox/location/global/prometheus/api/v1/query') && echo "$response" | jq -e '.data.result | length > 0' && echo "$response" | jq -r '.data.result[] | "Service: trouble-town.voteers.voteservice.80" + " HTTP Request Latency(ms):" + .value[1]' || echo "No HTTP request latency threshold violations found for trouble-town.voteers.voteservice.80."```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Use the gcloud command to authenticate to the GCP project 
            gcloud auth activate-service-account \
                --key-file=$GOOGLE_APPLICATION_CREDENTIALS 

            # Fetch metrics from StackDriver Monitoring API and store result in response variable 
            response=$(curl -s -d "query=histogram_quantile(0.99, sum(rate(kong_request_latency_ms_bucket{service='${INGRESS_SERVICE}'}[${TIME_SLICE}])) by (le)) > ${REQUEST_LATENCY_THRESHOLD}" \
                -H "Authorization: Bearer $(gcloud auth print-access-token)" \
                'https://monitoring.googleapis.com/v1/projects/runwhen-nonprod-sandbox/location/global/prometheus/api/v1/query')

            # Validate whether or not metric fetch was successful 
            if echo "$response" | jq -e '.data.result | length > 0' 
            then
                # If successful, parse and format JSON to display as output 
                echo "$response" | jq -r '.data.result[] | "Service: ${INGRESS_SERVICE}" + " HTTP Request Latency(ms):" + .value[1]' 
            else 
                # Otherwise, display friendly message if no violations found
                echo "No HTTP request latency threshold violations found for ${INGRESS_SERVICE}."
            fi

    ???- abstract "Helpful Links"

            
        - [gcloud Auth Documentation](https://cloud.google.com/sdk/gcloud/reference/auth/){:target="_blank"}
        - [Activate Service Account Documentation](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#iam-service-account-keys-create){:target="_blank"}
        - [curl Documentation](https://curl.haxx.se/docs/){:target="_blank"}
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
    #### Check If Kong Ingress Controller Reports Upstream Errors  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to check the status of health checks for an upstream service in a Kubernetes cluster. Specifically, it checks if the health checks of a particular service called "INGRESS_UPSTREAM" are currently enabled or disabled. The command utilizes Google Cloud's Authentication Service, which requires the user to enter their credentials from the Google Application Credentials file. After authenticating, a curl request is sent to the Monitoring API from Google Cloud and stores the response in a variable called "response". Lastly, the command uses the jq utility to parse the response and determine whether or not the healthchecks for the specified upstream service are enabled or disabled. If the result is greater than zero, then the healthchecks are disabled, and the user will be notified. Otherwise, the service has healthchecks enabled.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```response=$(curl -s -d "query=kong_upstream_target_health{upstream='voteservice.trouble-town.80',state='healthchecks_off'} > 0" -H "Authorization: Bearer $(gcloud auth print-access-token)" 'https://monitoring.googleapis.com/v1/projects/runwhen-nonprod-sandbox/location/global/prometheus/api/v1/query') && echo "$response" | jq -e '.data.result | length > 0' && echo "$response" | jq -r '.data.result[] | "Service: voteservice.trouble-town.80" + " Healthchecks Disabled!' || echo "voteservice.trouble-town.80 has healthchecks enabled."```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            '

            #Authenticate user (activate service account) to Google Cloud Platform with specified key file
            gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS 

            #Create a Curl request which sends the query "kong_upstream_target_health{upstream='${INGRESS_UPSTREAM}',state='healthchecks_off'} > 0" to Monitoring API v1 of GCP, along with an Authorization header containing the print access token with each request
            response=$(curl -s \
            -d "query=kong_upstream_target_health{upstream='${INGRESS_UPSTREAM}',state='healthchecks_off'} > 0" \
            -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            'https://monitoring.googleapis.com/v1/projects/runwhen-nonprod-sandbox/location/global/prometheus/api/v1/query')

            #Query results piped to jq to determine if length is greater than 0, prints out "Service: ${INGRESS_UPSTREAM} Healthchecks Disabled!" if true or "${INGRESS_UPSTREAM} has healthchecks enabled." if false
            echo "$response" | jq -e '.data.result | length > 0' && echo "$response" | jq -r '.data.result[] | "Service: ${INGRESS_UPSTREAM}" + " Healthchecks Disabled!" || echo "${INGRESS_UPSTREAM} has healthchecks enabled."'

    ???- abstract "Helpful Links"

            
        - [GCloud Authentication documentation](https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account){:target="_blank"}
        - [Curl Documentation](https://curl.haxx.se/docs/){:target="_blank"}
        - [jq Command Line JSON Processor Documentation](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    #### Check If Kong Ingress Controller Reports Upstream Errors  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to check the status of health checks for an upstream service in a Kubernetes cluster. Specifically, it checks if the health checks of a particular service called "INGRESS_UPSTREAM" are currently enabled or disabled. The command utilizes Google Cloud's Authentication Service, which requires the user to enter their credentials from the Google Application Credentials file. After authenticating, a curl request is sent to the Monitoring API from Google Cloud and stores the response in a variable called "response". Lastly, the command uses the jq utility to parse the response and determine whether or not the healthchecks for the specified upstream service are enabled or disabled. If the result is greater than zero, then the healthchecks are disabled, and the user will be notified. Otherwise, the service has healthchecks enabled.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```response=$(curl -s -d "query=kong_upstream_target_health{upstream='voteservice.trouble-town.80',state=~'dns_error|unhealthy'} > 0" -H "Authorization: Bearer $(gcloud auth print-access-token)" 'https://monitoring.googleapis.com/v1/projects/runwhen-nonprod-sandbox/location/global/prometheus/api/v1/query') && echo "$response" | jq -e '.data.result | length > 0' && echo "$response" | jq -r '.data.result[] | "Issue detected with Service: voteservice.trouble-town.80" + " Healthcheck subsystem-state: " + .metric.subsystem + "-" + .metric.state + " Target: " + .metric.target' || echo "voteservice.trouble-town.80 is reported as healthy from the Kong ingress controller."```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            '

            #Authenticate user (activate service account) to Google Cloud Platform with specified key file
            gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS 

            #Create a Curl request which sends the query "kong_upstream_target_health{upstream='${INGRESS_UPSTREAM}',state='healthchecks_off'} > 0" to Monitoring API v1 of GCP, along with an Authorization header containing the print access token with each request
            response=$(curl -s \
            -d "query=kong_upstream_target_health{upstream='${INGRESS_UPSTREAM}',state='healthchecks_off'} > 0" \
            -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            'https://monitoring.googleapis.com/v1/projects/runwhen-nonprod-sandbox/location/global/prometheus/api/v1/query')

            #Query results piped to jq to determine if length is greater than 0, prints out "Service: ${INGRESS_UPSTREAM} Healthchecks Disabled!" if true or "${INGRESS_UPSTREAM} has healthchecks enabled." if false
            echo "$response" | jq -e '.data.result | length > 0' && echo "$response" | jq -r '.data.result[] | "Service: ${INGRESS_UPSTREAM}" + " Healthchecks Disabled!" || echo "${INGRESS_UPSTREAM} has healthchecks enabled."'

    ???- abstract "Helpful Links"

            
        - [GCloud Authentication documentation](https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account){:target="_blank"}
        - [Curl Documentation](https://curl.haxx.se/docs/){:target="_blank"}
        - [jq Command Line JSON Processor Documentation](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/v-t-g-kong-ing-health/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'voteers-Kong Ingress HTTP Errors  ';
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